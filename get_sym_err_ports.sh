#!/bin/bash

[[ $# -gt 0 ]] && FILE=$1 || FILE="ibdiagnet2.pm"

printf "#------------------------------------------------------------------------------\n"
printf "%-10s %-11s %-6s %-10s %10s %s\n"  "#err_cnt" "(dec)" "lid" "lid(dec)" "name"
printf "#------------------------------------------------------------------------------\n"

awk '
/^Port/ { split($1, a, "="); port=a[2]; split($2, a, "="); lid=a[2]; split($6, a, "="); name=a[2] }
#/^FWInfo_Extended_Major/ {split($1, a, "="); fwmajor=a[2]; print $1}
#/^FWInfo_Extended_Minor/ {split($1, a, "="); fwmin=a[2]; print $1}
#/^FWInfo_Extended_SubMinor/ {split($1, a, "="); fwsubmin=a[2]}
/^symbol_error_counter/ { split($1, arr, "=")
	if (  strtonum(arr[2]) != 0 )  { printf("%-10s %-11s %-6s %-10d %s\n",  arr[2], strtonum(arr[2]),  lid, strtonum(lid),  name)}
}
' < $FILE
