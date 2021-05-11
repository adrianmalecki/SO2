#!/bin/bash -eu

#"+2.0
#1	Znajdź w pliku access_log zapytania, które mają frazę ""denied"" w linku
#2	Znajdź w pliku access_log zapytania typu POST
#3	Znajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10
#4	Znajdź w pliku access_log wszystkie zapytania NIEWYSŁANE z adresu IP tylko z FQDN
#5	Znajdź w pliku access_log unikalne zapytania typu DELETE
#6	Znajdź unikalnych 10 adresów IP w access_log"


# 1
cat ./dane/access_log | cut -d' ' -f6,7,8 | grep '/denied'

# 2
cat ./dane/access_log | cut -d' ' -f6,7,8 | grep "\"POST"

# 3
cat ./dane/access_log | cut -d' ' -f1,6,7,8 | grep -E "^64\.242\.88\.10 "

# 4
OCTET="(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"
cat ./dane/access_log | cut -d' ' -f1,6,7,8 | grep -Ev "^${OCTET}\.${OCTET}\.${OCTET}\.${OCTET}"

# 5
cat ./dane/access_log | cut -d' ' -f6,7,8 | grep  "\"DELETE" | sort -u

# 6
OCTET="(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"
cat ./dane/access_log | grep -Po "${OCTET}\.${OCTET}\.${OCTET}\.${OCTET} " | sort -u | sed 10q