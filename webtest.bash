#!/bin/bash

status=OK;
nOK=0;
nAll=0;

echo '### OVERVIEW ###';

echo;

echo '## No GET param ##';
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">15s</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q '<a href="?n=[0-9]\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?p=details&n=1&i=1">Click for details!</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 1 ##';
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">15s</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q '<a href="?n=[0-9]\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<img class="half" src="1/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 1:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<img class="half" src="1/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid   expected picture 1:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 2:2' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=1 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 2:3' ; let nOK++; else echo ' - Wrong: found unexpected picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?p=details&n=1&i=1">Click for details!</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 ##';
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?n=1">15s</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q '<a href="?n=[0-9]\+">Tovább</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?n=1">Vissza</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 1:2 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 1:2'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<img class="half" src="2/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 2:1 '; let nOK++; else echo ' - Wrong: avoid   expected picture 2:1'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<img class="half" src="2/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 2:2' ; let nOK++; else echo ' - Wrong: avoid   expected picture 2:2'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=2 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 2:3' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 2:3'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="?p=details&n=2&i=1">Click for details!</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 3 ##';
if   curl -sS localhost:8000?n=3 | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=3 | grep -q '15s'                         ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### DETAILS ###';

echo;

echo '## p=details & n=1 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<img class="big" src="1/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 1:1'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 1:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<img class="small" src="1/vestible.jpg"/>';
	then echo ' - OK   : found expected small pic 1:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 1:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=1' | grep -q '<a href="?p=overview&n=1">Áttekintéshez újra</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=1 & i=2 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<img class="small" src="1/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 1:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 1:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<img class="big" src="1/vestible.jpg"/>';
	then echo ' - OK   : found expected big   pic 1:2'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 1:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=1&i=2' | grep -q '<a href="?p=overview&n=1">Áttekintéshez újra</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=1 & i=3 ##';
if   curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=1&i=3' | grep -q '15s'                         ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=2 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="big" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="small" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected small pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<img class="small" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected small pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=1' | grep -q '<a href="?p=overview&n=2">Áttekintéshez újra</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=2 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="small" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="big" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<img class="small" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected small pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=2' | grep -q '<a href="?p=overview&n=2">Áttekintéshez újra</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=3 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="small" src="2/kitchen.jpg"/>';
	then echo ' - OK   : found expected small pic 2:1'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:1'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="small" src="2/toilet.jpg"/>';
	then echo ' - OK   : found expected small pic 2:2'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 2:2'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<img class="big" src="2/bedroom.jpg"/>';
	then echo ' - OK   : found expected big   pic 2:3'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 2:3'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=2&i=3' | grep -q '<a href="?p=overview&n=2">Áttekintéshez újra</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=2 & i=4 ##';
if   curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=2&i=4' | grep -q '15s'                         ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=3 & i=1 ##';
if   curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=3&i=1' | grep -q '15s'                         ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### WRONG PAGE ###';

echo '## p = wrongpage ##';
if   curl -sS localhost:8000?p=wrongpage | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '15s'                         ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '=================';
echo "Σ: $status ($nOK/$nAll)";
