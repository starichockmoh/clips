(deffunction distance (?x1 ?y1 ?x2 ?y2)
    (sqrt (+ (** (- ?x2 ?x1) 2) (** (- ?y2 ?y1) 2)))
)

(deffunction triangle_perimeter (?x1 ?y1 ?x2 ?y2 ?x3 ?y3)
    (+ (distance ?x1 ?y1 ?x2 ?y2)
       (distance ?x2 ?y2 ?x3 ?y3)
       (distance ?x3 ?y3 ?x1 ?y1))
)

(printout t "Triangle perimeter: " (triangle_perimeter 1 1 2 0 4 1) crlf)


(deffunction f_x (?x ?c ?d)
    (if (< ?x ?c)
        then (- 1 (* ?x ?x))
        else (if (>= ?x ?d)
            then (+ 1 (* ?x ?x))
            else 0
        )
    )
)

(printout t "f(x): " (f_x 2 3 4) crlf)
(printout t "f(x): " (f_x 2 2 3) crlf)
(printout t "f(x): " (f_x 2 1 2) crlf)
(printout t "f(x): " (f_x 2 0 1) crlf)


(deffunction sum (?n)
    (if (<= ?n 1)
        then (/ 1 (+ 1 (* 2 ?n)))
        else (+ (/ 1 (+ 1 (* 2 ?n)))
                (sum (- ?n 1)))
    )
)

(printout t "Sum: " (sum 5) crlf)
