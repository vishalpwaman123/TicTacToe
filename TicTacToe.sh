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

echo "Enter Player1 Logo choice (X | O):"
read logo1

if (( logo1 == "x" || logo1 == "X" ))
then
	logo2="O"
else
	logo2="X"
fi
