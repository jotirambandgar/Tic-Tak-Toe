#!/bin/bash -x
gameBoard=( "1" "2" "3" "4" "5" "6" "7" "8" "9" );

function getGameBoard(){
	 echo "_ _ _ _ _ _"
	for (( i=0; i<${#gameBoard[@]}; i++ ))
	do
		echo -n "${gameBoard[$i]}  |"
		if [ $(( $(($i+1))%3 )) -eq 0 ]
		then
			if [ $i != "9" ]
			then
				echo  -e "\n_ _ _ _ _ _"
			else
				echo -e "\n"
			fi
		fi
	done
}

function selectCell(){
	if [ $player == "X" ]
	then
		read -p "Enter your choice" choice
		gameBoard[$(( $choice - 1 ))]="X"
		getGameBoard
	fi
}

function main(){
	echo "Welcome to Tic tac toe"
	getGameBoard
	if [ $(( RANDOM%2 )) -eq 1 ]
	then
		player="X"
		echo "X is Assign to user and player play first"
	else
		player="O"
      echo "O is Assign to user and computer play first"
	fi
	selectCell
}
main
