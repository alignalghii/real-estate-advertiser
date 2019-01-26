#!/bin/bash

status=OK;
nOK=0;
nAll=0;

echo '### OVERVIEW ###';

echo;

echo '## No GET param ##';
if   curl -sS localhost:8000     | grep -q '<a class="timer" data-interval="15" href="?n=2">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?p=details&n=1&i=1">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 1 ##';
if   curl -sS localhost:8000?n=1 | grep -q '<a class="timer" data-interval="15" href="?n=2">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?p=details&n=1&i=1">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 1 & i = 1 ##';
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<a class="timer" data-interval="15" href="?n=2">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<a href="?n=2">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=1' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=1' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=1' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=1' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=1' | grep -q '<a href="?p=details&n=1&i=1">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 1 & i = 2 ##';
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<a class="timer" data-interval="15" href="?n=2">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<a href="?n=2">.\{0,33\}Következő</a>'; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=2' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=2' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=2' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=1&i=2' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=1&i=2' | grep -q '<a href="?p=details&n=1&i=2">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 ##';
if   curl -sS localhost:8000?n=2 | grep -q '<a class="timer" data-interval="15" href="?n=1">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?n=1">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<img class="half" src="2/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 2:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<img class="half" src="2/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 2:2' ; let nOK++; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?p=details&n=2&i=1">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 & i = 1 ##';
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<a class="timer" data-interval="15" href="?n=1">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=1' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<a href="?n=1">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=1' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=1' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<img class="half" src="2/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 2:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<img class="half" src="2/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 2:2' ; let nOK++; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=1' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=1' | grep -q '<a href="?p=details&n=2&i=1">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 & i = 2 ##';
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<a class="timer" data-interval="15" href="?n=1">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=2' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<a href="?n=1">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=2' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=2' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<img class="half" src="2/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 2:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<img class="half" src="2/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 2:2' ; let nOK++; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=2' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=2' | grep -q '<a href="?p=details&n=2&i=2">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 & i = 3 ##';
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<a class="timer" data-interval="15" href="?n=1">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=3' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<a href="?n=1">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=3' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=3' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<img class="half" src="2/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 2:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<img class="half" src="2/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 2:2' ; let nOK++; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=3' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=2&i=3' | grep -q '<a href="?p=details&n=2&i=3">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 & i = 4 ##';
if   curl -sS 'localhost:8000?n=2&i=4' | grep -q 'Error.*picture'      ; then echo ' + OK   : error page with picture malindexing error' ; let nOK++; else echo ' - Wrong: no error page for picture malindexing'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no nextpage indeed'; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'    ; then echo ' + OK   : there is no prevpage indeed'; let nOK++; else echo ' - Wrong: it thinks there is a prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: found unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'kitchen.jpg'                 ; then echo ' + OK   : avoid unexpected picture *:1 '; let nOK++; else echo ' - Wrong: found   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=2&i=4' | grep -q '[Dd]etails';
	then echo ' + OK   : there can be no details for a malindexed, nonexisting picture'; let nOK++;
	else echo ' - Wrong: there can be no details for a malindexed, nonexisting picture'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 3 ##';
if   curl -sS localhost:8000?n=3 | grep -q '[Ee]rror.*flat'              ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### DETAILS ###';

echo;

echo '## p=details & n=1 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<img class="big" src="1/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 1:1'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 1:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<img class="small-focused" src="1/kitchen.jpg"/>';
	then echo ' - OK   : found expected focus pic 1:1'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 1:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<img class="small" src="1/vestible.jpg"/>';
	then echo ' - OK   : found expected small pic 1:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 1:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<a class="timer" data-interval="60" href="?p=overview&n=1">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=1">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<a href="?p=details&n=1&i=2">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<a href="[^"*]">.\{0,33\}Előző</a>';
	then echo ' - OK   : impossible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=1 & i=2 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<img class="big" src="1/vestible.jpg"/>';
	then echo ' - OK   : found expected big   pic 1:2'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 1:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<img class="small" src="1/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 1:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 1:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<img class="small-focused" src="1/vestible.jpg"/>';
	then echo ' - OK   : found expected focus pic 1:2'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 1:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<a class="timer" data-interval="60" href="?p=overview&n=1&i=2">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=1&i=2">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<a href="?p=details&n=1&i=1">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<a href="[^"*]">.\{0,33\}Következő</a>';
	then echo ' - OK   : impossible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=1 & i=3 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '[Ee]rror.*picture'           ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=2 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="big" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="small-focused" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected focus pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="small" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected small pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="small" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected small pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<a class="timer" data-interval="60" href="?p=overview&n=2">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=2">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<a href="?p=details&n=2&i=2">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<a href="[^"*]">.\{0,33\}Előző</a>';
	then echo ' - OK   : impossible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=2 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="big" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="small" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="small-focused" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected focus pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="small" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected small pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<a class="timer" data-interval="60" href="?p=overview&n=2&i=2">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=2&i=2">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<a href="?p=details&n=2&i=1">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<a href="?p=details&n=2&i=3">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=3 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="big" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="small" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="small" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected small pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="small-focused" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected focus pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<a class="timer" data-interval="60" href="?p=overview&n=2&i=3">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=2&i=3">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<a href="?p=details&n=2&i=2">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<a href="[^"]*">.\{0,33\}Következő</a>';
	then echo ' - OK   : impossible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=4 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '[Ee]rror.*picture'           ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=3 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### WRONG PAGE ###';

echo '## p = wrongpage ##';
if   curl -sS localhost:8000?p=wrongpage | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '=================';
echo "Σ: $status ($nOK/$nAll)";
