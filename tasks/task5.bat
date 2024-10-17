(defrule zachisl
=>
    (printout t "count=" )
    (bind ?n (read))
    (loop-for-count ?n do
        (printout t "FIO:" )
        (bind ?name (readline))
        (assert (student ?name 1))
    )
    (facts)
)

(defrule sum
=>
    (printout t "n=" )
    (bind ?n (read))
    (bind ?sum 0)
    (loop-for-count (?i 1 ?n) do
        (bind ?sum (+ ?sum (/ 1 (* ?i ?i))))
    )
    (printout t "sum=" (/ ?sum 4) crlf)
)

(defrule gcd_sub
=>
    (printout t "a=")
    (bind ?a (read))
    (printout t "b=")
    (bind ?b (read))
    (while (<> ?a ?b) do
        (if (> ?a ?b)
            then (bind ?a (- ?a ?b))
            else (bind ?b (- ?b ?a))
        )
    )
    (printout t "NOD=" ?a crlf)
)

(reset)
(run)
