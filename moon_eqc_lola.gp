#set terminal pngcairo size 1024,449
#set output "moon_eqc.png"
#set datafile separator ","
set xrange [0:1023]
set yrange [0:340]
set size ratio -1
dx(h) = ((h+180)/360)*1024
dy(i) = ((i+60)/120)*341

plot "lro_lrockaguya_demmerge_60n60s_1024_341.png" binary filetype=png with rgbimage notitle, \
  "lunar_crater_sites.txt" using (dx($2)):(dy($1)) with points pt 7 ps 0.4 lc rgb "red" title "Craters", \
  "lunar_crater_sites.txt" using (dx($2)):(dy($1)):3 with labels notitle tc lt 4
