set term pngcairo size 1200,600
set output "earth_mollweide.png"

set view map
set size ratio -1
set border 0
unset tics

set angles degrees
set mapping spherical

#set proj mollweide

set xrange [-180:180]
set yrange [-90:90]

set grid

plot "cities.txt" using 2:1 \
     with points pt 7 ps 1.5 lc rgb "red", \
     "" using 2:1:3 with labels offset 1,1 notitle

