(deffacts trains
    (poezd 115 Saratov 9:30)
    (poezd 121 Engels 11:40)
    (poezd 122 Moscow 12:00)
)
(reset)
(assert
    (poezd 116 Omsk 10:00)
    (poezd 114 Omsk 8:50)
)
(facts)
(retract 1 4)
(retract 2)
(assert (poezd 121 Engels 10:00))
(retract 3)
(assert (poezd 122 Moscow 11:00))
(facts)
(clear)




(deffacts goods
    (tovar cars USA 90 4)
    (tovar apples Russia 100 10)
    (tovar toys Belarus 350 2)
)
(reset)
(assert
    (tovar lemons India 12 50)
    (tovar bread Russia 25 15)
)
(facts)
(retract 2)
(assert (tovar apples Russia 90 10))
(retract 4)
(assert (tovar lemons India 30 50))
(facts)
(retract *)
(facts)
