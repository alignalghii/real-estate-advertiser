#!/usr/bin/awk -f

BEGIN            {ok=0}
       /if.*60s/ {ok=1}
 ok              {print "# " $0}
!ok              {print}
 ok && /fi/      {ok=0}
