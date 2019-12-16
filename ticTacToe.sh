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
}
main
