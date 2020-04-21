#!/bin/bash -x

function initial()
{
for (( i=0 ; i<3 ; i++ ))
do
	for (( j=0 ; j<3 ; j++ ))
	do
		board[$i,$j]= " - "
	done
done
}

initial
