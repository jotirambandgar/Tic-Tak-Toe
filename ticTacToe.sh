#!/bin/bash -x
gameBoard=( 1 2 3 4 5 6 7 8 9 );

function getGameBoard(){
	for block in ${gameBoard[@]}
	do
		echo -n "$block |"
		if [ $(( $block%3 )) -eq 0 ]
		then
			if [ $block -ne 9 ]
			then
				echo  -e "\n__________"
			else
				echo -e "\n"
			fi
		fi
	done
}

function main(){
	echo "Welcome to Tic tac toe"
	getGameBoard
	if [ $(( RANDOM%2 )) -eq 1 ]
	then
		player=X
		echo "X is Assign to user "
	else
		player=O
      echo "O is Assign to user"
	fi

}
main
