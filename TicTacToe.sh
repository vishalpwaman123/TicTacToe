#!/bin/bash -x

function initial()
{
local b=1
for (( i=0 ; i<9 ; i++ ))
do
		board[$i]=" $((b++)) "
done
}

function Toss()
{
check=$(($RANDOM%2))
if (( $check == 1 ))
then
	echo $check
else
	echo $check
fi

}

function display()
{
local i2=0
for (( i=0 ; i<3 ; i++ ))
do
	for (( i1=0 ; i1<3 ; i1++ ))
	do
		printf "|---|"
	done
	printf "\n"
	
	for (( j=0 ; j<3 ; j++ ))
	do
		printf "|${board[$((i2++))]}|"
	done
	printf "\n"
	for (( i1=0 ; i1<3 ; i1++ ))
	do
		printf "|---|"
	done
	printf "\n"
done

}

initial

echo "Enter Player1 Logo choice (X | O):"
read logo1

if (( logo1 == "x" || logo1 == "X" ))
then
	logo2="O"
else
	logo2="X"
fi

echo "Let's Toss (Enter) :"
read a

clear

t="$( Toss )"

if (( $t==0 ))
then 
	echo "Player1 Win the toss "
else
	echo "Player2 Win the toss "
fi
printf "\n\n"
display

printf "\n\n"
