#!/bin/sh

format="<commit hash=\"%h\"><date>%cd</date><message><![CDATA[# %B]]></message></commit>"

  git  --no-pager -C $1 log -n $2 --date=iso --pretty=tformat:"$format"  \
| tidy --input-xml yes --escape-cdata true --wrap 0                      \
| sed  -e 's~^\([\*]\)\{3\}~\t\t\*~g' -e 's~^\([\*]\)\{2\}~\t\*~g'
