(deffunction ask-question (?question $?allowed-values)
    (bind ?answer "\false-value")
    (while (not (member ?answer ?allowed-values)) do
        (printout t ?question)
        (bind ?answer (read))
        (if (lexemep ?answer) then
            (bind ?answer (lowcase ?answer))
        )
    )
    ?answer
)

(deffunction yes-or-no-p (?question)
    (bind ?response (ask-question (str-cat ?question " (yes/no): ") yes no y n))
    (if (or (eq ?response yes) (eq ?response y)) then TRUE else FALSE)
)



(defrule determine-working-state
    (not (working-state printer ?))
    (not (repair ?))
=>
    (if (yes-or-no-p "Is the printer working?")
        then
            (if (yes-or-no-p "Is the printer work normally?")
                then (assert (working-state printer normal))
                else (assert (working-state printer unsatisfactory))
                     (assert (power-state printer on))
            )
        else (assert (working-state printer does-not-work))
    )
)

(defrule determine-power-state
    (not (power-state printer ?))
    (working-state printer does-not-work)
    (not (repair ?))
=>
    (if (yes-or-no-p "Is the printer connected to power?")
        then (assert (power-state printer on))
        else (assert (repair "Connect the printer to a power."))
             (assert (power-state printer off))
    )
)

(defrule PC-communicated
    (power-state printer on)
    (not (repair ?))
=>
    (if (yes-or-no-p "Are the printer and PC connected?")
        then (assert (PC-communication printer has))
        else (assert (repair "Connect the printer to your computer."))
             (assert (PC-communication printer does-not-have))
    )
)

(defrule PC-has-driver
    (PC-communication printer has)
    (not (repair ?))
=>
    (if (yes-or-no-p "Is the printer driver installed on your PC?")
        then (assert (printer-driver computer has))
        else (assert (repair "Install the printer driver on your PC."))
             (assert (printer-driver computer does-not-have))
    )
)

(defrule cartridge-inked
    (not (ink-state ink ?))
    (printer-driver computer has)
    (not (repair ?))
=>
    (if (yes-or-no-p "Is the cartridge filled with ink?")
        then (assert (ink-state ink has))
        else (assert (repair "Refill the cartridge with ink."))
             (assert (ink-state ink does-not-have))
    )
)

(defrule determine-paper
    (not (has-paper printer ?))
    (printer-driver computer has)
    (not (repair ?))
=>
    (if (yes-or-no-p "Is there enough paper in the printer?")
        then 
            (assert (has-paper printer has))
            (if (yes-or-no-p "Did the printer stop working during the process?")
                then (assert (repair "Remove jammed sheets from the printer."))
            )
        else (assert (repair "Fill the printer tray with paper."))
             (assert (has-paper printer does-not-have))
    )
)

(defrule determine-cartridge-state
    (printer-driver computer has)
    (not (repair ?))
=>
    (if (yes-or-no-p "Do black blurry lines appear on paper when printing?")
        then (assert (repair "Clean the cartridge."))
             (assert (cartridge-state cartridge dirty))
        else (assert (cartridge-state cartridge normal))
    )
)

(defrule determine-cover-state
    (printer-driver computer has)
    (not(repair ?))
    (not (cover-state cover ?))
=>
    (if (yes-or-no-p "Is the cartridge compartment cover closed?")
        then (assert (cover-state cover off))
        else (assert (repair "Close the cartridge compartment cover."))
             (assert (cover-state cover on))
    )
)



(defrule normal-printer-state-conclusions
   (declare (salience 10))
   (working-state printer normal)
=>
   (assert (repair "No repairs required.")) 
   (assert (PC-communication printer has))
   (assert (power-state printer on))
   (assert (ink-state printer has))
)

(defrule unsatisfactory-printer-state-conclusions
   (declare (salience 10))
   (working-state printer unsatisfactory)
=>
   (assert (power-state printer on))
)


(defrule no-repairs
  (declare (salience -10))
  (not (repair ?))
=>
  (assert (repair "Contact the service department.")) 
)

(defrule print-repair
    (declare (salience 10))
    (repair ?item)
  =>
    (printout t "Repair recommendations:" crlf ?item crlf)
)

(reset)
(run)
