#!/bin/sh


foo () {
	printf "bar"
	printf "bar again"
}

bar () {
	echo "debug me"
	printf "bar"
}

baz () {
	print "baz"
	print "baz again"
}

foo
bar
baz
