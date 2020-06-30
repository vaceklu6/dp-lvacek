#!/bin/bash

folder="time_800"
file_prefix="result_${folder}_"
file_test="test_${folder}_"
output_file="Gnuplot/${folder}_table.dat"

tmpfile=$(mktemp /tmp/file_XXXXXX)

printf 'qps;"packets captured with probe";"packets sent";"Packet loss"\n' > "$tmpfile"

for i in $(ls -1 ${folder}/${file_prefix}*); do
    number=$(echo "$i" | rev | cut -d'_' -f 1 | rev | sed 's/[^0-9]//g')
    echo "$number"
    queries_result=$(cat "${folder}/${file_prefix}${number}" | grep "queries" | sed 's/.*"queries": \([0-9]*\).*/\1/')
    test_sent=$( cat "${folder}/${file_test}${number}" | grep "total sent" | sed 's/.*total sent \([0-9]*\).*/\1/')
    test_recv=$( cat "${folder}/${file_test}${number}" | grep "total recv" | sed 's/.*total recv \([0-9]*\).*/\1/')
#    echo "$test_sent"
    packet_loss=$(echo "scale=10; ( 100 - ($queries_result / ($test_sent / 100))) " | bc | awk '{printf "%f\n", $0}')
#    $(echo "scale=10; ($userSec + $sysSec + 60*($sysMin + $sysMin)) " | bc | awk '{printf "%f\n", $0}')
    printf "%s;%s;%s;%s\n" ${number} "${queries_result}" ${test_sent}  ${packet_loss}>> "$tmpfile" #${test_recv}
done

sort -k 1 -n "$tmpfile" > "$output_file"
rm "$tmpfile"
