#!/bin/bash

function numberOf {
	mysql -N real_estate_advertiser <<< "SELECT COUNT(*) FROM \`$1\`;";
}

function reinitDB {
	{
		tac dependencies.dat | while read g; do echo "DROP TABLE \`$g\`;"; done;
		echo;
		cat dependencies.dat | while read f; do cat "create-table-$f.sql"; done;
		echo;
		cat dependencies.dat | while read h; do cat "insert-into-$h.sql" ; done;
	}\
	|
	mysql real_estate_advertiser;
}

function checkVirginityOfDBSample {
	if
		mysql -N real_estate_advertiser <<< 'SELECT * FROM `flat` ORDER BY `order`'\
		|
		awk 'NR==1&&/^100\tVörös u.\ 99\t1$/{flag1=1} NR==2&&/200\tŐzes út  67\t2$/{flag2=1} NR>2{flag3=1} END {exit(!(flag1&&flag2&&!flag3))}';
		then
			echo " $2: Right after $1, the DB contains exactly the virgin sample";
			true;
		else
			echo " $3: Right after $1, the DB does not contain exactly the virgin sample";
			false;
	fi;
}


status=OK;
nOK=0;
nAll=0;

echo '### OVERVIEW ###';

echo;


echo '## No GET param ##';
if   curl -sS localhost:8000     | grep -q '<a class="timer" data-interval="15" href="?n=200">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?n=200">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="100/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 100:110 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:110'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<img class="half" src="100/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:120'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 200:220' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000     | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 200:230' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000     | grep -q '<a href="?p=details&n=100&i=110">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 100 ##';
if   curl -sS localhost:8000?n=100 | grep -q '<a class="timer" data-interval="15" href="?n=200">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q '<a href="?n=200">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=100 | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=100 | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q '<img class="half" src="100/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 100:110 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:110'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q '<img class="half" src="100/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:120'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=100 | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 200:220' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=100 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 200:230' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=100 | grep -q '<a href="?p=details&n=100&i=110">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 100 & i = 110 ##';
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<a class="timer" data-interval="15" href="?n=200">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<a href="?n=200">.\{0,33\}Következő</a>'   ; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=110' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=110' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<img class="half" src="100/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 100:110 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:110'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<img class="half" src="100/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:120'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=110' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 200:220' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=110' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 200:230' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=110' | grep -q '<a href="?p=details&n=100&i=110">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 100 & i = 120 ##';
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<a class="timer" data-interval="15" href="?n=200">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the second'          ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<a href="?n=200">.\{0,33\}Következő</a>'; then echo ' + OK   : it can proceed to second'     ; let nOK++; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=120' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'; then echo ' + OK   : there is no prevpage indeed'  ; let nOK++; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q 'Vörös'                       ; then echo ' + OK   : found   expected address 1'   ; let nOK++; else echo ' - Wrong: avoid   expected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=120' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<img class="half" src="100/kitchen.jpg"/>' ; then echo ' + OK   : found   expected picture 100:110 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:110'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<img class="half" src="100/vestible.jpg"/>'; then echo ' + OK   : found   expected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid   expected picture 100:120'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=120' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 200:220' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=100&i=120' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid unexpected picture 200:230' ; let nOK++; else echo ' - Wrong: found unexpected picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=100&i=120' | grep -q '<a href="?p=details&n=100&i=120">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 1'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 1'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 200 ##';
if   curl -sS localhost:8000?n=200 | grep -q '<a class="timer" data-interval="15" href="?n=100">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS localhost:8000?n=200 | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q '<a href="?n=100">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=200 | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=200 | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 100:120'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q '<img class="half" src="200/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 200:210 '; let nOK++; else echo ' - Wrong: avoid   expected picture 200:210'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q '<img class="half" src="200/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 200:220' ; let nOK++; else echo ' - Wrong: avoid   expected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=200 | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 200:230' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS localhost:8000?n=200 | grep -q '<a href="?p=details&n=200&i=210">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 2'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 2'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 200 & i = 210 ##';
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<a class="timer" data-interval="15" href="?n=100">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=210' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<a href="?n=100">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=210' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=210' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 100:120'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<img class="half" src="200/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 200:210 '; let nOK++; else echo ' - Wrong: avoid   expected picture 200:210'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<img class="half" src="200/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 200:220' ; let nOK++; else echo ' - Wrong: avoid   expected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=210' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 200:230' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=210' | grep -q '<a href="?p=details&n=200&i=210">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 200'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 200'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 200 & i = 220 ##';
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<a class="timer" data-interval="15" href="?n=100">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=220' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<a href="?n=100">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=220' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=220' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 100:120'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<img class="half" src="200/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 200:210 '; let nOK++; else echo ' - Wrong: avoid   expected picture 200:210'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<img class="half" src="200/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 200:220' ; let nOK++; else echo ' - Wrong: avoid   expected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=220' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 200:230' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=220' | grep -q '<a href="?p=details&n=200&i=220">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 200'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 200'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 200 & i = 230 ##';
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<a class="timer" data-interval="15" href="?n=100">.\{0,33\}[Kk]örbe.\{0,22\}</a>'      ; then echo ' + OK   : wait for the first again/rep' ; let nOK++; else echo ' - Wrong: no or improper waiting'         ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<script src="timer.js"></script>' && test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=230' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no more nextpage'    ; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<a href="?n=100">.\{0,33\}Előző</a>'      ; then echo ' + OK   : there is a prevpage indeed'   ; let nOK++; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=230' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q 'Őzes'                        ; then echo ' + OK   : found   expected address 2'   ; let nOK++; else echo ' - Wrong: avoid   expected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=230' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 100:120 '; let nOK++; else echo ' - Wrong: avoid unexpected picture 100:120'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<img class="half" src="200/kitchen.jpg"/>'; then echo ' + OK   : found   expected picture 200:210 '; let nOK++; else echo ' - Wrong: avoid   expected picture 200:210'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<img class="half" src="200/toilet.jpg"/>' ; then echo ' + OK   : found   expected picture 200:220' ; let nOK++; else echo ' - Wrong: avoid   expected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=230' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 200:230' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 200:230'   ; status=Wrong; fi; let nAll++;
if   curl -sS 'localhost:8000?n=200&i=230' | grep -q '<a href="?p=details&n=200&i=230">.\{0,33\}[Rr]észlet.\{0,22\}</a>';
	then echo ' + OK   : clickable for details for record 200'    ; let nOK++;
	else echo ' - Wrong: not clickable for details for record 200'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 2 & i = 240 ##';
