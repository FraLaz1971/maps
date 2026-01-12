set terminal pngcairo size 1000,500
set output "moon_eqc.png"
set datafile separator "\t"
set xrange [-90:90]
set yrange [-90:90]
set size ratio -1

plot \
  "images/Moon_nearside_LRO.png" binary filetype=png with rgbimage notitle, \
  "lunar_front_sites.txt" using 2:1 with points pt 7 ps 1.5 lc rgb "red" title "Craters"
