#!/usr/bin/env sh

curl $1 | sed  -e 's~^\([\*]\)\{3\}~\t\t\*~g' -e 's~^\([\*]\)\{2\}~\t\*~g'