if   curl -sS 'localhost:8000?n=200&i=240' | grep -q 'Error.*picture'      ; then echo ' + OK   : error page with picture malindexing error' ; let nOK++; else echo ' - Wrong: no error page for picture malindexing'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Következő</a>'; then echo ' + OK   : there is no nextpage indeed'; let nOK++; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q '<a href="?n=[0-9]\+">.\{0,33\}Előző</a>'    ; then echo ' + OK   : there is no prevpage indeed'; let nOK++; else echo ' - Wrong: it thinks there is a prev page'; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'Vörös'                       ; then echo ' + OK   : avoid unexpected address 1'   ; let nOK++; else echo ' - Wrong: found unexpected address 1'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'Őzes'                        ; then echo ' + OK   : avoid unexpected address 2'   ; let nOK++; else echo ' - Wrong: found unexpected address 2'     ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'vestible.jpg'                ; then echo ' + OK   : avoid unexpected picture 100:120 '; let nOK++; else echo ' - Wrong: found unexpected picture 100:120'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'kitchen.jpg'                 ; then echo ' + OK   : avoid unexpected picture *:1 '; let nOK++; else echo ' - Wrong: found   expected picture 200:210'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'toilet.jpg'                  ; then echo ' + OK   : avoid unexpected picture 200:220' ; let nOK++; else echo ' - Wrong: found   expected picture 200:220'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q 'bedroom.jpg'                 ; then echo ' + OK   : avoid   0roomfor picture 200:230' ; let nOK++; else echo ' - Wrong: found   0roomfor picture 200:230'   ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?n=200&i=240' | grep -q '[Dd]etails';
	then echo ' + OK   : there can be no details for a malindexed, nonexisting picture'; let nOK++;
	else echo ' - Wrong: there can be no details for a malindexed, nonexisting picture'; status=Wrong;
