#!/bin/bash

[[ $# -gt 0 ]] && FILE=$1 || FILE="ibdiagnet2.pm"

printf "#------------------------------------------------------------------------------\n"
printf "%-10s %-11s %-10s %-6s %-10s %s\n"  "#xmit_wait" "(dec)" "discard" "lid" "lid(dec)" "name"
printf "#------------------------------------------------------------------------------\n"

awk '
/^Port/ { split($1, a, "="); port=a[2]; split($2, a, "="); lid=a[2]; split($6, a, "="); name=a[2]; }
/^port_xmit_discard/ { split($1, xd, "=") }
/^port_xmit_wait/ { split($1, xw, "=")
printf("%-10s %-11s %-10d %-6s %-10d %s\n",  xw[2], strtonum(xw[2]),  strtonum(xd[2]), lid, strtonum(lid), name);
}

' < $FILE
