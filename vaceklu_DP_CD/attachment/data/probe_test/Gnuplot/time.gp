#set terminal png font "Helvetdawica,12" #font 20 size 1280,960

set terminal pdf font "Helvetdawica,12"
set output "packet_loss.pdf"

set encoding utf8

Cisco = "#99ffff"; Wheezy_Jool = "#808080"; Wheezy_Tayga = "#4671d5"; Jessie_Jool = "#ff9c00"; Jessie_Tayga = "yellow"; Stretch_Jool = "green"; Stretch_Tayga = "#ff0000"; Lost = "black"


set xlabel "Čas [s]"
#set key left top
set key outside
set key bottom center
set key maxrows 3
set key height 2
#set auto y
set yrange [-1:16]
#set ytics -0.5,1.5
set ylabel "Ztrátovost paketů [%]"
#set grid ytics lc rgb "#bbbbbb" lw 1 lt 2
set style data linespoints
set style line 1 linetype 1 linewidth 1  dashtype 7 linecolor rgb 'green' pointtype 13
set style line 2 linetype 1 linewidth 1  dashtype 7 linecolor rgb 'blue' pointtype 7
set style line 3 linetype 1 linewidth 1  dashtype 7 linecolor rgb 'red' pointtype 5
set style line 4 linetype 1 linewidth 1  dashtype 7 linecolor rgb 'brown' pointtype 9
set style line 5 linetype 1 linewidth 1  dashtype 7 linecolor rgb 'orange' pointtype 11
set auto x
#set xrange [0:3000]
#set arrow 1 from 0,1 to 9,1 nohead  dt 2 lt 1

#set style line 2 lc rgb 'black' pt 7
#set style line 3 lc rgb 'blue' pt 5
#set style histogram cluster gap 2
#set style fill solid border -1
#set boxwidth 1
#set label 22 "  rotate by 90" at 42.0,0.0 rotate by 90 point ps 2
#set boxwidth 0.9

set datafile separator ";"
set xtics rotate by 45 right

plot 'time_500_table.dat' using 4:xtic(1) ls 1 ti col ,\
     'time_600_table.dat' u 4 ls 3 ti col ,\
     'time_800_table.dat' u 4 ls 2 ti col ,\
     'time_1000_table.dat' u 4 ls 4 ti col

