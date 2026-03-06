#!/bin/bash

valideaza_input()
{
	if [ "$#" -ne 1 ]; then
		echo "trebuie exact 1 argument"
		exit 1
	fi

	if [[ ! $1 =~ ^[a-zA-Z0-9_-]+$ ]]; then
		echo "nu sunt respectate cerintele"
		exit 1
	fi
}

valideaza_input "$@"

nume="$1"
dir="$HOME/$nume"

mkdir -p "$dir/bin"
mkdir -p "$dir/obj"
mkdir -p "$dir/src"
mkdir -p "$dir/inc"

touch "$dir/src/${nume}_src.c"
touch "$dir/inc/${nume}_inc.h"
touch "$dir/${nume}.c"
touch "$dir/${nume}.h"
touch "$dir/build.sh"

chmod u+x "$dir/build.sh"

echo "structura proiect ${nume} realizata cu succes"