fi; let nAll++;

echo;

echo '## n = 300 ##';
if   curl -sS localhost:8000?n=300 | grep -q '[Ee]rror.*flat'              ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=300 | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=300 | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=300 | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?n=300 | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### DETAILS ###';

echo;

echo '## p=details & n=100 & i=110 ##';
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<img class="big" id="big" src="100/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 100:110'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 100:110'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<a data-n="100" data-i="110"><img class="small-focused" id="focus" src="100/kitchen.jpg"/></a>';
	then echo ' - OK   : found expected focus pic 100:110'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 100:110'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<a data-n="100" data-i="120" href="?p=details&n=100&i=120"><img class="small" src="100/vestible.jpg"/></a>';
	then echo ' - OK   : found expected small pic 100:120'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 100:120'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<a id="over" class="timer" data-interval="60" href="?p=overview&n=100">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=100">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<a id="next" href="?p=details&n=100&i=120">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=110' | grep -q '<a id="prev" href="[^"*]">.\{0,33\}Előző</a>';
	then echo ' - OK   : impossible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=100 & i=120 ##';
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<img class="big" id="big" src="100/vestible.jpg"/>';
	then echo ' - OK   : found expected big   pic 100:120'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 100:120'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<a data-n="100" data-i="110" href="?p=details&n=100&i=110"><img class="small" src="100/kitchen.jpg"/></a>';
	then echo ' - OK   : found expected small pic 100:110'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 100:110'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<a data-n="100" data-i="120"><img class="small-focused" id="focus" src="100/vestible.jpg"/></a>';
	then echo ' - OK   : found expected focus pic 100:120'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 100:120'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<a id="over" class="timer" data-interval="60" href="?p=overview&n=100&i=120">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=100&i=120">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<a id="prev" href="?p=details&n=100&i=110">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=120' | grep -q '<a id="next" href="[^"*]">.\{0,33\}Következő</a>';
	then echo ' - OK   : impossible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=100 & i=230 ##';
