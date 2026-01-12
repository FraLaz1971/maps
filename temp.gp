#unset border
#unset tics
set size ratio 0.5
set terminal pngcairo
set output 'preproc_aitoff.png'
#plot 'temp.dat' with points
plot 'preproc_aitoff.dat' using 1:2:((12 - $3) * 0.3) \
with points pt 7 ps variable lc rgb 'blue' title 'Messier Objects (Aitoff)'
