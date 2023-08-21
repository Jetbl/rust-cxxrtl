import os
import json
from fud import errors
from fud.stages import Stage, SourceType, Source
from fud.utils import shell, Conversions, TmpDir
from enum import Enum

from pathlib import Path

class YosystbOutput(Enum):
    DAT = 0
    VCD = 1

class YosystbExecBase(Stage):
    """
    Execute a Filament generated verilog program through the yosystb testbench
    """

    name = "yosystb"

    def __init__(self, target_state, out, description):
        self.out = out
        super().__init__(
            src_state="filament",
            target_state=target_state,
            input_type=SourceType.Path,
            output_type=SourceType.Stream,
            description=description,
        )

    @staticmethod
    def pre_install():
        pass

    @staticmethod
    def defaults():
        root = Path(__file__).parent.parent.resolve()
        exec = (root / "target" / "debug" / "cxxrtl-sim").resolve()
        return {
            "exec": str(exec),
        }

    def save_file(self, builder, stream, dir, filename):
        """
        Save a file to the given location
        """

        @builder.step(f"Save {{file}} to {{dir}}/{filename}")
        def save(
            stream: SourceType.String, dir: SourceType.Directory
        ) -> SourceType.Path:
            save_loc = Path(dir.name) / filename
            with open(save_loc, "w") as out:
                out.write(stream)
            return Source.path(save_loc)

        return save(stream, dir)

    def _define_steps(self, input, builder, config) -> Source:

        def transform_data(data_path, dir):
            """
            Transform data in data_path from having binary/hex encoding into decimal.
            Creates a new file inside dir, which should be a temp directory.
            """
            data = str(data_path)
            file_orig = open(data)
            file_new = open(dir.name + Path(data).stem + ".json", "w")
            data_dict = json.load(file_orig)

            # iterate through data
            for key in data_dict:
                # for each item in the json object, check if it needs to be transformed
                for i in range(len(data_dict[key])):
                    val = data_dict[key][i]
                    # if it is a string, check if it is in binary or hex
                    if isinstance(val,str):
                        if val.startswith('0b'): # binary format
                            binary_data = val[2:]
                            try:
                                conv = int(binary_data,2)
                            except ValueError:
                                raise errors.InvalidNumericType("\"" + str(val) + "\"" + " in " + data)
                        elif val.startswith('0x'): # hex format
                            binary_data = val[2:]
                            try:
                                conv = int(binary_data,16)
                            except ValueError:
                                raise errors.InvalidNumericType("\"" + str(val) + "\"" + " in " + data)
                        else: # none of the above -> unsupported
                            raise errors.InvalidNumericType("\"" + str(val) + "\"" + " in " + data)
                    else: # already in decimal
                        conv = val
                    # update info in json
                    data_dict[key][i] = conv
            json_obj = json.dumps(data_dict,indent=4)
            file_new.write(json_obj)
            return Path(file_new.name).resolve()

        @builder.step()
        def get_data() -> SourceType.Path:
            """Get data for execution"""
            name = ["stages", self.name, "data"]
            data = config.get(name)
            if data is None:
                raise errors.MissingDynamicConfiguration(".".join(name))

            # return absolute path to the file
            return Path(data).resolve()

        @builder.step()
        def copy_file(
            path: SourceType.Path, dir: SourceType.Directory, file: SourceType.String
        ):
            """
            Copy the file to the given directory
            """
            shutil.copy(path, Path(dir.name) / file)

        @builder.step()
        def mktmp() -> SourceType.Directory:
            """Make a temporary directory"""
            return TmpDir()

        @builder.step()
        def data_gen(file: SourceType.Path, dir: SourceType.Directory) -> SourceType.Stream:
            """
            Generate data file in dir with binary/hex converted to decimal
            """
            data_transformed = transform_data(file, dir)
            cmd = " ".join(
                [
                    "cat ",
                    "{path}"
                ]
            )
            return shell(cmd.format(path = data_transformed))

        @builder.step()
        def interface_gen(file: SourceType.Path) -> SourceType.Stream:
            """
            Generate the interface file for the Filament program
            """
            cmd = " ".join(
                [
                    config["stages","filament","exec"],
                    "--library",
                    config["stages","filament","library"],
                    "--dump-interface",
                    "{path}",
                ]
            )
            return shell(cmd.format(path=file))

        @builder.step()
        def run(
            dir: SourceType.String, interface: SourceType.Path, data: SourceType.Path
        ) -> SourceType.Stream:
            """
            Run the simulation
            """
            # Switch to the tmpdir
            os.chdir(Path(dir))
            # Randomize value
            randomize = config.get(["stages", self.name, "randomize"])
            # Number of reset cycles
            reset_cycles = config.get(["stages", self.name, "reset-cycles"])

            # signed outputs
            signed_outputs = config.get(["stages", self.name, "signed-outputs"])

            cmd = " ".join(
                [
                    config["stages", self.name, "exec"],
                    f"-i={interface.data}",
                    f"-v=out.sv",
                    f"-d={data.data}",
                    f"--reset-cycles={int(reset_cycles)}" if reset_cycles is not None else "",
                    f"--randomize={int(randomize)}" if randomize is not None else "",
                    f"--signed-outputs={signed_outputs}" if signed_outputs is not None else "",
                    "--vcd" if self.out == YosystbOutput.VCD else "",
                 ]
            )
           
            return shell(cmd)

        @builder.step()
        def read_vcd(dir: SourceType.String) -> SourceType.String:
            """
            Read the vcd file
            """
            with open(Path(dir) / "out.vcd", "r") as f:
                return f.read()

        # Schedule the program
        data = get_data()
        dir = mktmp()
        # copy_harness(dir)
        mb_verilog = config.get(["stages", self.name, "verilog"])

        # If yosystb.verilog is defined, use that instead of the generating verilog
        if mb_verilog is not None:
            copy_file(Source.path(mb_verilog), dir, Source("out.sv", SourceType.String))
        else:
            # Compile the Filament program to verilog
            path = config.registry.make_path("filament", "verilog")
            builder.ctx.append("to_verilog")
            verilog_stream = builder.also_do_path(input, path, config)
            builder.ctx.pop()
            # Save the verilog stream into the temporary directory
            self.save_file(builder, verilog_stream, dir, "out.sv")

        # Generate the interface file
        interface_stream = interface_gen(input)
        interface_path = self.save_file(
            builder, interface_stream, dir, "interface.json"
        )

        # Generate modified data file
        data_stream = data_gen(data, dir)
        data_path = self.save_file(builder,data_stream,dir,"data_1.json")

        # Run the program
        out = run(dir, interface_path, data_path)
        return out

class YosystbVCD(YosystbExecBase):
    """
    Execute a Filament generated verilog program through the yosystb testbench
    """

    def __init__(self):
        super().__init__(
            target_state="yosystb-vcd",
            out=YosystbOutput.VCD,
            description="Run a Filament program through the yosystb testbench and generate a VCD",
        )


class YosystbOut(YosystbExecBase):
    """
    Execute a Filament generated verilog program through the yosystb testbench
    """

    def __init__(self):
        super().__init__(
            target_state="yosystb-out",
            out=YosystbOutput.DAT,
            description="Run a Filament program through the yosystb testbench and generate output",
        )


# Export the defined stages to fud
__STAGES__ = [YosystbOut, YosystbVCD]
