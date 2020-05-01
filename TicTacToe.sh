
ROWS=3;
COLUMNS=3;
placeHolder="-";
player1="X";
player2="O";
rowPosition=0;
columnPostion=0;


declare -A gameBoard

function initBoard() {
	for (( row=0; row<ROWS; row++ ))
	do
		for (( column=0; column<COLUMNS; column++ ))
		do
			if [[ $row -eq $fill_row && $column -eq $fill_column ]]
			then
				gameBoard[$row, $column]=$fill_symbol;
			else
				gameBoard[$row, $column]=$placeHolder;
			fi
		done
	done
}

function printBoard() {
	printf "\n~ Tic Tac Toe ~"
	printf "\n-------------\n"
	for (( row=0; row<ROWS; row++ ))
	do
		for ((column=0; column<COLUMNS; column++ ))
		do
			printf "| ${gameBoard[$row, $column]} "
		done
		printf "|\n-------------\n"
	done
}

initBoard
printBoard


function filingBoard() {
	fill_row=$1
	fill_column=$2
	fill_symbol=$3

	gameBoard[$fill_row, $fill_column]=$fill_symbol;
}



function	occupiedPositionCheck() {
	row=$1;
	column=$2;

	if [[ ${gameBoard[$row, $column]} == $placeHolder ]]
	then
		echo "position is free"
		return 0
	else
		return 1
	fi
}



function playerPlay() {
	while [ true ]
	do
		read -p "Enter Row : " player_row
		read -p "Enter Column : " player_column

		occupiedPositionCheck $row $column
	
		if [[ $? -eq 0 ]]
		then
			filingBoard $player_row $player_column $playerSymbol
		else
			echo "position is already Occupied, try diffrent space."
			continue
		fi
	done
}


function horizontalRowCheck() {
	row=0;
	column=$1;
	symbol=$2;

	while (( ${gameBoard[$row, $column]} == $symbol && $row < $ROWS ))
	do
		(( row++ ))
	done

	if [[ $row -eq $ROWS ]]
	then
		return 1
	fi
	return 0
}
function verticalColumnCheck() {
	columns=0;
	row=$1;
	symbol=$2;
	
	while (( ${gameBoard[$row, $column]} == $symbol && $column < $COLUMNS ))
	do
		(( column++ ))
	done

	if [[ $column -eq $COLUMNS ]]
	then
		return 1
	fi
	
	return 0	

}

function checkHorizontallyFilliedBoard() {
	column=0;
	while ((column < $COLUMNS ))
	do
		horizontalRowCheck $column $playerSymbol
		resultForPlayer=$?

		horizontalRowCheck $column $compSymbol
		resultForComputer=$?

		if [[ $resultForPlayer -eq 1 ]]
		then
			return 1
		fi

		if [[ $resultForComputer -eq 1 ]]
		then
			return 2
		fi

		(( column++ ))
	
	done
	
	return 0

}

function checkVerticallyFilliedBoard() {
	row=0;
	while (( $row < $ROWS ))
	do
		verticalColumnCheck $row $playerSymbol
		resultForPlayer=$?

		verticalColumnCheck $row $compSymbol
		resultForComputer=$?

		if [[ $resultForPlayer -eq 1 ]]
		then
			return 1
		fi

		if [[ $resultForComputer -eq 1 ]]
		then
			return 2
		fi
	
		(( row++ ))

	done

	return 0

}

function checkLeftDiagonal() {
	symbol=$1
	diagonal=0

	if [[ $ROWS -eq $COLUMNs ]]
	then
		while (( ${gameBoard[$diagonal, $diagonal]} == $symbol && $diagonal < $COLUMNS ))
		do
			(( diagonal++ ))
		done

		if [[ $diagonal -eq 3 ]]
		then
			return 1
		fi
		return 0

	fi
	return 0
}

function checkRightDiagonal() {
	symbol=$1
	row=0
	column=$(( $COLUMNS - 1 ))

	while (( $column > 0 && ${gameBoard[$row,$column]} == $symbol ))
	do
		(( row++ ))
		(( column-- ))
	done

	if [[ $row -eq $ROWS ]]
	then
		return 1
	fi
	return 0
}

function leftDiagonalFilliedCheck() {
	checkLeftDiagonal $playerSymbol
	resultForPlayer=$?

	checkRightDiagonal $compSymbol
	resultForComputer=$?

	if [[ $rsultForPlayer -eq 1 ]]
	then
		return 1
	fi

	if [[ $resultForComputer -eq 1 ]]
	then
		return 2
	fi

	return 0
}

function rightDiagonalFilliedCheck() {
	checkRightDiagonal $playerSymbol
	rsultForPlayer=$?

	checkRightDiagonal $compSymbol
	resultForComputer=$?

	if [[ $resultForPlayer -eq 1 ]]
	then
		return 1
	fi

	if [[ $resultForComputer -eq 1 ]]
	then
		return 2
	fi

	return 0
}

function computerPlay() {
	while [ true ]
	do
		computer_rows=$(( RANDOM % 3 ))
   	computer_Columns=$(( RANDOM % 3 ))

	   occupiedPositionCheck $computer_rows $computer_columns
	
   	if [[ $? -eq 0 ]]
   	then
      	filingBoard $computer_rows $computer_columns $compSymbol
   	else
      	echo "position is already occupied. try duffrent space"
			continue
   	fi
	done
}


function checkWin() {
	checkVerticallyFilledBoard
	resultForVericallyFillied=$?

	checkHorizontallyFilledBoard
	resultForHorizontallyFillied=$?

	checkLeftDiagonal
	resultFoLleftDiagonal=$?

	checkRightDiagonal
	resultForRightDiagonal=$?

	if [[ $resultForVerticallyFilled -eq 1 || $resultForHorizontallyFilled -eq 1 || $resultForLeftDiagonal -eq 1 || $resultForRightDiagonal -eq 1 ]]
	then
		echo "player have Win the Game..!"
		return 1	
	fi

	if [[ $resultForVerticallyFilled -eq 2 || $resultForHorizontallyFilled -eq 2 || $resultForLeftDiagonal -eq 2 || $resultForRightDiagonal -eq 2 ]]
	then
		echo "computer have win the Game..!"
		return 1
	fi
	
	f [ $? -eq 1 ]
   then
      echo "Game is draw..!"
      return 1
   fi

	return 0
}



function playGame() {

	while [ true ]
	do
			playerPlay
			printBoard
			checkWin			
			if [[ $? == 1 ]]
			then
				break;
			fi
			
			computerPlay
			printBoard
			checkWin
			if [[ $? == 1 ]]
			then 
				break;
			fi
		
	done 
}




function tossCoin() {
	echo -e "\n press Enter to Toss a Coin :"
	read ch
	coin=$(( RANDOM % 2 ))

	#flip coin
	if (( $coin == 0 ))
	then
		echo "you are Playing First..."
	else
		echo "computer is Playing First..."
	fi

	playGame 
}

tossCoin