if   curl -sS 'localhost:8000?p=details&n=100&i=230' | grep -q '[Ee]rror.*picture'           ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=230' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=230' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=230' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=100&i=230' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=200 & i=210 ##';
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<img class="big" id="big" src="200/kitchen.jpg"/>';
	then echo ' - OK   : found expected big   pic 200:210'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 200:210'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a data-n="200" data-i="210"><img class="small-focused" id="focus" src="200/kitchen.jpg"/></a>';
	then echo ' - OK   : found expected focus pic 200:210'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 200:210'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a data-n="200" data-i="220" href="?p=details&n=200&i=220"><img class="small" src="200/toilet.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:220'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:220'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a data-n="200" data-i="230" href="?p=details&n=200&i=230"><img class="small" src="200/bedroom.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:230'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:230'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a id="over" class="timer" data-interval="60" href="?p=overview&n=200">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=200">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a id="next" href="?p=details&n=200&i=220">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=210' | grep -q '<a id="prev" href="[^"*]">.\{0,33\}Előző</a>';
	then echo ' - OK   : impossible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=200 & i=220 ##';
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<img class="big" id="big" src="200/toilet.jpg"/>';
	then echo ' - OK   : found expected big   pic 200:220'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 200:220'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a data-n="200" data-i="210" href="?p=details&n=200&i=210"><img class="small" src="200/kitchen.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:210'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:210'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a data-n="200" data-i="220"><img class="small-focused" id="focus" src="200/toilet.jpg"/></a>';
	then echo ' - OK   : found expected focus pic 200:220'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 200:220'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a data-n="200" data-i="230" href="?p=details&n=200&i=230"><img class="small" src="200/bedroom.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:230'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:230'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a id="over" class="timer" data-interval="60" href="?p=overview&n=200&i=220">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=200&i=220">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a id="prev" href="?p=details&n=200&i=210">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=220' | grep -q '<a id="next" href="?p=details&n=200&i=230">.\{0,33\}Következő</a>';
	then echo ' - OK   :   possible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=200 & i=230 ##';
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<img class="big" id="big" src="200/bedroom.jpg"/>';
	then echo ' - OK   : found expected big   pic 200:230'; let nOK++;
	else echo ' - Wrong: avoid expected big   pic 200:230'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a data-n="200" data-i="210" href="?p=details&n=200&i=210"><img class="small" src="200/kitchen.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:210'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:210'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a data-n="200" data-i="220" href="?p=details&n=200&i=220"><img class="small" src="200/toilet.jpg"/></a>';
	then echo ' - OK   : found expected small pic 200:220'; let nOK++;
	else echo ' - Wrong: avoid expected small pic 200:220'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a data-n="200" data-i="230"><img class="small-focused" id="focus" src="200/bedroom.jpg"/></a>';
	then echo ' - OK   : found expected focus pic 200:230'; let nOK++;
	else echo ' - Wrong: avoid expected focus pic 200:230'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a id="over" class="timer" data-interval="60" href="?p=overview&n=200&i=230">.\{0,33\}[Áá]ttekintéshez vissza.\{0,22\}</a>';
	then echo ' - OK   :   possible to go return to overview'; let nOK++;
	else echo ' - Wrong: impossible to go return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<script src="timer.js"></script>' && test -f timer.js; # <a href="?p=overview&n=200&i=230">↑🌐 Áttekintéshez vissza</a>
	then echo ' - OK   : 60s-timer to return to overview'   ; let nOK++;
	else echo ' - Wrong: No 60s-timer to return to overview'; status=Wrong;
fi; let nAll++;
if   curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a id="prev" href="?p=details&n=200&i=220">.\{0,33\}Előző</a>';
	then echo ' - OK   :   possible to move focus to previous picture' ; let nOK++;
	else echo ' - Wrong: impossible to move focus to previous picture' ; status=Wrong;
fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=230' | grep -q '<a id="next" href="[^"]*">.\{0,33\}Következő</a>';
	then echo ' - OK   : impossible to move focus to next picture' ; let nOK++;
	else echo ' - Wrong:   possible to move focus to next picture' ; status=Wrong;
fi; let nAll++;

echo;

echo '## p=details & n=200 & i=240 ##';
if   curl -sS 'localhost:8000?p=details&n=200&i=240' | grep -q '[Ee]rror.*picture'           ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=240' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=240' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=240' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=200&i=240' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '## p=details & n=300 & i=310 ##';
if   curl -sS 'localhost:8000?p=details&n=300&i=310' | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=300&i=310' | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=300&i=310' | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=300&i=310' | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS 'localhost:8000?p=details&n=300&i=310' | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### WRONG PAGE ###';

echo '## p = wrongpage ##';
if   curl -sS localhost:8000?p=wrongpage | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                   ; let nOK++; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Vörös'                       ; then echo ' + OK   : no address 1 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q 'Őzes'                        ; then echo ' + OK   : no address 2 on an error page'; let nOK++; else echo ' - Wrong: why address on an error page?!' ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '<img[^<>]*>'                 ; then echo ' + OK   : no picture on error page'     ; let nOK++; else echo ' - Wrong: why picture on error page?!'    ; status=Wrong; fi; let nAll++;
if ! curl -sS localhost:8000?p=wrongpage | grep -q '[Kk]örbe'                    ; then echo ' + OK   : no waiting on error page'     ; let nOK++; else echo ' - Wrong: why waiting on error page?!'    ; status=Wrong; fi; let nAll++;

echo;

echo '### ADMIN ###';

