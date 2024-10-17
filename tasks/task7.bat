(reset)

(deffunction replace_spaces_f (?str)
    (bind ?new-str "")
    (bind ?len (str-length ?str))
    (while (<> 0 (str-compare "" ?str)) do
        (bind ?space-pos (str-index " " ?str))
        (if (not ?space-pos)
            then (bind ?new-str (str-cat ?new-str (sub-string 1 ?len ?str)))
                 (break)
            else (bind ?new-str (str-cat ?new-str (sub-string 1 (- ?space-pos 1) ?str) "_"))
        )
        (bind ?str (sub-string (+ ?space-pos 1) ?len ?str))
        (bind ?len (str-length ?str))
    )
    ?new-str
)

(defrule replace_spaces
=>
    (printout t "str=")
    (bind ?str (readline))
    (printout t "Updated string: " (replace_spaces_f ?str) crlf)
)


(deffunction str_upbuilding_f (?str ?n)
    (bind ?increment "")
    (loop-for-count ?n do                            
        (bind ?increment (str-cat ?increment "*"))
    )
    (bind ?str (str-cat ?str ?increment))
    ?str
)

(defrule str_upbuilding
=>
    (printout t "str1=")
    (bind ?str1 (readline))
    (printout t "str2=")
    (bind ?str2 (readline))
    (bind ?n1 (str-length ?str1))
    (bind ?n2 (str-length ?str2))
    (if (> ?n1 ?n2)
        then (printout t "str2=" (str_upbuilding_f ?str2 (- ?n1 ?n2)) crlf)
        else (printout t "str1=" (str_upbuilding_f ?str1 (- ?n2 ?n1)) crlf)
    )	
)


(deffunction reverse-f (?str)
    (bind ?res "")
    (bind ?n (str-length ?str))
    (while (> ?n 0) do                            
        (bind ?res (str-cat ?res (sub-string ?n ?n ?str)))
        (bind ?n (- ?n 1))
    )
    ?res
)

(defrule reverse
=>
    (printout t "str to reverse = ")
    (bind ?str (readline))
    (printout t "reversed str = " (reverse-f ?str) crlf)
)

(run)
