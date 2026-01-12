set terminal pngcairo size 1000,500
set output "mercator_cities.png"

deg2rad(x) = x*pi/180
merc_y(lat) = log(tan(pi/4 + deg2rad(lat)/2))

set xrange [-180:180]
set yrange [-3.2:3.2]

set xlabel "Longitude (deg)"
set ylabel "Mercator Y"
set grid
set title "Mercator Projection – Surface Points"

plot "cities.txt" using 2:(merc_y($1)) with points pt 7 ps 1.5 title "Cities on Earth"

