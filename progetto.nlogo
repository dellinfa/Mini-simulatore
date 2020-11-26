;;VARIABILI GLOBALI

extensions[ py
            csv
]




globals[ time                   ;; dichiarazione delle variabili globali
         simulation_state       ;;
         csv fileList
         firstList
         array
         i
         j
         bound_globals_flexM
         bound_globals_flex_m
         bound_globals_costoM
         bound_globals_costo_m
         richieste_create
         array_x
         array_y
         array_result
]

;;GLOBAL BREEDS
breed[ pods pod ]              ;;dichiarazione dell'agentset pod
breed[aggregatore aggregatori] ;;dichiarazione aggregtore
breed[mercati mercato ] ;;dichiarazione simulatore

;;VARIABILI DEI POD

pods-own[
  flexM
  flex_m
  costoM
  costo_m
]

;;VARIABILI DELL'AGGRAGATORE

aggregatore-own[

  flex_R          ;; Flessibilità che darò in risposta al mercato
  costo_R         ;; Costo verso il mercato
  bound_flexM     ;; somma delle flex Max degli agenti pod usato poi per il confronto nel simulatore questa deriva dall'aggregatore
  bound_flex_m     ;; somma delle flex min degli agenti pod usato poi per il confronto nel simulatore questa deriva dall'aggregatore
  bound_costoM     ;; somma dei costi degli Max agenti pod usato poi per il confronto nel simulatore questa deriva dall'aggregatore
  bound_costo_m     ;; somma dei costi min degli agenti pod usato poi per il confronto nel simulatore questa deriva dall'aggregatore

]

;;VARIABILI SIMUALATORE

mercati-own[
   requests       ;; numero di richieste
   start_time     ;; tempo di inizo
   end_time       ;; tempo di fine
   duration       ;; durata
   req_flex       ;; flessibilità richiesta
   req_cost       ;; costo richiesto
   risp_flex      ;;risposta per flex(t)
   risp_cost      ;; risposta per costo(t)
   z              ;; valore z = risultato
]

;; SETUP : viene eseguito una volta quando si preme il tasto.
;; Vado a settare i vari pod staticamente

to setup
  ca ;; cancella tutte le turtle e resetta le patches
  set simulation_state "-----------------------------------SETTING STATE----------------------------------------"
  print(simulation_state)
  reset-ticks

  ;;mercato-create-file
  fun

end

to read-pod-from-python
   set simulation_state "-----------------------------------READING FROM PYTHON STATE----------------------------------------"
   print(simulation_state)
   run-py1

end

to read-pod-from-csv
  set simulation_state "-----------------------------------READING FROM CSV STATE----------------------------------------"
   print(simulation_state)
  read_csv

end


