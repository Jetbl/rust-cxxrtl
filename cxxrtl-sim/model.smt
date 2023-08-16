; Command:
; > z3 -in -smt2 -t:30000

(define-fun max ( 
(x Int) 
(y Int) 
) Int
   (ite (< x y) y x)
)

(define-fun min ( 
(x Int) 
(y Int) 
) Int
   (ite (> x y) y x)
)

(define-fun abs ( 
(x Int) 
) Int
   (ite (< x 0) (- x) x)
)

(declare-fun pow2 ( 
Int 
) Int)

(declare-fun log2 ( 
Int 
) Int)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 1))
)

(declare-fun |rsmt2 actlit 0| () Bool)

(assert (=> |rsmt2 actlit 0|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 0|
) )

(assert (not |rsmt2 actlit 0|) )

(declare-fun |rsmt2 actlit 1| () Bool)

(assert (=> |rsmt2 actlit 1|
    (not (> (+ L 0) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 1|
) )

(assert (not |rsmt2 actlit 1|) )

(declare-fun |rsmt2 actlit 2| () Bool)

(assert (=> |rsmt2 actlit 2|
    (not (>= (abs (- (+ L 0) (+ G 1))) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 2|
) )

(assert (not |rsmt2 actlit 2|) )

(declare-fun |rsmt2 actlit 3| () Bool)

(assert (=> |rsmt2 actlit 3|
    (not (>= (abs (- (+ L 0) (+ G 1))) (abs (- (+ L 0) (+ G 1)))))
))

(check-sat-assuming (
 |rsmt2 actlit 3|
) )

(assert (not |rsmt2 actlit 3|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-fun |rsmt2 actlit 4| () Bool)

(assert (=> |rsmt2 actlit 4|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 4|
) )

(assert (not |rsmt2 actlit 4|) )

(declare-fun |rsmt2 actlit 5| () Bool)

(assert (=> |rsmt2 actlit 5|
    (not (> (+ G 2) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 5|
) )

(assert (not |rsmt2 actlit 5|) )

(declare-fun |rsmt2 actlit 6| () Bool)

(assert (=> |rsmt2 actlit 6|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 6|
) )

(assert (not |rsmt2 actlit 6|) )

(declare-fun |rsmt2 actlit 7| () Bool)

(assert (=> |rsmt2 actlit 7|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 7|
) )

(assert (not |rsmt2 actlit 7|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const SAFE Int)

(assert
    (>= SAFE 0)
)

(declare-fun |rsmt2 actlit 8| () Bool)

(assert (=> |rsmt2 actlit 8|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 8|
) )

(assert (not |rsmt2 actlit 8|) )

(declare-fun |rsmt2 actlit 9| () Bool)

(assert (=> |rsmt2 actlit 9|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 9|
) )

(assert (not |rsmt2 actlit 9|) )

(declare-fun |rsmt2 actlit 10| () Bool)

(assert (=> |rsmt2 actlit 10|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 10|
) )

(assert (not |rsmt2 actlit 10|) )

(declare-fun |rsmt2 actlit 11| () Bool)

(assert (=> |rsmt2 actlit 11|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 11|
) )

(assert (not |rsmt2 actlit 11|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const SAFE Int)

(assert
    (>= SAFE 0)
)

(declare-fun |rsmt2 actlit 12| () Bool)

(assert (=> |rsmt2 actlit 12|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 12|
) )

(assert (not |rsmt2 actlit 12|) )

(declare-fun |rsmt2 actlit 13| () Bool)

(assert (=> |rsmt2 actlit 13|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 13|
) )

(assert (not |rsmt2 actlit 13|) )

(declare-fun |rsmt2 actlit 14| () Bool)

(assert (=> |rsmt2 actlit 14|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 14|
) )

(assert (not |rsmt2 actlit 14|) )

(declare-fun |rsmt2 actlit 15| () Bool)

(assert (=> |rsmt2 actlit 15|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 15|
) )

(assert (not |rsmt2 actlit 15|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const VALUE Int)

(assert
    (>= VALUE 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 16| () Bool)

(assert (=> |rsmt2 actlit 16|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 16|
) )

(assert (not |rsmt2 actlit 16|) )

(declare-fun |rsmt2 actlit 17| () Bool)

(assert (=> |rsmt2 actlit 17|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 17|
) )

(assert (not |rsmt2 actlit 17|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (>= OUT_WIDTH IN_WIDTH)
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 18| () Bool)

(assert (=> |rsmt2 actlit 18|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 18|
) )

(assert (not |rsmt2 actlit 18|) )

(declare-fun |rsmt2 actlit 19| () Bool)

(assert (=> |rsmt2 actlit 19|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 19|
) )

(assert (not |rsmt2 actlit 19|) )

(declare-fun |rsmt2 actlit 20| () Bool)

(assert (=> |rsmt2 actlit 20|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 20|
) )

(assert (not |rsmt2 actlit 20|) )

(declare-fun |rsmt2 actlit 21| () Bool)

(assert (=> |rsmt2 actlit 21|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 21|
) )

(assert (not |rsmt2 actlit 21|) )

(declare-fun |rsmt2 actlit 22| () Bool)

(assert (=> |rsmt2 actlit 22|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 22|
) )

(assert (not |rsmt2 actlit 22|) )

(declare-fun |rsmt2 actlit 23| () Bool)

(assert (=> |rsmt2 actlit 23|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 23|
) )

(assert (not |rsmt2 actlit 23|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (>= OUT_WIDTH IN_WIDTH)
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 24| () Bool)

(assert (=> |rsmt2 actlit 24|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 24|
) )

(assert (not |rsmt2 actlit 24|) )

(declare-fun |rsmt2 actlit 25| () Bool)

(assert (=> |rsmt2 actlit 25|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 25|
) )

(assert (not |rsmt2 actlit 25|) )

(declare-fun |rsmt2 actlit 26| () Bool)

(assert (=> |rsmt2 actlit 26|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 26|
) )

(assert (not |rsmt2 actlit 26|) )

(declare-fun |rsmt2 actlit 27| () Bool)

(assert (=> |rsmt2 actlit 27|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 27|
) )

(assert (not |rsmt2 actlit 27|) )

(declare-fun |rsmt2 actlit 28| () Bool)

(assert (=> |rsmt2 actlit 28|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 28|
) )

(assert (not |rsmt2 actlit 28|) )

(declare-fun |rsmt2 actlit 29| () Bool)

(assert (=> |rsmt2 actlit 29|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 29|
) )

(assert (not |rsmt2 actlit 29|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (>= OUT_WIDTH IN_WIDTH)
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 30| () Bool)

(assert (=> |rsmt2 actlit 30|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 30|
) )

(assert (not |rsmt2 actlit 30|) )

(declare-fun |rsmt2 actlit 31| () Bool)

(assert (=> |rsmt2 actlit 31|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 31|
) )

(assert (not |rsmt2 actlit 31|) )

(declare-fun |rsmt2 actlit 32| () Bool)

(assert (=> |rsmt2 actlit 32|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 32|
) )

(assert (not |rsmt2 actlit 32|) )

(declare-fun |rsmt2 actlit 33| () Bool)

(assert (=> |rsmt2 actlit 33|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 33|
) )

(assert (not |rsmt2 actlit 33|) )

(declare-fun |rsmt2 actlit 34| () Bool)

(assert (=> |rsmt2 actlit 34|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 34|
) )

(assert (not |rsmt2 actlit 34|) )

(declare-fun |rsmt2 actlit 35| () Bool)

(assert (=> |rsmt2 actlit 35|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 35|
) )

(assert (not |rsmt2 actlit 35|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 36| () Bool)

(assert (=> |rsmt2 actlit 36|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 36|
) )

(assert (not |rsmt2 actlit 36|) )

(declare-fun |rsmt2 actlit 37| () Bool)

(assert (=> |rsmt2 actlit 37|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 37|
) )

(assert (not |rsmt2 actlit 37|) )

(declare-fun |rsmt2 actlit 38| () Bool)

(assert (=> |rsmt2 actlit 38|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 38|
) )

(assert (not |rsmt2 actlit 38|) )

(declare-fun |rsmt2 actlit 39| () Bool)

(assert (=> |rsmt2 actlit 39|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 39|
) )

(assert (not |rsmt2 actlit 39|) )

(declare-fun |rsmt2 actlit 40| () Bool)

(assert (=> |rsmt2 actlit 40|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 40|
) )

(assert (not |rsmt2 actlit 40|) )

(declare-fun |rsmt2 actlit 41| () Bool)

(assert (=> |rsmt2 actlit 41|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 41|
) )

(assert (not |rsmt2 actlit 41|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 42| () Bool)

(assert (=> |rsmt2 actlit 42|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 42|
) )

(assert (not |rsmt2 actlit 42|) )

(declare-fun |rsmt2 actlit 43| () Bool)

(assert (=> |rsmt2 actlit 43|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 43|
) )

(assert (not |rsmt2 actlit 43|) )

(declare-fun |rsmt2 actlit 44| () Bool)

(assert (=> |rsmt2 actlit 44|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 44|
) )

(assert (not |rsmt2 actlit 44|) )

(declare-fun |rsmt2 actlit 45| () Bool)

(assert (=> |rsmt2 actlit 45|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 45|
) )

(assert (not |rsmt2 actlit 45|) )

(declare-fun |rsmt2 actlit 46| () Bool)

(assert (=> |rsmt2 actlit 46|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 46|
) )

(assert (not |rsmt2 actlit 46|) )

(declare-fun |rsmt2 actlit 47| () Bool)

(assert (=> |rsmt2 actlit 47|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 47|
) )

(assert (not |rsmt2 actlit 47|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 48| () Bool)

(assert (=> |rsmt2 actlit 48|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 48|
) )

(assert (not |rsmt2 actlit 48|) )

(declare-fun |rsmt2 actlit 49| () Bool)

(assert (=> |rsmt2 actlit 49|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 49|
) )

(assert (not |rsmt2 actlit 49|) )

(declare-fun |rsmt2 actlit 50| () Bool)

(assert (=> |rsmt2 actlit 50|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 50|
) )

(assert (not |rsmt2 actlit 50|) )

(declare-fun |rsmt2 actlit 51| () Bool)

(assert (=> |rsmt2 actlit 51|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 51|
) )

(assert (not |rsmt2 actlit 51|) )

(declare-fun |rsmt2 actlit 52| () Bool)

(assert (=> |rsmt2 actlit 52|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 52|
) )

(assert (not |rsmt2 actlit 52|) )

(declare-fun |rsmt2 actlit 53| () Bool)

(assert (=> |rsmt2 actlit 53|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 53|
) )

(assert (not |rsmt2 actlit 53|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 54| () Bool)

(assert (=> |rsmt2 actlit 54|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 54|
) )

(assert (not |rsmt2 actlit 54|) )

(declare-fun |rsmt2 actlit 55| () Bool)

(assert (=> |rsmt2 actlit 55|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 55|
) )

(assert (not |rsmt2 actlit 55|) )

(declare-fun |rsmt2 actlit 56| () Bool)

(assert (=> |rsmt2 actlit 56|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 56|
) )

(assert (not |rsmt2 actlit 56|) )

(declare-fun |rsmt2 actlit 57| () Bool)

(assert (=> |rsmt2 actlit 57|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 57|
) )

(assert (not |rsmt2 actlit 57|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 58| () Bool)

(assert (=> |rsmt2 actlit 58|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 58|
) )

(assert (not |rsmt2 actlit 58|) )

(declare-fun |rsmt2 actlit 59| () Bool)

(assert (=> |rsmt2 actlit 59|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 59|
) )

(assert (not |rsmt2 actlit 59|) )

(declare-fun |rsmt2 actlit 60| () Bool)

(assert (=> |rsmt2 actlit 60|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 60|
) )

(assert (not |rsmt2 actlit 60|) )

(declare-fun |rsmt2 actlit 61| () Bool)

(assert (=> |rsmt2 actlit 61|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 61|
) )

(assert (not |rsmt2 actlit 61|) )

(declare-fun |rsmt2 actlit 62| () Bool)

(assert (=> |rsmt2 actlit 62|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 62|
) )

(assert (not |rsmt2 actlit 62|) )

(declare-fun |rsmt2 actlit 63| () Bool)

(assert (=> |rsmt2 actlit 63|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 63|
) )

(assert (not |rsmt2 actlit 63|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 64| () Bool)

(assert (=> |rsmt2 actlit 64|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 64|
) )

(assert (not |rsmt2 actlit 64|) )

(declare-fun |rsmt2 actlit 65| () Bool)

(assert (=> |rsmt2 actlit 65|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 65|
) )

(assert (not |rsmt2 actlit 65|) )

(declare-fun |rsmt2 actlit 66| () Bool)

(assert (=> |rsmt2 actlit 66|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 66|
) )

(assert (not |rsmt2 actlit 66|) )

(declare-fun |rsmt2 actlit 67| () Bool)

(assert (=> |rsmt2 actlit 67|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 67|
) )

(assert (not |rsmt2 actlit 67|) )

(declare-fun |rsmt2 actlit 68| () Bool)

(assert (=> |rsmt2 actlit 68|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 68|
) )

(assert (not |rsmt2 actlit 68|) )

(declare-fun |rsmt2 actlit 69| () Bool)

(assert (=> |rsmt2 actlit 69|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 69|
) )

(assert (not |rsmt2 actlit 69|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 70| () Bool)

(assert (=> |rsmt2 actlit 70|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 70|
) )

(assert (not |rsmt2 actlit 70|) )

(declare-fun |rsmt2 actlit 71| () Bool)

(assert (=> |rsmt2 actlit 71|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 71|
) )

(assert (not |rsmt2 actlit 71|) )

(declare-fun |rsmt2 actlit 72| () Bool)

(assert (=> |rsmt2 actlit 72|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 72|
) )

(assert (not |rsmt2 actlit 72|) )

(declare-fun |rsmt2 actlit 73| () Bool)

(assert (=> |rsmt2 actlit 73|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 73|
) )

(assert (not |rsmt2 actlit 73|) )

(declare-fun |rsmt2 actlit 74| () Bool)

(assert (=> |rsmt2 actlit 74|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 74|
) )

(assert (not |rsmt2 actlit 74|) )

(declare-fun |rsmt2 actlit 75| () Bool)

(assert (=> |rsmt2 actlit 75|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 75|
) )

(assert (not |rsmt2 actlit 75|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 76| () Bool)

(assert (=> |rsmt2 actlit 76|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 76|
) )

(assert (not |rsmt2 actlit 76|) )

(declare-fun |rsmt2 actlit 77| () Bool)

(assert (=> |rsmt2 actlit 77|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 77|
) )

(assert (not |rsmt2 actlit 77|) )

(declare-fun |rsmt2 actlit 78| () Bool)

(assert (=> |rsmt2 actlit 78|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 78|
) )

(assert (not |rsmt2 actlit 78|) )

(declare-fun |rsmt2 actlit 79| () Bool)

(assert (=> |rsmt2 actlit 79|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 79|
) )

(assert (not |rsmt2 actlit 79|) )

(declare-fun |rsmt2 actlit 80| () Bool)

(assert (=> |rsmt2 actlit 80|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 80|
) )

(assert (not |rsmt2 actlit 80|) )

(declare-fun |rsmt2 actlit 81| () Bool)

(assert (=> |rsmt2 actlit 81|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 81|
) )

(assert (not |rsmt2 actlit 81|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 82| () Bool)

(assert (=> |rsmt2 actlit 82|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 82|
) )

(assert (not |rsmt2 actlit 82|) )

(declare-fun |rsmt2 actlit 83| () Bool)

(assert (=> |rsmt2 actlit 83|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 83|
) )

(assert (not |rsmt2 actlit 83|) )

(declare-fun |rsmt2 actlit 84| () Bool)

(assert (=> |rsmt2 actlit 84|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 84|
) )

(assert (not |rsmt2 actlit 84|) )

(declare-fun |rsmt2 actlit 85| () Bool)

(assert (=> |rsmt2 actlit 85|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 85|
) )

(assert (not |rsmt2 actlit 85|) )

(declare-fun |rsmt2 actlit 86| () Bool)

(assert (=> |rsmt2 actlit 86|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 86|
) )

(assert (not |rsmt2 actlit 86|) )

(declare-fun |rsmt2 actlit 87| () Bool)

(assert (=> |rsmt2 actlit 87|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 87|
) )

(assert (not |rsmt2 actlit 87|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 88| () Bool)

(assert (=> |rsmt2 actlit 88|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 88|
) )

(assert (not |rsmt2 actlit 88|) )

(declare-fun |rsmt2 actlit 89| () Bool)

(assert (=> |rsmt2 actlit 89|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 89|
) )

(assert (not |rsmt2 actlit 89|) )

(declare-fun |rsmt2 actlit 90| () Bool)

(assert (=> |rsmt2 actlit 90|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 90|
) )

(assert (not |rsmt2 actlit 90|) )

(declare-fun |rsmt2 actlit 91| () Bool)

(assert (=> |rsmt2 actlit 91|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 91|
) )

(assert (not |rsmt2 actlit 91|) )

(declare-fun |rsmt2 actlit 92| () Bool)

(assert (=> |rsmt2 actlit 92|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 92|
) )

(assert (not |rsmt2 actlit 92|) )

(declare-fun |rsmt2 actlit 93| () Bool)

(assert (=> |rsmt2 actlit 93|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 93|
) )

(assert (not |rsmt2 actlit 93|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(assert
    (>= OUT_WIDTH IN_WIDTH)
)

(declare-fun |rsmt2 actlit 94| () Bool)

(assert (=> |rsmt2 actlit 94|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 94|
) )

(assert (not |rsmt2 actlit 94|) )

(declare-fun |rsmt2 actlit 95| () Bool)

(assert (=> |rsmt2 actlit 95|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 95|
) )

(assert (not |rsmt2 actlit 95|) )

(declare-fun |rsmt2 actlit 96| () Bool)

(assert (=> |rsmt2 actlit 96|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 96|
) )

(assert (not |rsmt2 actlit 96|) )

(declare-fun |rsmt2 actlit 97| () Bool)

(assert (=> |rsmt2 actlit 97|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 97|
) )

(assert (not |rsmt2 actlit 97|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(assert
    (>= OUT_WIDTH IN_WIDTH)
)

(declare-fun |rsmt2 actlit 98| () Bool)

(assert (=> |rsmt2 actlit 98|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 98|
) )

(assert (not |rsmt2 actlit 98|) )

(declare-fun |rsmt2 actlit 99| () Bool)

(assert (=> |rsmt2 actlit 99|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 99|
) )

(assert (not |rsmt2 actlit 99|) )

(declare-fun |rsmt2 actlit 100| () Bool)

(assert (=> |rsmt2 actlit 100|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 100|
) )

(assert (not |rsmt2 actlit 100|) )

(declare-fun |rsmt2 actlit 101| () Bool)

(assert (=> |rsmt2 actlit 101|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 101|
) )

(assert (not |rsmt2 actlit 101|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const LEFT Int)

(assert
    (>= LEFT 0)
)

(declare-const RIGHT Int)

(assert
    (>= RIGHT 0)
)

(declare-const OUT Int)

(assert
    (>= OUT 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> LEFT 0)
)

(assert
    (> RIGHT 0)
)

(assert
    (= OUT (+ LEFT RIGHT))
)

(declare-fun |rsmt2 actlit 102| () Bool)

(assert (=> |rsmt2 actlit 102|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 102|
) )

(assert (not |rsmt2 actlit 102|) )

(declare-fun |rsmt2 actlit 103| () Bool)

(assert (=> |rsmt2 actlit 103|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 103|
) )

(assert (not |rsmt2 actlit 103|) )

(declare-fun |rsmt2 actlit 104| () Bool)

(assert (=> |rsmt2 actlit 104|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 104|
) )

(assert (not |rsmt2 actlit 104|) )

(declare-fun |rsmt2 actlit 105| () Bool)

(assert (=> |rsmt2 actlit 105|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 105|
) )

(assert (not |rsmt2 actlit 105|) )

(declare-fun |rsmt2 actlit 106| () Bool)

(assert (=> |rsmt2 actlit 106|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 106|
) )

(assert (not |rsmt2 actlit 106|) )

(declare-fun |rsmt2 actlit 107| () Bool)

(assert (=> |rsmt2 actlit 107|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 107|
) )

(assert (not |rsmt2 actlit 107|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const POS Int)

(assert
    (>= POS 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(assert
    (> WIDTH POS)
)

(declare-fun |rsmt2 actlit 108| () Bool)

(assert (=> |rsmt2 actlit 108|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 108|
) )

(assert (not |rsmt2 actlit 108|) )

(declare-fun |rsmt2 actlit 109| () Bool)

(assert (=> |rsmt2 actlit 109|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 109|
) )

(assert (not |rsmt2 actlit 109|) )

(declare-fun |rsmt2 actlit 110| () Bool)

(assert (=> |rsmt2 actlit 110|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 110|
) )

(assert (not |rsmt2 actlit 110|) )

(declare-fun |rsmt2 actlit 111| () Bool)

(assert (=> |rsmt2 actlit 111|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 111|
) )

(assert (not |rsmt2 actlit 111|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const MSB Int)

(assert
    (>= MSB 0)
)

(declare-const LSB Int)

(assert
    (>= LSB 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(assert
    (> IN_WIDTH MSB)
)

(assert
    (> IN_WIDTH LSB)
)

(assert
    (>= MSB LSB)
)

(declare-fun |rsmt2 actlit 112| () Bool)

(assert (=> |rsmt2 actlit 112|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 112|
) )

(assert (not |rsmt2 actlit 112|) )

(declare-fun |rsmt2 actlit 113| () Bool)

(assert (=> |rsmt2 actlit 113|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 113|
) )

(assert (not |rsmt2 actlit 113|) )

(declare-fun |rsmt2 actlit 114| () Bool)

(assert (=> |rsmt2 actlit 114|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 114|
) )

(assert (not |rsmt2 actlit 114|) )

(declare-fun |rsmt2 actlit 115| () Bool)

(assert (=> |rsmt2 actlit 115|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 115|
) )

(assert (not |rsmt2 actlit 115|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 116| () Bool)

(assert (=> |rsmt2 actlit 116|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 116|
) )

(assert (not |rsmt2 actlit 116|) )

(declare-fun |rsmt2 actlit 117| () Bool)

(assert (=> |rsmt2 actlit 117|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 117|
) )

(assert (not |rsmt2 actlit 117|) )

(declare-fun |rsmt2 actlit 118| () Bool)

(assert (=> |rsmt2 actlit 118|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 118|
) )

(assert (not |rsmt2 actlit 118|) )

(declare-fun |rsmt2 actlit 119| () Bool)

(assert (=> |rsmt2 actlit 119|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 119|
) )

(assert (not |rsmt2 actlit 119|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 120| () Bool)

(assert (=> |rsmt2 actlit 120|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 120|
) )

(assert (not |rsmt2 actlit 120|) )

(declare-fun |rsmt2 actlit 121| () Bool)

(assert (=> |rsmt2 actlit 121|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 121|
) )

(assert (not |rsmt2 actlit 121|) )

(declare-fun |rsmt2 actlit 122| () Bool)

(assert (=> |rsmt2 actlit 122|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 122|
) )

(assert (not |rsmt2 actlit 122|) )

(declare-fun |rsmt2 actlit 123| () Bool)

(assert (=> |rsmt2 actlit 123|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 123|
) )

(assert (not |rsmt2 actlit 123|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const SHIFT_WIDTH Int)

(assert
    (>= SHIFT_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(assert
    (> SHIFT_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 124| () Bool)

(assert (=> |rsmt2 actlit 124|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 124|
) )

(assert (not |rsmt2 actlit 124|) )

(declare-fun |rsmt2 actlit 125| () Bool)

(assert (=> |rsmt2 actlit 125|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 125|
) )

(assert (not |rsmt2 actlit 125|) )

(declare-fun |rsmt2 actlit 126| () Bool)

(assert (=> |rsmt2 actlit 126|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 126|
) )

(assert (not |rsmt2 actlit 126|) )

(declare-fun |rsmt2 actlit 127| () Bool)

(assert (=> |rsmt2 actlit 127|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 127|
) )

(assert (not |rsmt2 actlit 127|) )

(declare-fun |rsmt2 actlit 128| () Bool)

(assert (=> |rsmt2 actlit 128|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 128|
) )

(assert (not |rsmt2 actlit 128|) )

(declare-fun |rsmt2 actlit 129| () Bool)

(assert (=> |rsmt2 actlit 129|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 129|
) )

(assert (not |rsmt2 actlit 129|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(declare-const SHIFT_WIDTH Int)

(assert
    (>= SHIFT_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(assert
    (> SHIFT_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 130| () Bool)

(assert (=> |rsmt2 actlit 130|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 130|
) )

(assert (not |rsmt2 actlit 130|) )

(declare-fun |rsmt2 actlit 131| () Bool)

(assert (=> |rsmt2 actlit 131|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 131|
) )

(assert (not |rsmt2 actlit 131|) )

(declare-fun |rsmt2 actlit 132| () Bool)

(assert (=> |rsmt2 actlit 132|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 132|
) )

(assert (not |rsmt2 actlit 132|) )

(declare-fun |rsmt2 actlit 133| () Bool)

(assert (=> |rsmt2 actlit 133|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 133|
) )

(assert (not |rsmt2 actlit 133|) )

(declare-fun |rsmt2 actlit 134| () Bool)

(assert (=> |rsmt2 actlit 134|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 134|
) )

(assert (not |rsmt2 actlit 134|) )

(declare-fun |rsmt2 actlit 135| () Bool)

(assert (=> |rsmt2 actlit 135|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 135|
) )

(assert (not |rsmt2 actlit 135|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 136| () Bool)

(assert (=> |rsmt2 actlit 136|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 136|
) )

(assert (not |rsmt2 actlit 136|) )

(declare-fun |rsmt2 actlit 137| () Bool)

(assert (=> |rsmt2 actlit 137|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 137|
) )

(assert (not |rsmt2 actlit 137|) )

(declare-fun |rsmt2 actlit 138| () Bool)

(assert (=> |rsmt2 actlit 138|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 138|
) )

(assert (not |rsmt2 actlit 138|) )

(declare-fun |rsmt2 actlit 139| () Bool)

(assert (=> |rsmt2 actlit 139|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 139|
) )

(assert (not |rsmt2 actlit 139|) )

(declare-fun |rsmt2 actlit 140| () Bool)

(assert (=> |rsmt2 actlit 140|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 140|
) )

(assert (not |rsmt2 actlit 140|) )

(declare-fun |rsmt2 actlit 141| () Bool)

(assert (=> |rsmt2 actlit 141|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 141|
) )

(assert (not |rsmt2 actlit 141|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const WIDTH Int)

(assert
    (>= WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> WIDTH 0)
)

(declare-fun |rsmt2 actlit 142| () Bool)

(assert (=> |rsmt2 actlit 142|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 142|
) )

(assert (not |rsmt2 actlit 142|) )

(declare-fun |rsmt2 actlit 143| () Bool)

(assert (=> |rsmt2 actlit 143|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 143|
) )

(assert (not |rsmt2 actlit 143|) )

(declare-fun |rsmt2 actlit 144| () Bool)

(assert (=> |rsmt2 actlit 144|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 144|
) )

(assert (not |rsmt2 actlit 144|) )

(declare-fun |rsmt2 actlit 145| () Bool)

(assert (=> |rsmt2 actlit 145|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 145|
) )

(assert (not |rsmt2 actlit 145|) )

(declare-fun |rsmt2 actlit 146| () Bool)

(assert (=> |rsmt2 actlit 146|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 146|
) )

(assert (not |rsmt2 actlit 146|) )

(declare-fun |rsmt2 actlit 147| () Bool)

(assert (=> |rsmt2 actlit 147|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 147|
) )

(assert (not |rsmt2 actlit 147|) )

(declare-fun |rsmt2 actlit 148| () Bool)

(assert (=> |rsmt2 actlit 148|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 148|
) )

(assert (not |rsmt2 actlit 148|) )

(declare-fun |rsmt2 actlit 149| () Bool)

(assert (=> |rsmt2 actlit 149|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 149|
) )

(assert (not |rsmt2 actlit 149|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-const L Int)

(assert
    (>= L 0)
)

(declare-const IN_WIDTH Int)

(assert
    (>= IN_WIDTH 0)
)

(declare-const OUT_WIDTH Int)

(assert
    (>= OUT_WIDTH 0)
)

(assert
    (> (+ L 0) (+ G 0))
)

(assert
    (> IN_WIDTH 0)
)

(assert
    (> OUT_WIDTH 0)
)

(declare-fun |rsmt2 actlit 150| () Bool)

(assert (=> |rsmt2 actlit 150|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 150|
) )

(assert (not |rsmt2 actlit 150|) )

(declare-fun |rsmt2 actlit 151| () Bool)

(assert (=> |rsmt2 actlit 151|
    (not (> (+ L 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 151|
) )

(assert (not |rsmt2 actlit 151|) )

(declare-fun |rsmt2 actlit 152| () Bool)

(assert (=> |rsmt2 actlit 152|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 152|
) )

(assert (not |rsmt2 actlit 152|) )

(declare-fun |rsmt2 actlit 153| () Bool)

(assert (=> |rsmt2 actlit 153|
    (not (>= (abs (- (+ L 0) (+ G 0))) (abs (- (+ L 0) (+ G 0)))))
))

(check-sat-assuming (
 |rsmt2 actlit 153|
) )

(assert (not |rsmt2 actlit 153|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(assert
    (> 32 0)
)

(declare-fun |rsmt2 actlit 154| () Bool)

(assert (=> |rsmt2 actlit 154|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 154|
) )

(assert (not |rsmt2 actlit 154|) )

(declare-fun |rsmt2 actlit 155| () Bool)

(assert (=> |rsmt2 actlit 155|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 155|
) )

(assert (not |rsmt2 actlit 155|) )

(declare-fun |rsmt2 actlit 156| () Bool)

(assert (=> |rsmt2 actlit 156|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 156|
) )

(assert (not |rsmt2 actlit 156|) )

(declare-fun |rsmt2 actlit 157| () Bool)

(assert (=> |rsmt2 actlit 157|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 157|
) )

(assert (not |rsmt2 actlit 157|) )

(declare-fun |rsmt2 actlit 158| () Bool)

(assert (=> |rsmt2 actlit 158|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 158|
) )

(assert (not |rsmt2 actlit 158|) )

(declare-fun |rsmt2 actlit 159| () Bool)

(assert (=> |rsmt2 actlit 159|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 159|
) )

(assert (not |rsmt2 actlit 159|) )

(declare-fun |rsmt2 actlit 160| () Bool)

(assert (=> |rsmt2 actlit 160|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 160|
) )

(assert (not |rsmt2 actlit 160|) )

(declare-fun |rsmt2 actlit 161| () Bool)

(assert (=> |rsmt2 actlit 161|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 161|
) )

(assert (not |rsmt2 actlit 161|) )

(declare-fun |rsmt2 actlit 162| () Bool)

(assert (=> |rsmt2 actlit 162|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 162|
) )

(assert (not |rsmt2 actlit 162|) )

(declare-fun |rsmt2 actlit 163| () Bool)

(assert (=> |rsmt2 actlit 163|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 163|
) )

(assert (not |rsmt2 actlit 163|) )

(declare-fun |rsmt2 actlit 164| () Bool)

(assert (=> |rsmt2 actlit 164|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 164|
) )

(assert (not |rsmt2 actlit 164|) )

(declare-fun |rsmt2 actlit 165| () Bool)

(assert (=> |rsmt2 actlit 165|
    (not (> (+ G 2) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 165|
) )

(assert (not |rsmt2 actlit 165|) )

(declare-fun |rsmt2 actlit 166| () Bool)

(assert (=> |rsmt2 actlit 166|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 166|
) )

(assert (not |rsmt2 actlit 166|) )

(declare-fun |rsmt2 actlit 167| () Bool)

(assert (=> |rsmt2 actlit 167|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 167|
) )

(assert (not |rsmt2 actlit 167|) )

(declare-fun |rsmt2 actlit 168| () Bool)

(assert (=> |rsmt2 actlit 168|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 168|
) )

(assert (not |rsmt2 actlit 168|) )

(declare-fun |rsmt2 actlit 169| () Bool)

(assert (=> |rsmt2 actlit 169|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 169|
) )

(assert (not |rsmt2 actlit 169|) )

(declare-fun |rsmt2 actlit 170| () Bool)

(assert (=> |rsmt2 actlit 170|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 170|
) )

(assert (not |rsmt2 actlit 170|) )

(declare-fun |rsmt2 actlit 171| () Bool)

(assert (=> |rsmt2 actlit 171|
    (not (> (+ G 2) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 171|
) )

(assert (not |rsmt2 actlit 171|) )

(declare-fun |rsmt2 actlit 172| () Bool)

(assert (=> |rsmt2 actlit 172|
    (not (>= 32 32))
))

(check-sat-assuming (
 |rsmt2 actlit 172|
) )

(assert (not |rsmt2 actlit 172|) )

(declare-fun |rsmt2 actlit 173| () Bool)

(assert (=> |rsmt2 actlit 173|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 173|
) )

(assert (not |rsmt2 actlit 173|) )

(declare-fun |rsmt2 actlit 174| () Bool)

(assert (=> |rsmt2 actlit 174|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 174|
) )

(assert (not |rsmt2 actlit 174|) )

(declare-fun |rsmt2 actlit 175| () Bool)

(assert (=> |rsmt2 actlit 175|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 175|
) )

(assert (not |rsmt2 actlit 175|) )

(declare-fun |rsmt2 actlit 176| () Bool)

(assert (=> |rsmt2 actlit 176|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 176|
) )

(assert (not |rsmt2 actlit 176|) )

(declare-fun |rsmt2 actlit 177| () Bool)

(assert (=> |rsmt2 actlit 177|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 177|
) )

(assert (not |rsmt2 actlit 177|) )

(declare-fun |rsmt2 actlit 178| () Bool)

(assert (=> |rsmt2 actlit 178|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 178|
) )

(assert (not |rsmt2 actlit 178|) )

(declare-fun |rsmt2 actlit 179| () Bool)

(assert (=> |rsmt2 actlit 179|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 179|
) )

(assert (not |rsmt2 actlit 179|) )

(declare-fun |rsmt2 actlit 180| () Bool)

(assert (=> |rsmt2 actlit 180|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 180|
) )

(assert (not |rsmt2 actlit 180|) )

(declare-fun |rsmt2 actlit 181| () Bool)

(assert (=> |rsmt2 actlit 181|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 181|
) )

(assert (not |rsmt2 actlit 181|) )

(declare-fun |rsmt2 actlit 182| () Bool)

(assert (=> |rsmt2 actlit 182|
    (not (> (+ G 2) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 182|
) )

(assert (not |rsmt2 actlit 182|) )

(declare-fun |rsmt2 actlit 183| () Bool)

(assert (=> |rsmt2 actlit 183|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 183|
) )

(assert (not |rsmt2 actlit 183|) )

(declare-fun |rsmt2 actlit 184| () Bool)

(assert (=> |rsmt2 actlit 184|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 184|
) )

(assert (not |rsmt2 actlit 184|) )

(declare-fun |rsmt2 actlit 185| () Bool)

(assert (=> |rsmt2 actlit 185|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 185|
) )

(assert (not |rsmt2 actlit 185|) )

(declare-fun |rsmt2 actlit 186| () Bool)

(assert (=> |rsmt2 actlit 186|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 186|
) )

(assert (not |rsmt2 actlit 186|) )

(declare-fun |rsmt2 actlit 187| () Bool)

(assert (=> |rsmt2 actlit 187|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 187|
) )

(assert (not |rsmt2 actlit 187|) )

(declare-fun |rsmt2 actlit 188| () Bool)

(assert (=> |rsmt2 actlit 188|
    (not (> (+ G 3) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 188|
) )

(assert (not |rsmt2 actlit 188|) )

(declare-fun |rsmt2 actlit 189| () Bool)

(assert (=> |rsmt2 actlit 189|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 189|
) )

(assert (not |rsmt2 actlit 189|) )

(declare-fun |rsmt2 actlit 190| () Bool)

(assert (=> |rsmt2 actlit 190|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 190|
) )

(assert (not |rsmt2 actlit 190|) )

(declare-fun |rsmt2 actlit 191| () Bool)

(assert (=> |rsmt2 actlit 191|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 191|
) )

(assert (not |rsmt2 actlit 191|) )

(declare-fun |rsmt2 actlit 192| () Bool)

(assert (=> |rsmt2 actlit 192|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 192|
) )

(assert (not |rsmt2 actlit 192|) )

(declare-fun |rsmt2 actlit 193| () Bool)

(assert (=> |rsmt2 actlit 193|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 193|
) )

(assert (not |rsmt2 actlit 193|) )

(declare-fun |rsmt2 actlit 194| () Bool)

(assert (=> |rsmt2 actlit 194|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 194|
) )

(assert (not |rsmt2 actlit 194|) )

(declare-fun |rsmt2 actlit 195| () Bool)

(assert (=> |rsmt2 actlit 195|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 195|
) )

(assert (not |rsmt2 actlit 195|) )

(declare-fun |rsmt2 actlit 196| () Bool)

(assert (=> |rsmt2 actlit 196|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 196|
) )

(assert (not |rsmt2 actlit 196|) )

(declare-fun |rsmt2 actlit 197| () Bool)

(assert (=> |rsmt2 actlit 197|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 197|
) )

(assert (not |rsmt2 actlit 197|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-fun |rsmt2 actlit 198| () Bool)

(assert (=> |rsmt2 actlit 198|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 198|
) )

(assert (not |rsmt2 actlit 198|) )

(declare-fun |rsmt2 actlit 199| () Bool)

(assert (=> |rsmt2 actlit 199|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 199|
) )

(assert (not |rsmt2 actlit 199|) )

(declare-fun |rsmt2 actlit 200| () Bool)

(assert (=> |rsmt2 actlit 200|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 200|
) )

(assert (not |rsmt2 actlit 200|) )

(declare-fun |rsmt2 actlit 201| () Bool)

(assert (=> |rsmt2 actlit 201|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 201|
) )

(assert (not |rsmt2 actlit 201|) )

(push 1)

(declare-const k Int)

(assert
    (>= k 0)
)

(declare-fun |rsmt2 actlit 202| () Bool)

(assert (=> |rsmt2 actlit 202|
    (not (=> (and (>= k 0) (> 4 k)) (> (+ G (+ k 1)) (+ G k))))
))

(check-sat-assuming (
 |rsmt2 actlit 202|
) )

(assert (not |rsmt2 actlit 202|) )

(pop 1)

(push 1)

(declare-const k Int)

(assert
    (>= k 0)
)

(declare-fun |rsmt2 actlit 203| () Bool)

(assert (=> |rsmt2 actlit 203|
    (not (=> (and (>= k 0) (> 4 k)) (>= (abs 1) (abs (- (+ k 1) k)))))
))

(check-sat-assuming (
 |rsmt2 actlit 203|
) )

(assert (not |rsmt2 actlit 203|) )

(pop 1)

(declare-fun |rsmt2 actlit 204| () Bool)

(assert (=> |rsmt2 actlit 204|
    (not (> (abs 4) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 204|
) )

(assert (not |rsmt2 actlit 204|) )

(declare-fun |rsmt2 actlit 205| () Bool)

(assert (=> |rsmt2 actlit 205|
    (not (>= (abs 0) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 205|
) )

(assert (not |rsmt2 actlit 205|) )

(declare-fun |rsmt2 actlit 206| () Bool)

(assert (=> |rsmt2 actlit 206|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 206|
) )

(assert (not |rsmt2 actlit 206|) )

(declare-fun |rsmt2 actlit 207| () Bool)

(assert (=> |rsmt2 actlit 207|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 207|
) )

(assert (not |rsmt2 actlit 207|) )

(declare-fun |rsmt2 actlit 208| () Bool)

(assert (=> |rsmt2 actlit 208|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 208|
) )

(assert (not |rsmt2 actlit 208|) )

(declare-fun |rsmt2 actlit 209| () Bool)

(assert (=> |rsmt2 actlit 209|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 209|
) )

(assert (not |rsmt2 actlit 209|) )

(declare-fun |rsmt2 actlit 210| () Bool)

(assert (=> |rsmt2 actlit 210|
    (not (> (abs 4) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 210|
) )

(assert (not |rsmt2 actlit 210|) )

(declare-fun |rsmt2 actlit 211| () Bool)

(assert (=> |rsmt2 actlit 211|
    (not (>= (abs 0) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 211|
) )

(assert (not |rsmt2 actlit 211|) )

(declare-fun |rsmt2 actlit 212| () Bool)

(assert (=> |rsmt2 actlit 212|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 212|
) )

(assert (not |rsmt2 actlit 212|) )

(declare-fun |rsmt2 actlit 213| () Bool)

(assert (=> |rsmt2 actlit 213|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 213|
) )

(assert (not |rsmt2 actlit 213|) )

(declare-fun |rsmt2 actlit 214| () Bool)

(assert (=> |rsmt2 actlit 214|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 214|
) )

(assert (not |rsmt2 actlit 214|) )

(declare-fun |rsmt2 actlit 215| () Bool)

(assert (=> |rsmt2 actlit 215|
    (not (> (abs 4) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 215|
) )

(assert (not |rsmt2 actlit 215|) )

(declare-fun |rsmt2 actlit 216| () Bool)

(assert (=> |rsmt2 actlit 216|
    (not (>= (abs 1) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 216|
) )

(assert (not |rsmt2 actlit 216|) )

(declare-fun |rsmt2 actlit 217| () Bool)

(assert (=> |rsmt2 actlit 217|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 217|
) )

(assert (not |rsmt2 actlit 217|) )

(declare-fun |rsmt2 actlit 218| () Bool)

(assert (=> |rsmt2 actlit 218|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 218|
) )

(assert (not |rsmt2 actlit 218|) )

(declare-fun |rsmt2 actlit 219| () Bool)

(assert (=> |rsmt2 actlit 219|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 219|
) )

(assert (not |rsmt2 actlit 219|) )

(declare-fun |rsmt2 actlit 220| () Bool)

(assert (=> |rsmt2 actlit 220|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 220|
) )

(assert (not |rsmt2 actlit 220|) )

(declare-fun |rsmt2 actlit 221| () Bool)

(assert (=> |rsmt2 actlit 221|
    (not (> (abs 4) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 221|
) )

(assert (not |rsmt2 actlit 221|) )

(declare-fun |rsmt2 actlit 222| () Bool)

(assert (=> |rsmt2 actlit 222|
    (not (>= (abs 1) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 222|
) )

(assert (not |rsmt2 actlit 222|) )

(declare-fun |rsmt2 actlit 223| () Bool)

(assert (=> |rsmt2 actlit 223|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 223|
) )

(assert (not |rsmt2 actlit 223|) )

(declare-fun |rsmt2 actlit 224| () Bool)

(assert (=> |rsmt2 actlit 224|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 224|
) )

(assert (not |rsmt2 actlit 224|) )

(declare-fun |rsmt2 actlit 225| () Bool)

(assert (=> |rsmt2 actlit 225|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 225|
) )

(assert (not |rsmt2 actlit 225|) )

(declare-fun |rsmt2 actlit 226| () Bool)

(assert (=> |rsmt2 actlit 226|
    (not (> (abs 4) (abs 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 226|
) )

(assert (not |rsmt2 actlit 226|) )

(declare-fun |rsmt2 actlit 227| () Bool)

(assert (=> |rsmt2 actlit 227|
    (not (>= (abs 2) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 227|
) )

(assert (not |rsmt2 actlit 227|) )

(declare-fun |rsmt2 actlit 228| () Bool)

(assert (=> |rsmt2 actlit 228|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 228|
) )

(assert (not |rsmt2 actlit 228|) )

(declare-fun |rsmt2 actlit 229| () Bool)

(assert (=> |rsmt2 actlit 229|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 229|
) )

(assert (not |rsmt2 actlit 229|) )

(declare-fun |rsmt2 actlit 230| () Bool)

(assert (=> |rsmt2 actlit 230|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 230|
) )

(assert (not |rsmt2 actlit 230|) )

(declare-fun |rsmt2 actlit 231| () Bool)

(assert (=> |rsmt2 actlit 231|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 231|
) )

(assert (not |rsmt2 actlit 231|) )

(declare-fun |rsmt2 actlit 232| () Bool)

(assert (=> |rsmt2 actlit 232|
    (not (> (abs 4) (abs 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 232|
) )

(assert (not |rsmt2 actlit 232|) )

(declare-fun |rsmt2 actlit 233| () Bool)

(assert (=> |rsmt2 actlit 233|
    (not (>= (abs 2) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 233|
) )

(assert (not |rsmt2 actlit 233|) )

(declare-fun |rsmt2 actlit 234| () Bool)

(assert (=> |rsmt2 actlit 234|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 234|
) )

(assert (not |rsmt2 actlit 234|) )

(declare-fun |rsmt2 actlit 235| () Bool)

(assert (=> |rsmt2 actlit 235|
    (not (>= (+ G 2) (+ G 2)))
))

(check-sat-assuming (
 |rsmt2 actlit 235|
) )

(assert (not |rsmt2 actlit 235|) )

(declare-fun |rsmt2 actlit 236| () Bool)

(assert (=> |rsmt2 actlit 236|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 236|
) )

(assert (not |rsmt2 actlit 236|) )

(declare-fun |rsmt2 actlit 237| () Bool)

(assert (=> |rsmt2 actlit 237|
    (not (> (abs 4) (abs 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 237|
) )

(assert (not |rsmt2 actlit 237|) )

(declare-fun |rsmt2 actlit 238| () Bool)

(assert (=> |rsmt2 actlit 238|
    (not (>= (abs 3) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 238|
) )

(assert (not |rsmt2 actlit 238|) )

(declare-fun |rsmt2 actlit 239| () Bool)

(assert (=> |rsmt2 actlit 239|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 239|
) )

(assert (not |rsmt2 actlit 239|) )

(declare-fun |rsmt2 actlit 240| () Bool)

(assert (=> |rsmt2 actlit 240|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 240|
) )

(assert (not |rsmt2 actlit 240|) )

(declare-fun |rsmt2 actlit 241| () Bool)

(assert (=> |rsmt2 actlit 241|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 241|
) )

(assert (not |rsmt2 actlit 241|) )

(declare-fun |rsmt2 actlit 242| () Bool)

(assert (=> |rsmt2 actlit 242|
    (not (> (abs 4) (abs 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 242|
) )

(assert (not |rsmt2 actlit 242|) )

(declare-fun |rsmt2 actlit 243| () Bool)

(assert (=> |rsmt2 actlit 243|
    (not (>= (abs 3) (abs 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 243|
) )

(assert (not |rsmt2 actlit 243|) )

(declare-fun |rsmt2 actlit 244| () Bool)

(assert (=> |rsmt2 actlit 244|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 244|
) )

(assert (not |rsmt2 actlit 244|) )

(declare-fun |rsmt2 actlit 245| () Bool)

(assert (=> |rsmt2 actlit 245|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 245|
) )

(assert (not |rsmt2 actlit 245|) )

(declare-fun |rsmt2 actlit 246| () Bool)

(assert (=> |rsmt2 actlit 246|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 246|
) )

(assert (not |rsmt2 actlit 246|) )

(pop 1)

(push 1)

(declare-const G Int)

(assert
    (>= G 0)
)

(declare-fun |rsmt2 actlit 247| () Bool)

(assert (=> |rsmt2 actlit 247|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 247|
) )

(assert (not |rsmt2 actlit 247|) )

(declare-fun |rsmt2 actlit 248| () Bool)

(assert (=> |rsmt2 actlit 248|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 248|
) )

(assert (not |rsmt2 actlit 248|) )

(declare-fun |rsmt2 actlit 249| () Bool)

(assert (=> |rsmt2 actlit 249|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 249|
) )

(assert (not |rsmt2 actlit 249|) )

(declare-fun |rsmt2 actlit 250| () Bool)

(assert (=> |rsmt2 actlit 250|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 250|
) )

(assert (not |rsmt2 actlit 250|) )

(declare-fun |rsmt2 actlit 251| () Bool)

(assert (=> |rsmt2 actlit 251|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 251|
) )

(assert (not |rsmt2 actlit 251|) )

(declare-fun |rsmt2 actlit 252| () Bool)

(assert (=> |rsmt2 actlit 252|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 252|
) )

(assert (not |rsmt2 actlit 252|) )

(declare-fun |rsmt2 actlit 253| () Bool)

(assert (=> |rsmt2 actlit 253|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 253|
) )

(assert (not |rsmt2 actlit 253|) )

(declare-fun |rsmt2 actlit 254| () Bool)

(assert (=> |rsmt2 actlit 254|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 254|
) )

(assert (not |rsmt2 actlit 254|) )

(declare-fun |rsmt2 actlit 255| () Bool)

(assert (=> |rsmt2 actlit 255|
    (not (>= 32 32))
))

(check-sat-assuming (
 |rsmt2 actlit 255|
) )

(assert (not |rsmt2 actlit 255|) )

(declare-fun |rsmt2 actlit 256| () Bool)

(assert (=> |rsmt2 actlit 256|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 256|
) )

(assert (not |rsmt2 actlit 256|) )

(declare-fun |rsmt2 actlit 257| () Bool)

(assert (=> |rsmt2 actlit 257|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 257|
) )

(assert (not |rsmt2 actlit 257|) )

(declare-fun |rsmt2 actlit 258| () Bool)

(assert (=> |rsmt2 actlit 258|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 258|
) )

(assert (not |rsmt2 actlit 258|) )

(declare-fun |rsmt2 actlit 259| () Bool)

(assert (=> |rsmt2 actlit 259|
    (not (> 32 0))
))

(check-sat-assuming (
 |rsmt2 actlit 259|
) )

(assert (not |rsmt2 actlit 259|) )

(declare-fun |rsmt2 actlit 260| () Bool)

(assert (=> |rsmt2 actlit 260|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 260|
) )

(assert (not |rsmt2 actlit 260|) )

(declare-fun |rsmt2 actlit 261| () Bool)

(assert (=> |rsmt2 actlit 261|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 261|
) )

(assert (not |rsmt2 actlit 261|) )

(declare-fun |rsmt2 actlit 262| () Bool)

(assert (=> |rsmt2 actlit 262|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 262|
) )

(assert (not |rsmt2 actlit 262|) )

(declare-fun |rsmt2 actlit 263| () Bool)

(assert (=> |rsmt2 actlit 263|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 263|
) )

(assert (not |rsmt2 actlit 263|) )

(declare-fun |rsmt2 actlit 264| () Bool)

(assert (=> |rsmt2 actlit 264|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 264|
) )

(assert (not |rsmt2 actlit 264|) )

(declare-fun |rsmt2 actlit 265| () Bool)

(assert (=> |rsmt2 actlit 265|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 265|
) )

(assert (not |rsmt2 actlit 265|) )

(declare-fun |rsmt2 actlit 266| () Bool)

(assert (=> |rsmt2 actlit 266|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 266|
) )

(assert (not |rsmt2 actlit 266|) )

(declare-fun |rsmt2 actlit 267| () Bool)

(assert (=> |rsmt2 actlit 267|
    (not (> (+ G 1) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 267|
) )

(assert (not |rsmt2 actlit 267|) )

(declare-fun |rsmt2 actlit 268| () Bool)

(assert (=> |rsmt2 actlit 268|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 268|
) )

(assert (not |rsmt2 actlit 268|) )

(declare-fun |rsmt2 actlit 269| () Bool)

(assert (=> |rsmt2 actlit 269|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 269|
) )

(assert (not |rsmt2 actlit 269|) )

(declare-fun |rsmt2 actlit 270| () Bool)

(assert (=> |rsmt2 actlit 270|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 270|
) )

(assert (not |rsmt2 actlit 270|) )

(declare-fun |rsmt2 actlit 271| () Bool)

(assert (=> |rsmt2 actlit 271|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 271|
) )

(assert (not |rsmt2 actlit 271|) )

(declare-fun |rsmt2 actlit 272| () Bool)

(assert (=> |rsmt2 actlit 272|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 272|
) )

(assert (not |rsmt2 actlit 272|) )

(declare-fun |rsmt2 actlit 273| () Bool)

(assert (=> |rsmt2 actlit 273|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 273|
) )

(assert (not |rsmt2 actlit 273|) )

(declare-fun |rsmt2 actlit 274| () Bool)

(assert (=> |rsmt2 actlit 274|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 274|
) )

(assert (not |rsmt2 actlit 274|) )

(declare-fun |rsmt2 actlit 275| () Bool)

(assert (=> |rsmt2 actlit 275|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 275|
) )

(assert (not |rsmt2 actlit 275|) )

(declare-fun |rsmt2 actlit 276| () Bool)

(assert (=> |rsmt2 actlit 276|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 276|
) )

(assert (not |rsmt2 actlit 276|) )

(declare-fun |rsmt2 actlit 277| () Bool)

(assert (=> |rsmt2 actlit 277|
    (not (>= (+ G 0) (+ G 0)))
))

(check-sat-assuming (
 |rsmt2 actlit 277|
) )

(assert (not |rsmt2 actlit 277|) )

(declare-fun |rsmt2 actlit 278| () Bool)

(assert (=> |rsmt2 actlit 278|
    (not (>= (+ G 1) (+ G 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 278|
) )

(assert (not |rsmt2 actlit 278|) )

(declare-fun |rsmt2 actlit 279| () Bool)

(assert (=> |rsmt2 actlit 279|
    (not (>= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 279|
) )

(assert (not |rsmt2 actlit 279|) )

(declare-fun |rsmt2 actlit 280| () Bool)

(assert (=> |rsmt2 actlit 280|
    (not (= (abs 1) (abs 1)))
))

(check-sat-assuming (
 |rsmt2 actlit 280|
) )

(assert (not |rsmt2 actlit 280|) )

(declare-fun |rsmt2 actlit 281| () Bool)

(assert (=> |rsmt2 actlit 281|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 281|
) )

(assert (not |rsmt2 actlit 281|) )

(declare-fun |rsmt2 actlit 282| () Bool)

(assert (=> |rsmt2 actlit 282|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 282|
) )

(assert (not |rsmt2 actlit 282|) )

(declare-fun |rsmt2 actlit 283| () Bool)

(assert (=> |rsmt2 actlit 283|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 283|
) )

(assert (not |rsmt2 actlit 283|) )

(declare-fun |rsmt2 actlit 284| () Bool)

(assert (=> |rsmt2 actlit 284|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 284|
) )

(assert (not |rsmt2 actlit 284|) )

(declare-fun |rsmt2 actlit 285| () Bool)

(assert (=> |rsmt2 actlit 285|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 285|
) )

(assert (not |rsmt2 actlit 285|) )

(declare-fun |rsmt2 actlit 286| () Bool)

(assert (=> |rsmt2 actlit 286|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 286|
) )

(assert (not |rsmt2 actlit 286|) )

(declare-fun |rsmt2 actlit 287| () Bool)

(assert (=> |rsmt2 actlit 287|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 287|
) )

(assert (not |rsmt2 actlit 287|) )

(declare-fun |rsmt2 actlit 288| () Bool)

(assert (=> |rsmt2 actlit 288|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 288|
) )

(assert (not |rsmt2 actlit 288|) )

(declare-fun |rsmt2 actlit 289| () Bool)

(assert (=> |rsmt2 actlit 289|
    (not (> (+ G 4) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 289|
) )

(assert (not |rsmt2 actlit 289|) )

(declare-fun |rsmt2 actlit 290| () Bool)

(assert (=> |rsmt2 actlit 290|
    (not (= (abs 32) (abs 32)))
))

(check-sat-assuming (
 |rsmt2 actlit 290|
) )

(assert (not |rsmt2 actlit 290|) )

(declare-fun |rsmt2 actlit 291| () Bool)

(assert (=> |rsmt2 actlit 291|
    (not (>= (+ G 3) (+ G 3)))
))

(check-sat-assuming (
 |rsmt2 actlit 291|
) )

(assert (not |rsmt2 actlit 291|) )

(declare-fun |rsmt2 actlit 292| () Bool)

(assert (=> |rsmt2 actlit 292|
    (not (>= (+ G 4) (+ G 4)))
))

(check-sat-assuming (
 |rsmt2 actlit 292|
) )

(assert (not |rsmt2 actlit 292|) )

(pop 1)