if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q 'Sikeresen felcseréltem'; then echo ' + OK   : order updater'; let nOK++; else echo ' - Wrong: order updater failed'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q 'Sikeresen felcseréltem'; then echo ' + OK   : order updater'; let nOK++; else echo ' - Wrong: order updater failed'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS -d swap=1 -d paws=1 'localhost:8000?p=admin' | grep -q '[Kk]ülönböző'; then echo ' + OK   : order error report'; let nOK++; else echo ' - Wrong: order error report missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS -d swap=2 -d paws=2 'localhost:8000?p=admin' | grep -q '[Kk]ülönböző'; then echo ' + OK   : order error report'; let nOK++; else echo ' - Wrong: order error report missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS -d swap=0 -d paws=1 'localhost:8000?p=admin' | grep -q 'Error: No such route'; then echo ' + OK   : order route failure reported'; let nOK++; else echo ' - Wrong: order route failure missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS -d swap=3 -d paws=1 'localhost:8000?p=admin' | grep -q '[Ll]étező'; then echo ' + OK   : order error report'; let nOK++; else echo ' - Wrong: order error report missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS -d swap='' -d paws=1 'localhost:8000?p=admin' | grep -q 'Error: No such route'; then echo ' + OK   : order route failure reported'; let nOK++; else echo ' - Wrong: order route failure missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;

if curl -sS            -d paws=1 'localhost:8000?p=admin' | grep -q 'Error: No such route'; then echo ' + OK   : order route failure reported'; let nOK++; else echo ' - Wrong: order route failure missing'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : admin catalogue 1'; let nOK++; else echo ' - Wrong: admin catalogue missing 1'; status=Wrong; fi; let nAll++;
if curl -sS 'localhost:8000?p=admin' | grep -q '\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : admin catalogue 2'; let nOK++; else echo ' - Wrong: admin catalogue missing 2'; status=Wrong; fi; let nAll++;



if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q '<li>.*\<2\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   :   order immediate feedback 1'; let nOK++; else echo ' - Wrong:   order immediate feedback 1 failed'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q '<li>.*\<1\>.\{0,22\}Vörös u. 99\b.*2 kép'; then echo ' + OK   : reorder immediate feedback 1'; let nOK++; else echo ' - Wrong: reorder immediate feedback 1 failed'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q '<li>.*\<1\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   :   order immediate feedback 2'; let nOK++; else echo ' - Wrong:   order immediate feedback 2 failed'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | grep -q '<li>.*\<2\>.\{0,22\}Őzes út  67\b.*3 kép'; then echo ' + OK   : reorder immediate feedback 2'; let nOK++; else echo ' - Wrong: reorder immediate feedback 2 failed'; status=Wrong; fi; let nAll++;


if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | gawk '/name="swap"/{m=1} /name="paws"/{m=2} m==1&&/selected.*\<1\>.*Őzes/{flag1=1} m==2&&/selected.*\<2\>.*Vörös/{flag2=1} END{exit(!(flag1&&flag2));}'; then echo ' + OK   :   order selections   kept at feedback 1'; let nOK++; else echo ' - Wrong:   order selections unkept at feedback 1'; status=Wrong; fi; let nAll++;
if curl -sS                     'localhost:8000?p=admin' | gawk '/name="swap"/{m=1} /name="paws"/{m=2} m==1&&!/selected/&&/\<1\>.*Őzes/{flag1=1} m==2&&!/selected/&&/\<1\>.*Őzes/ {flag2=1} END{exit(!(flag1&&flag2));}'; then echo ' + OK   :   order selections lifted at reload   1'; let nOK++; else echo ' - Wrong:   order selections not lifted at reload   1'; status=Wrong; fi; let nAll++;
if curl -sS -d swap=1 -d paws=2 'localhost:8000?p=admin' | gawk '/name="swap"/{m=1} /name="paws"/{m=2} m==1&&/selected.*\<1\>.*Vörös/{flag1=1} m==2&&/selected.*\<2\>.*Őzes/{flag2=1} END{exit(!(flag1&&flag2));}'; then echo ' + OK   : reorder selections   kept at feedback 1'; let nOK++; else echo ' - Wrong: reorder selections unkept at feedback 1'; status=Wrong; fi; let nAll++;
if curl -sS                     'localhost:8000?p=admin' | gawk '/name="swap"/{m=1} /name="paws"/{m=2} m==1&&!/selected/&&/\<1\>.*Vörös/{flag1=1} m==2&&!/selected/&&/\<1\>.*Vörös/{flag2=1} END{exit(!(flag1&&flag2));}'; then echo ' + OK   : reorder selections lifted at reload   1'; let nOK++; else echo ' - Wrong: reorder selections not lifted at reload   1'; status=Wrong; fi; let nAll++;

