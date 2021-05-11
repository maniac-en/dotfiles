#!/usr/bin/env bash
if [ "$1" != "i" ]
then
	echo "$(curl -s rate.sx/1ETC)"
else
	echo "$(curl -s inr.rate.sx/1ETC)"
fi
