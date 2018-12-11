#!/bin/bash

for NUM in $@;do
	printf "%04d " ${NUM}
done
printf "\n"
