(deffacts employees
    (sotrudnik Kotov 5 5 190000)
    (sotrudnik Petrov 2 7 120000)
    (sotrudnik Ivanov 1 5 50000)
    (sotrudnik Popov 21 1 450000)
    (sotrudnik Marinkov 15 3 340000)
    (sotrudnik Sotov 23 5 600000)
    (sotrudnik Kuznecov 12 1 270000)
    (sotrudnik Perepadia 2 3 200000)
    (sotrudnik Vasilev 1 3 80000)
)
(reset)

(defrule premium
    (sotrudnik ?name ?xp ?chld_cnt ?salary)
    (test (or (>= ?xp 5) (> ?chld_cnt 2)))
=>
    (assert (premia ?name (round ?salary))
))

(defrule all_premiumed
    (forall (sotrudnik ?name ?xp ?chld_cnt ?salary)
            (premia ?name ?))
=>
    (printout t "All employees received a premium!" crlf)
)

(defrule veteran
    (exists (sotrudnik ?name ?xp ?chld_cnt ?salary)
            (test (> ?xp 20)))
=>
    (printout t "There is a labor veteran among the employees!" crlf)
)

(run)
(facts)
