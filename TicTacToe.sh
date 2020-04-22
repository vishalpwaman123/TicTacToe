#!/bin/bash -x

function initial()
{
for (( i=0 ; i<3 ; i++ ))
do
	for (( j=0 ; j<3 ; j++ ))
	do
		board[$i,$j]=" - "
	done
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

t="$( Toss )"

if (( $t==0 ))
then 
	echo "Player1 Win the toss "
else
	echo "Player2 Win the toss "
fi
