#!/usr/bin/env bash
if [ "$1" != "i" ]
then
	echo "$(curl -s rate.sx/1BTC)"
else
	echo "$(curl -s inr.rate.sx/1BTC)"
fi