if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 before insertion'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 before insertion'; status=Wrong; fi; let nAll++;
if curl -isS -d 'address=Majom utca 22' 'localhost:8000?p=admin&resource=flats' | gawk '/<.*html.*>/{isBody=1} NR==1&&/201\s+Created/{flagStat=1} !isBody&&/Location: .*n=201.*/{flagLoc=1} END{flag=flagLoc&&flagStat;exit(!flag)}'; then echo ' + OK   : Location header reports and URL referring to a flat #201'; let nOK++; else echo ' - Wrong: No Location header reporting any URL referring to a flat #201'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^3$'; then echo ' + OK   : COUNT flat =  3 after insertion, new flat inserted'; let nOK++; else echo ' - Wrong: COUNT flat <> 3 after insertion, no new flat inserted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;

if curl -isS -d 'address=' 'localhost:8000?p=admin&resource=flats' | grep -q '[Nn]em.*üres'; then echo ' + OK   : Validadation refuses empty address'; let nOK++; else echo ' - Wrong: Validation accepts empty address'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after refused insertion'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after refused insertion'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;




if curl -isS -X DELETE -H 'Accept: application/json' 'localhost:8000?p=admin&resource=flats&n=100' | tr -d '\r' | awk 'NR==1&&/204 No Content/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} END{exit(!(flagStat&&flagSep&&!flagBody))}'; then echo ' + OK   : Deletion provided RESTful status code (204 No Content) in case of sending real DELETE for valid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide RESTful status code (204 No Content) in case of sending real DELETE for valid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^1$'; then echo ' + OK   : COUNT flat =  1, flat record deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 1, flat record failed to be deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;

if curl -isS -X POST -H 'Accept: application/json' 'localhost:8000?p=admin&resource=flats&method=DELETE&n=100' | tr -d '\r' | awk 'NR==1&&/204 No Content/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} END{exit(!(flagStat&&flagSep&&!flagBody))}'; then echo ' + OK   : Deletion provided RESTful status code (204 No Content)  in case of sending POST+querystring-mimicked DELETE for valid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide RESTful status code (204 No Content)  in case of sending POST+querystring-mimicked DELETE for valid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^1$'; then echo ' + OK   : COUNT flat =  1, flat record deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 1, flat record failed to be deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;



if curl -isS -X DELETE -H 'Accept: application/json' 'localhost:8000?p=admin&resource=flats&n=432' | tr -d '\r' | awk 'NR==1&&/404 Not Found/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} END{exit(!(flagStat&&flagSep&&!flagBody))}'; then echo ' + OK   : Deletion provided RESTful status code (404 Not Found) in case of sending real DELETE for invalid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide RESTful status code (404 Not Found) in case of sending real DELETE for invalid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2, flat record not deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 2, flat record deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;

if curl -isS -X POST -H 'Accept: application/json' 'localhost:8000?p=admin&resource=flats&method=DELETE&n=432' | tr -d '\r' | awk 'NR==1&&/404 Not Found/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} END{exit(!(flagStat&&flagSep&&!flagBody))}'; then echo ' + OK   : Deletion provided RESTful status code (404 Not Found)  in case of sending POST+querystring-mimicked DELETE for invalid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide RESTful status code (404 Not Found)  in case of sending POST+querystring-mimicked DELETE for invalid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2, flat record not deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 2, flat record deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;