to make-aggregation ; L'agente aggregatore deve prendere i valore degli array all'interno dei pod e sommarli. Tutte le flexM devono essere sommate in bound_flexM. Infine avrò un array che avrà la somma di tutti i pod
    set simulation_state "-----------------------------------AGGRAGATION STATE----------------------------------------"
    print(simulation_state)
              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ITERAZIONE FATTA PER BOUND_FLEX_M;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    let lista_flexM []
    let lista_flex_m []
    let lista_costoM []
    let lista_costo_m []
    let iterator 0
    let temp 0
    let elemento 0
    let n_i 0
    while[n_i != 96][
      while [iterator < number ][
        ask pod iterator[
          set elemento item n_i flexM
          ;print("Questo è l'elemento preso dall' n-i item di felxM")
          ;show elemento ;; prendi l'elemento del pod i  e mettilo in una variabile

        ]
        set temp temp + elemento
       ; print("Questo è temp ")
       ; show temp
        set iterator iterator + 1
        ;print("Questo è iterator ")
        ;show iterator

      ]
    set iterator  0
    ;print("Questa è lista_flex ")
    set lista_flexM lput temp lista_flexM
    set temp 0

    ;show lista_flexM
    ;print("Questo è n_i ")
    set n_i n_i + 1
    ;;show n_i
   ]



              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ITERAZIONE FATTA PER BOUND_FLEX_m;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    set iterator 0
    set temp 0
    set elemento 0
    set n_i 0
    while[n_i != 96][
      while [iterator < number ][
        ask pod iterator[
          set elemento item n_i flex_m
         ; print("Questo è l'elemento preso dall' n-i item di felx_m")
         ; show elemento ;; prendi l'elemento del pod i  e mettilo in una variabile

        ]
        set temp temp + elemento
       ; print("Questo è temp ")
       ; show temp
        set iterator iterator + 1
        ;print("Questo è iterator ")
        ;show iterator

      ]
    set iterator  0
    ;print("Questa è lista_flex ")

    set lista_flex_m lput temp lista_flex_m
    set temp 0

    ;show lista_flex
    ;print("Questo è n_i ")
    set n_i n_i + 1
    ;;show n_i
   ]


              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ITERAZIONE FATTA PER BOUND_COSTO_M;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    set iterator 0
    set temp 0
    set elemento 0
    set n_i 0
    while[n_i != 96][
      while [iterator < number ][
        ask pod iterator[
          set elemento item n_i costoM
          ;print("Questo è l'elemento preso dall' n-i item di felxM")
          ;show elemento ;; prendi l'elemento del pod i  e mettilo in una variabile

        ]
        set temp temp + elemento
        ;print("Questo è temp ")
        ;show temp
        set iterator iterator + 1
        ;print("Questo è iterator ")
        ;show iterator

      ]
    set iterator  0
    ;print("Questa è lista_flex ")

    set lista_costoM lput temp lista_costoM
    set temp 0

    ;show lista_flex
    ;print("Questo è n_i ")
    set n_i n_i + 1
    ;;show n_i
   ]


              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ITERAZIONE FATTA PER BOUND_COSTO_m;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    set iterator 0
    set temp 0
    set elemento 0
    set n_i 0
    while[n_i != 96][
      while [iterator < number ][
        ask pod iterator[
          set elemento item n_i costo_m
          ;print("Questo è l'elemento preso dall' n-i item di felxM")
          ;show elemento ;; prendi l'elemento del pod i  e mettilo in una variabile

        ]
        set temp temp + elemento
        ;print("Questo è temp ")
        ;show temp
        set iterator iterator + 1
        ;print("Questo è iterator ")
        ;show iterator

      ]
    set iterator  0
    ;print("Questa è lista_flex ")

    set lista_costo_m lput temp lista_costo_m
    set temp 0

    ;show lista_flex
    ;print("Questo è n_i ")
    set n_i n_i + 1
    ;;show n_i
   ]




  create-aggregatore 1 [

     set size 5
     set color red
     fd 0
    set bound_flexM   lista_flexM
    set bound_flex_m  lista_flex_m
    set bound_costoM  lista_costoM
    set bound_costo_m lista_costo_m
    show bound_flex_m
    show bound_flexM
    show bound_costo_m
    show bound_costoM

  ]

  ask aggregatore  [
    set bound_globals_flex_m bound_flex_m
    set bound_globals_flexM bound_flexM
    set bound_globals_costo_m bound_costo_m
    set bound_globals_costoM bound_costoM
  ]


end






;to createpod
;  create-pods number ;; crea n pod
;  set-default-shape pods "box"
;
;  ask pods[
;              set size 4
;              fd 10
;              set color red
;
;  ]
;end

to make-simulation
  set simulation_state  "-----------------------------------SIMULATION----------------------------------------"
  print(simulation_state)

  let lista list random(10) random(20)

  set array_x 0 ; contiene i valori di flexOttimizzati
  set array_y 0 ; contiene i valori di costoOttimizzati
  set array_result 0 ;contiene i valori obj
  let temp_flex_M 0 ; variabile fM presa temporaneamente da bound
  let temp_flex_mi 0 ; variabile fm presa temporaneamente da bound
  let temp_costo_M 0 ;variabile cM presa temporaneamente da bound
  let temp_costo_mi 0 ;variabile cm presa temporaneamente da bound
  let richieste []
  let richiesta 0 ;variabile richiesta presa da array letto da csv richieste
  print("----------sono prima del tick---------")
  tick
  print("----------sono dopo il tick ---------")
 ;;generare random richieste di flex in un dato istante temporale, dopo di che il mio aggragatore(make-aggregation) dovrà risolvere l'if.
  while[ticks mod 95 != 0 ][
    tick
    print("----------sono nel while---------")
    set temp_flex_mi  item ticks bound_globals_flex_m
    print("questa è flex min ")
    print(temp_flex_mi)
    set temp_flex_M item ticks bound_globals_flexM
    print(temp_flex_M)
    set temp_costo_mi item ticks bound_globals_costo_m
    print(temp_costo_mi)
    set temp_costo_M item ticks bound_globals_costoM
    print(temp_costo_M)
    set richieste item 0 richieste_create
    set richiesta item ticks richieste
    print(richiesta)



    py:setup "/opt/anaconda3/bin/python3"

    (py:run
    "import importlib.util"
    "spec = importlib.util.spec_from_file_location('module.name','/Users/fabiodellinfante/Desktop/Modello_gourobi.py')"
    "foo = importlib.util.module_from_spec(spec)"
    "spec.loader.exec_module(foo)"
     )


    (py:set "flex_M" temp_flex_M )
    (py:set "flex_m" temp_flex_mi)
    (py:set "costo_M" temp_costo_M)
    (py:set "costo_m" temp_costo_mi)
    (py:set "richiesta" richiesta)


    print("----------eseguo script python---------")
    (set lista py:runresult "foo.optimize(flex_m,flex_M,costo_m,costo_M,richiesta)")
    print("----------fine script python---------")

     set array_x item 0 lista
     set array_y item 1 lista
     set array_result item 3 lista
     print(array_x)
     print(array_y)
     print(array_result)



  ]




