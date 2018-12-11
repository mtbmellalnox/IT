#!/bin/bash

for NUM in $@;do
	printf "0x%04x " ${NUM}
done
printf "\n"
