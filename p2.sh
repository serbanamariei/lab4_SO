#!/bin/bash

valideaza_input()
{
	if [ "$#" -lt 1 ]; then
		echo "trebuie macar un argument"
		exit 1
	fi

	if [[ ! $1 =~ ^[a-zA-Z0-9_-]+$ ]]; then
		echo "primul argument trebuie sa contina doar litere cifre si/sau caractere '-' si '_'"
		exit 1
	fi

	if [ "$#" -gt 3 ]; then
		echo "trebuie cel mult 3 argumente"
		exit 1
	fi
}

valideaza_tip()
{
	tip=$2
	if [[ ! ${tip,,} == "c" && ! ${tip,,} == "c++" ]]; then
		echo "al doilea argument trebuie sa fie de tip C sau C++"
		exit 1
	fi
}

valideaza_nr()
{
	if [[ ! $3 =~ ^[0-9]+$ ]]; then
		echo "al treilea argument trebuie sa fie de tip numeric"
		exit 1
	fi
}

valideaza_input "$@"

case "$#" in
	"1")
		if [[ "$@" == "-h" || "$@" == "--help" ]]; then
			echo "cum ar trebui sa arate linia de comanda: "
			echo "./<nume_script>.sh <nume_proiect> <c/c++> <numar intreg>"
		else
			nume="$1"
			tip=".c"
			nr=1
		fi
		;;

	"2")
		valideaza_tip "$@"
		nume="$1"
		tip="$2"
		nr=1
		;;
	"3")
		valideaza_nr "$@"
		nume="$1"
		tip="$2"
		nr="$3"
		;;
	*)
		echo "apelare invalida, consultati cu -h sau --help structura apelului"
		exit 1
		;;
esac

if [ -z "$nume" ]; then
	exit 0
fi

dir="$HOME/$nume"

mkdir -p "$dir/bin"
mkdir -p "$dir/obj"
mkdir -p "$dir/src"
mkdir -p "$dir/inc"

if [[ ${tip,,} == ".c" ]]; then
	tip=".c"
elif [[ ${tip,,} == "c++" ]]; then
	tip=".cpp"
else
	tip=".c"
fi

for (( i=1; i<=nr; i++ )); do
	if [ $i -gt 1 ]; then
		touch "$dir/${nume}$i.h"
		touch "$dir/${nume}$i${tip}"
		touch "$dir/src/${nume}$i_src$i${tip}"
		touch "$dir/inc/${nume}$i_inc.h"
	else
		touch "$dir/${nume}.h"
		touch "$dir/${nume}${tip}"
		touch "$dir/src/${nume}_src${tip}"
		touch "$dir/inc/${nume}_inc.h"
	fi

done

touch "$dir/build.sh"

chmod u+x "$dir/build.sh"

echo "structura proiect ${nume} realizata cu succes"
