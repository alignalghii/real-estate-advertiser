#/bin/bash

status=OK

echo '## No GET param ##';
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">15s</a>'      ; then echo ' + OK   : wait for the second'          ; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi;
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'     ; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi;
if ! curl -sS localhost:8000     | grep -q '<a href="?n=\d\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'  ; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi;
if   curl -sS localhost:8000     | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi;
if ! curl -sS localhost:8000     | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi;
if   curl -sS localhost:8000     | grep -q 'kitchen.jpg'                 ; then echo ' + OK   : found   expected picture 1:1 '; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi;
if   curl -sS localhost:8000     | grep -q 'vestible.jpg'                ; then echo ' + OK   : found   expected picture 1:2 '; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi;
if ! curl -sS localhost:8000     | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi;
if ! curl -sS localhost:8000     | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi;

echo;

echo '## n = 1 ##';
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">15s</a>'      ; then echo ' + OK   : wait for the second'          ; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi;
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'     ; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=1 | grep -q '<a href="?n=\d\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'  ; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi;
if   curl -sS localhost:8000?n=1 | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=1 | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi;
if   curl -sS localhost:8000?n=1 | grep -q 'kitchen.jpg'                 ; then echo ' + OK   : found   expected picture 1:1 '; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi;
if   curl -sS localhost:8000?n=1 | grep -q 'vestible.jpg'                ; then echo ' + OK   : found   expected picture 1:2 '; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=1 | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=1 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi;


echo;

echo '## n = 2 ##';
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?n=1">15s</a>'      ; then echo ' + OK   : wait for the first again/rep' ; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=2 | grep -q '<a href="?n=\d\+">Tovább</a>'; then echo ' + OK   : there is no more nextpage'    ; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="1">Vissza</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi;
if ! curl -sS localhost:8000?n=2 | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi;
if   curl -sS localhost:8000?n=2 | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=2 | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi;
if   curl -sS localhost:8000?n=2 | grep -q 'kitchen.jpg'                 ; then echo ' + OK   : found   expected picture 2:1 '; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi;
if   curl -sS localhost:8000?n=2 | grep -q 'toilet.jpg'                  ; then echo ' + OK   : found   expected picture 2:2' ; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=2 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi;

echo;

echo '## n = 3 ##';
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">15s</a>'   ; then echo ' + OK      : it can proceed to second'     ; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi;
if   curl -sS localhost:8000?n=3 | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=3 | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=3 | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi;

echo;

echo '=================';
echo "Σ: $status";
