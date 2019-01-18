#/bin/bash

status=OK

echo '## No GET param ##';
if   curl -sS localhost:8000     | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'   ; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi;
if ! curl -sS localhost:8000     | grep -q '<a href="?n=\d\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi;

echo;

echo '## n = 1 ##';
if   curl -sS localhost:8000?n=1 | grep -q '<a href="?n=2">Tovább</a>'   ; then echo ' + OK   : it can proceed to second'   ; else echo ' - Wrong: it cannot proceed to second'    ; status=Wrong; fi;
if ! curl -sS localhost:8000?n=1 | grep -q '<a href="?n=\d\+">Vissza</a>'; then echo ' + OK   : there is no prevpage indeed'; else echo ' - Wrong: it thinks there is a prev page' ; status=Wrong; fi;

echo;

echo '## n = 2 ##';
if ! curl -sS localhost:8000?n=2 | grep -q '<a href="?n=\d\+">Tovább</a>'; then echo ' + OK   : there is no more nextpage'  ; else echo ' - Wrong: it thinks there is a nextpage'  ; status=Wrong; fi;
if   curl -sS localhost:8000?n=2 | grep -q '<a href="1">Vissza</a>'      ; then echo ' + OK   : there is a prevpage indeed' ; else echo ' - Wrong: it thinks there is no prev page'; status=Wrong; fi;

echo;

echo '## n = 3 ##';
if curl -sS localhost:8000?n=3   | grep -q '[Ee]rror'                    ; then echo ' + OK   : error page'                 ; else echo ' - Wrong: there is no error page'         ; status=Wrong; fi;

echo;

echo '=================';
echo "Σ: $status";