end


to create_request
  print "open file     *****************************************"
  file-open "/Users/fabiodellinfante/Desktop/richieste.csv"
  print "aperto"
  set i  0
      while [i <= 96]
        [

          file-write(word i)
          file-write(word "\n")
          file-write(word random(96))


         set i  i + 1
        ]


  print "close"
  show richieste_create
  file-close
end

to read_csv

  file-open "output.csv"
  set fileList []
  set j 0
  set firstList []

  while [not file-at-end?] [
    set csv file-read-line
    set csv word csv ","  ; add comma for loop termination

    let mylist []  ; list of values
    while [not empty? csv]
    [
      let $y position "," csv
      let $item1 substring csv 0 $y  ; extract item
      carefully [set $item1 read-from-string $item1][] ; convert if number
      set mylist lput $item1 mylist  ; append to list
      set csv substring csv ($y + 1) length csv  ; remove item and comma
    ]
    ;show first mylist
    ;show mylist
    set fileList lput mylist fileList

  ]
  while [j != number] [
      let a 1
      let b 2
      let c 3
      let d 4
      create-pods number [
      set size 3
      fd 5
      set color green
      set flexM       item a fileList
      show flexM
      set flex_m      item b fileList
      show flex_m
      set costoM      item c fileList
      show costoM
      set costo_m     item d fileList
      show costo_m
      set j j + 1
      set a a + 5
      set b b + 5
      set c c + 5
      set d d + 5

    ]
  ]
  show fileList
  file-close
end



to read_request

  file-open "/Users/fabiodellinfante/Desktop/richieste_create.csv"
  set richieste_create[]
  set j 0
  set firstList []

  while [not file-at-end?] [
    set csv file-read-line
    set csv word csv ","  ; add comma for loop termination

    let mylist []  ; list of values
    while [not empty? csv]
    [
      let $y position "," csv
      let $item1 substring csv 0 $y  ; extract item
      carefully [set $item1 read-from-string $item1][] ; convert if number
      set mylist lput $item1 mylist  ; append to list
      set csv substring csv ($y + 1) length csv  ; remove item and comma
    ]
    ;show first mylist
    ;show mylist
    set richieste_create lput mylist richieste_create
  ]

   show richieste_create

end





to fun

  show any? pods
   ;;if comp-type = "WIND_TIPO_1" [a]

end

to run-py

py:setup "/opt/anaconda3/bin/python3"
  let lista list random(10) random(20)
  print("print della lista casuale")
  show lista
(
py:run
  "import importlib.util"
  "spec = importlib.util.spec_from_file_location('module.name','/Users/fabiodellinfante/Desktop/ex.py')"
  "foo = importlib.util.module_from_spec(spec)"
  "spec.loader.exec_module(foo)"
  )
  print("print lista da python")
  (py:set "array" lista)
 (set lista py:runresult "foo.createList(array)")
  print("print lista da netlogo")
  show lista

end


to creaDatasetPod

py:setup "/opt/anaconda3/bin/python3"
   (
py:run
  "import importlib.util"
  "spec = importlib.util.spec_from_file_location('module.name','/Users/fabiodellinfante/Desktop/provaNumpyCsv.py')"
  "foo = importlib.util.module_from_spec(spec)"
  "spec.loader.exec_module(foo)"
  )

  (py:run
  "foo.creaDataSet()")