if curl -isS -X DELETE 'localhost:8000?p=admin&resource=flats&n=100' | tr -d '\r' | awk 'NR==1&&/200 OK/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} flagBody&&/[Ss]iker.*törö?l/{flagOK=1} END{exit(!(flagStat&&flagSep&&flagBody&&flagOK))}'; then echo ' + OK   : Deletion provided plain status code (200 OK) in case of sending real DELETE for valid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide plain status code (200 OK) in case of sending real DELETE for valid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^1$'; then echo ' + OK   : COUNT flat =  1, flat record deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 1, flat record failed to be deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;

if curl -isS -X POST 'localhost:8000?p=admin&resource=flats&method=DELETE&n=100' | tr -d '\r' | awk 'NR==1&&/200 OK/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} flagBody&&/[Ss]iker.*törö?l/{flagOK=1} END{exit(!(flagStat&&flagSep&&flagBody&&flagOK))}'; then echo ' + OK   : Deletion provided plain status code (200 OK)  in case of sending POST+querystring-mimicked DELETE for valid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide plain status code (200 OK)  in case of sending POST+querystring-mimicked DELETE for valid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^1$'; then echo ' + OK   : COUNT flat =  1, flat record deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 1, flat record failed to be deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;



if curl -isS -X DELETE 'localhost:8000?p=admin&resource=flats&n=432' | tr -d '\r' | awk 'NR==1&&/200 OK/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} flagBody&&/[Nn]incs.*lakás/{flagFail=1} END{exit(!(flagStat&&flagSep&&flagBody&&flagFail))}'; then echo ' + OK   : Deletion provided plain status code (200 OK) in case of sending real DELETE for invalid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide plain status code (200 OK) in case of sending real DELETE for invalid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2, flat record not deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 2, flat record deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;

if curl -isS -X POST 'localhost:8000?p=admin&resource=flats&method=DELETE&n=432' | tr -d '\r' | awk 'NR==1&&/200 OK/{flagStat=1;next;} !flagSep&&/^$/{flagSep=1;next;} flagSep{flagBody=1} flagBody&&/[Nn]incs.*lakás/{flagFail=1} END{exit(!(flagStat&&flagSep&&flagBody&&flagFail))}'; then echo ' + OK   : Deletion provided plain status code (200 OK)  in case of sending POST+querystring-mimicked DELETE for invalid resource'; let nOK++; else echo ' - Wrong: Deletion failed to provide plain status code (200 OK)  in case of sending POST+querystring-mimicked DELETE for invalid resource'; status=Wrong; fi; let nAll++;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2, flat record not deleted'; let nOK++; else echo ' - Wrong: COUNT flat <> 2, flat record deleted'; status=Wrong; fi; let nAll++;
reinitDB;
if numberOf flat | grep -q '^2$'; then echo ' + OK   : COUNT flat =  2 after reinit'; let nOK++; else echo ' - Wrong   : COUNT flat <> 2 after reinit'; status=Wrong; fi; let nAll++;




# @TODO besides `low-level`, do also for `high plain-level` and `high REST-level`
# @TODO replace `awk` to `gawk`
reinitDB;
if checkVirginityOfDBSample 'low-level reinit'    '+ OK   ' '- Wrong'; then let nOK++       ; else status=Wrong; fi; let nAll++;

mysql real_estate_advertiser <<< 'DELETE FROM `flat` WHERE `id` = 200';
if checkVirginityOfDBSample 'low-level deletion'  '- Wrong' '+ OK   '; then let status=Wrong; else let nOK++   ; fi; let nAll++;
reinitDB;

mysql real_estate_advertiser <<< 'INSERT INTO `flat` (`address`, `order`) VALUE ('"'"'Majomtanya'"'"', 3)';
if checkVirginityOfDBSample 'low-level insertion' '- Wrong' '+ OK   '; then let status=Wrong; else let nOK++   ; fi; let nAll++;
reinitDB;



