(reset)
(load task3_template.clp)
(load-facts task3_facts.clp)
(facts)
(modify 1 (citi Moscow))
(modify 2 (name Petrov))
(duplicate 3 (in 4))
(facts)
(save-facts task3_new_facts.clp)



(clear)
(load task3_template.clp)
(load-facts task3_new_facts.clp)
(assert
    (client (name Sidorov) (in 5))
    (client (name Popov) (in 6) (citi Saratov))
)
(retract 1 3)
(facts)
(save-facts task3_new_new_facts.clp)
