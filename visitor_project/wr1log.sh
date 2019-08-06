#!/bin/bash
echo "cat /home/work/labBash/visitor_project/wr.txt | sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'"
echo "Пользователь"  `whoami` "Статус : ЗАШЕЛ | " `date`" | В " `hostname` >> /home/work/labBash/visitor_project/wr.txt
exit 0;