mysql real_estate_advertiser <<< 'DELETE FROM `flat` WHERE `id` = 200';
if curl -isS -X POST 'localhost:8000?p=admin&method=PUT&resource=flats&subcommand=sample-data' | tr -d '\r' | gawk 'NR==1&&/200 OK/{flagStatCode=1;next} flagStatCode&&/^$/{flagSep=1;next} flagSep&&/[Aa]datbázis.*mint[aá].*siker.*újra/{flagMsg=1} END{exit(!(flagStatCode&&flagSep&&flagMsg))}'; then echo ' + OK   : High-level plain reinit renders appropriate status code and form message'; let nOK++; else echo ' - Wrong: High level plain reinit renders wrong status code or form message'; status=Wrong; fi; let nAll++;
if checkVirginityOfDBSample 'low-level deletion and high-level plain reinit'   '+ OK   ' '- Wrong'; then let nOK++; else status=Wrong; fi; let nAll++;
reinitDB;

mysql real_estate_advertiser <<< 'INSERT INTO `flat` (`address`, `order`) VALUE ('"'"'Majomtanya'"'"', 3)';
if curl -isS -X POST 'localhost:8000?p=admin&method=PUT&resource=flats&subcommand=sample-data' | tr -d '\r' | gawk 'NR==1&&/200 OK/{flagStatCode=1;next} flagStatCode&&/^$/{flagSep=1;next} flagSep&&/[Aa]datbázis.*mint[aá].*siker.*újra/{flagMsg=1} END{exit(!(flagStatCode&&flagSep&&flagMsg))}'; then echo ' + OK   : High-level plain reinit renders appropriate status code and form message'; let nOK++; else echo ' - Wrong: High level plain reinit renders wrong status code or form message'; status=Wrong; fi; let nAll++;
if checkVirginityOfDBSample 'low-level insertion and high-level plain reinit'  '+ OK   ' '- Wrong'; then let nOK++; else status=Wrong; fi; let nAll++;
reinitDB;



mysql real_estate_advertiser <<< 'DELETE FROM `flat` WHERE `id` = 200';
if curl -isS -X POST -H 'Accept: application/json' 'localhost:8000?p=admin&method=PUT&resource=flats&subcommand=sample-data' | tr -d '\r' | gawk 'NR==1&&/201 No Content/{flagStatCode=1;next} flagStatCode&&/^$/{flagSep=1;next} flagSep{flagBody=1} END{exit(!(flagStatCode&&flagSep&&!flagBody))}'; then echo ' + OK   : High-level REST reinit renders appropriate status code'; let nOK++; else echo ' - Wrong: High level REST reinit renders wrong status code'; status=Wrong; fi; let nAll++;
if checkVirginityOfDBSample 'low-level deletion and high-level REST reinit'   '+ OK   ' '- Wrong'; then let nOK++; else status=Wrong; fi; let nAll++;
reinitDB;

mysql real_estate_advertiser <<< 'INSERT INTO `flat` (`address`, `order`) VALUE ('"'"'Majomtanya'"'"', 3)';
if curl -isS -X POST  -H 'Accept: application/json' 'localhost:8000?p=admin&method=PUT&resource=flats&subcommand=sample-data' | tr -d '\r' | gawk 'NR==1&&/201 No Content/{flagStatCode=1;next} flagStatCode&&/^$/{flagSep=1;next;} flagSep{flagBody=1} END{exit(!(flagStatCode&&flagSep&&!flagBody))}'; then echo ' + OK   : High-level REST reinit renders appropriate status code'; let nOK++; else echo ' - Wrong:  High-level REST reinit renders wrong status code'; status=Wrong; fi; let nAll++;
if checkVirginityOfDBSample 'low-level insertion and high-level REST reinit'  '+ OK   ' '- Wrong'; then let nOK++; else status=Wrong; fi; let nAll++;
reinitDB;



echo;
echo '=================';
echo "Σ: $status ($nOK/$nAll)";
