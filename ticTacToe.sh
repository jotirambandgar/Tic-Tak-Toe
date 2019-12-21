#!/bin/bash -x

declare -a gameBoard
turn=""
counter=0
winningFlag=0

function resetBoard(){

	gameBoard=( "1" "2" "3" "4" "5" "6" "7" "8" "9" );

}

function getGameBoard(){

	echo " _ _ _ _ _ _"
	for (( i=0; i<${#gameBoard[@]}; i++ ))
	do
		echo -n "${gameBoard[$i]}  |"
		if [ $(( $(($i+1))%3 )) -eq 0 ]
		then
			if [ $i != "9" ]
			then
				echo  -e "\n _ _ _ _ _ _"
			else
				echo -e "\n"
			fi
		fi
	done

}

function winnerChecker(){

	playerSymbol=$1
	for (( i=0 ; i < ${#gameBoard[@]} ; i+=3 ))
	do
		#condition for row checking
		if [ ${gameBoard[$i]} == $playerSymbol ]  &&  [ ${gameBoard[$(( $i + 1 ))]} == $playerSymbol ] &&  [ ${gameBoard[$(( $i + 2 ))]} == $playerSymbol ]
		then
			winningFlag=1
		fi
		#condition for diagonal checking
		if [ $i -eq 0 ]
		then
			if [ ${gameBoard[$i]} == $playerSymbol ] && [ ${gameBoard[$(( $i + 4 ))]} == $playerSymbol ] && [ ${gameBoard[$(( $i + 8 ))]} == $playerSymbol ]
			then
				winningFlag=1
			fi
			if [ ${gameBoard[$(( $i + 2))]} == $playerSymbol ] && [ ${gameBoard[$(( $i + 4 ))]} == $playerSymbol ] && [ ${gameBoard[$(( $i + 6 ))]} == $playerSymbol ]
			then
				winningFlag=1
			fi
		fi

	done

	for (( j=0; j <= 2 ; j++ ))
	do
		#condition for column checking
		if [ ${gameBoard[$j]} == $playerSymbol ] && [ ${gameBoard[$(( $j + 3 ))]} == $playerSymbol ] && [ ${gameBoard[$(( $j + 6 ))]} == $playerSymbol ]
		then
			winningFlag=1
		fi
	done

	echo $winningFlag $1
}


function blockOpponent(){

	blockStatus=0
	for (( i=0 ; i<=3 ; i++ ))
	do
		if [ $i -eq 0 ]
		then
			#row
			if [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[$(( $i + 1 ))]} == $player ] && [ ${gameBoard[$(( $i + 2 ))]} != $computer ]
			then
				gameBoard[$(( $i + 2 ))]=$computer
				blockStatus=1
				break
			fi

			if [ ${gameBoard[ $(( $i + 1 )) ]} == $player ] && [ ${gameBoard[ $(( $i + 2 ))]} == $player ] && [ ${gameBoard[ $i]} != $computer ]
			then
				gameBoard[$i]=$computer
				blockStatus=1
				break
			fi

			if [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[ $(( $i + 2 ))]} == $player ] && [ ${gameBoard[$(( $i + 1 ))]} != $computer ]
         then
            gameBoard[$(( $i + 1 ))]=$computer
				blockStatus=1
				break
         fi

			if [ ${gameBoard[$(( $i + 4 ))]} == $player ] && [ ${gameBoard[$(( $i + 8 ))]} == $player ] && [ ${gameBoard[$i]} != $computer ]
			then
				gameBoard[$i]=$computer
				blockStatus=1
				break
			fi

			if [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[$(( $i + 8 ))]} == $player ] && [ ${gameBoard[$(( $i + 4 ))]} != $computer ]
         then
            gameBoard[$(($i + 4 ))]=$computer
            blockStatus=1
				break
         fi

			if [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[$(($i + 4 ))]} == $player ] && [ ${gameBoard[$(( $i + 8 ))]} != $computer ]
         then
            gameBoard[$(($i + 8))]=$computer
            blockStatus=1
				break
         fi
		fi

		if [ $i -eq 2 ]
		then
			if [ $gameBoard[$(($i + 2))] == $player ] && [ $gameBoard[$(( $i + 4 ))] == $player ]  && [ ${gameBoard[$i]} != $computer ]
			then
				gameBoard[$i]=$computer
            blockStatus=1
				break
			elif [ $gameBoard[$(($i))] == $player ] && [ $gameBoard[$(( $i + 4 ))] == $player ] && [ ${gameBoard[$(( $i + 2 ))]} != $computer ]
			then
				gameBoard[$(($i + 2))]=$computer
            blockStatus=1
				break
			elif [ $gameBoard[$(( $i ))] == $player ] && [ $gameBoard[$(( $i +2 ))] == $player ] && [ ${gameBoard[$(( $i + 4 ))]} != $computer ]
			then
				gameBoard[$(($i + 4))]=$computer
            blockStatus=1
				break
			fi
		fi

		if [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[$(( $i + 3 )) ]} == $player ] && [ ${gameBoard[$(( $i + 6 ))]} != $computer ]
		then
         blockStatus=1
			gameBoard[$(($i + 6))]=$computer
			break
		elif [ ${gameBoard[$i]} == $player ] && [ ${gameBoard[$(( $i + 6 )) ]} == $player ] && [ ${gameBoard[$(( $i + 3 ))]} != $computer ]
		then
         blockStatus=1
			gameBoard[$(($i + 3))]=$computer
			break
		elif [ ${gameBoard[$(( $i + 3 ))]} == $player ] && [ ${gameBoard[$(( $i + 6 )) ]} == $player ] && [ ${gameBoard[$i]} != $computer ]
		then
         blockStatus=1
			gameBoard[$i]=$computer
			break
		fi
	done

	if [ $blockStatus -eq 0 ]
	then
		for (( l=0 ; l <= 6 ; l+=3 ))
		do
			if [ ${gameBoard[$(($l))]} == $player ] && [ ${gameBoard[$(($l + 1))]} == $player ] && [ ${gameBoard[$(( $l + 2 ))]} != $computer ]
			then
         	blockStatus=1
				gameBoard[$(($l + 2))]=$computer
				break
			elif [ ${gameBoard[$l]} == $player ] && [ ${gameBoard[$(($l + 2))]} == $player ] && [ ${gameBoard[$(( $l + 1 ))]} != $computer ]
			then
         	blockStatus=1
				gameBoard[$(($l + 1))]=$computer	
				break

			elif [ ${gameBoard[$(($l + 1))]} == $player ] && [ ${gameBoard[$(($l + 2))]} == $player ] && [ ${gameBoard[$i]} != $computer ]
			then
         	blockStatus=1
				gameBoard[$l]=$computer
				break

			fi
		done
	fi

}

function selectCell(){

	if [ $turn == "P" ]
	then
		read -p "Enter your choice" choice
		if [ ${gameBoard[$(( $choice - 1 ))]} == "X" ] || [ ${gameBoard[$(( $choice - 1 ))]} == "O" ]
		then
			echo "invalid cell select another cell:"
			selectCell
		fi
		gameBoard[$(( $choice - 1 ))]=$player

	else
		blockOpponent
		if [ $blockStatus -eq 0 ]
		then
			cell=$(( RANDOM % 9 + 1 ))
			if [ ${gameBoard[$(( $cell - 1 ))]} == "X" ] || [ ${gameBoard[$(( $cell - 1 ))]} == "O" ]
      	then
         	selectCell
		 	fi
				echo "computer mark at position : $cell "
				gameBoard[$(( $cell - 1 ))]=$computer
		fi
	fi

}

function toss(){

	echo "Welcome to Tic tac toe"
	resetBoard

	if [ $(( RANDOM%2 )) -eq 1 ]
	then
		player="X"
		computer="O"
		turn="P"
		echo "X is Assign to user and player play first"
	else
		player="O"
		computer="X"
		turn="C"
      echo "O is Assign to user and computer play first"
	fi

}

function startGame(){

	while [ $counter -ne 9 ] && [ $winningFlag -ne 1 ]
	do
      selectCell
		getGameBoard
		#selectCell

		if [	$turn == "P" ]
		then
			echo -e "player turn\n"
			winnerChecker $player
			if [ $winningFlag -eq 1 ]
			then
				echo "player win"
			fi
			counter=$(( $counter + 1 ))
			turn="C"
		else
			echo -e "computer turn\n"
			winnerChecker $computer
			if [ $winningFlag -eq 1 ]
         then
            echo "computer win"
         fi


			counter=$(( $counter + 1 ))

			turn="P"
		fi

#	getGameBoard
	done

	if [ $counter -ge 9 ] && [ $winningFlag -eq 0 ]
	then
		getGameBoard
		echo "game tie"
	fi

}

toss
startGame