end

;to read-py
;
;  py:setup "/opt/anaconda3/bin/python3"
;  let lista list random(10) random(20)
;  let lista2 list random(10) random(20)
;  let lista3 list random(10) random(20)
;  let lista4 list random(10) random(20)
;
;  print("Liste prima di essere riempire")
;
;  show lista
;  print("------------")
;
;  show lista2
;  print("------------")
;
;  show lista3
;  print("------------")
;
;  show lista4
;  print("------------")
;
;  (
;py:run
;  "import importlib.util"
;  "spec = importlib.util.spec_from_file_location('module.name','/Users/fabiodellinfante/Desktop/script.py')"
;  "foo = importlib.util.module_from_spec(spec)"
;  "spec.loader.exec_module(foo)"
;  "pod=[]"
;  )
;
;  print("print lista da python")
;
;  let j 1
;
;  (while[j <= number]
;
;    [set j j + 1
;
;      (set lista py:runresult "foo.createPod()")
;
;      show(lista)
;
;      print("------------")]
;
;     )
;
;  ;;(foreach number
;    ;;[(set lista py:runresult "foo.createPod()")
;    ;;show lista
;      ;;print("------------")])
;
;  print("Liste dopo del riempimento")
;
;  show lista
;  print("------------")
;
;  show lista2
;  print("------------")
;
;  show lista3
;  print("------------")
;
;  show lista4
;  print("------------")
;
;
;
;end



to run-py1
set j 0
py:setup "/opt/anaconda3/bin/python3"
  let lista list random(10) random(20)

  print("print della lista casuale")
  show lista
(
py:run
  "import importlib.util"
  "spec = importlib.util.spec_from_file_location('module.name','/Users/fabiodellinfante/Desktop/DatasetNumpy.py')"
  "foo = importlib.util.module_from_spec(spec)"
  "spec.loader.exec_module(foo)"
  )
  print("print lista da python")

  (py:set "array" lista)
  (py:set "nu" number)


 (set lista py:runresult "foo.createList(array,nu)")
  print("print lista da netlogo")
  show lista
  while [j != number] [
      let a 1
      let b 2
      let c 3
      let d 4
      create-pods number [
      set size 3
      fd 5
      set color green
      set flexM       item a lista
      show flexM
      set flex_m      item b lista
      show flex_m
      set costoM      item c lista
      show costoM
      set costo_m     item d lista
      show costo_m
      set j j + 1
      set a a + 4
      set b b + 4
      set c c + 4
      set d d + 4

    ]
  ]

 show lista
end
@#$#@#$#@
GRAPHICS-WINDOW
953
10
1401
459
-1
-1
13.33333333333334
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
181
83
247
116
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
125
27
297
60
number
number
0
100
5.0
1
1
NIL
HORIZONTAL

BUTTON
137
119
292
152
read-pod-from-csv
read-pod-from-csv
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
142
194
288
227
make-aggregation
make-aggregation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
128
157
306
190
read-pod-from-python
read-pod-from-python
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
153
267
288
300
make-simulation
make-simulation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
157
230
281
263
read_request
read_request
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
0
323
418
633
plot flex
istanti
flex
0.0
100.0
0.0
1000.0
true
true
"" ""
PENS
"array_x" 1.0 0 -14439633 true "" "set-plot-pen-mode 2 plot array_x"

PLOT
420
325
923
632
plot costo
istanti
costo
0.0
100.0
0.0
10.0
true
true
"" ""
PENS
"array_y" 1.0 0 -11551813 true "" "set-plot-pen-mode 2 plot array_y"

PLOT
414
10
924
326
plot Obj
istanti
Obj
0.0
100.0
0.0
1000.0
true
true
"" ""
PENS
"array_result" 1.0 0 -2674135 true "" "set-plot-pen-mode 2 plot array_result"

PLOT
973
472
1173
622
Mix
NIL
NIL
0.0
100.0
0.0
1000.0
true
false
"" ""
PENS
"arrary_x" 1.0 0 -15040220 true "" "set-plot-pen-mode 2 plot array_x"
"array_y" 1.0 0 -8053223 true "" "set-plot-pen-mode 2 plot array_y"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
