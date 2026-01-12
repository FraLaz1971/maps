# 1. Configuration and Data Handling
#set angles degrees 
#unset border
#unset tics
#set size ratio 0.5
#set xrange [-180:180]
#set yrange [-90:90]

# 3. Output
set terminal png
set output 'temp.png'

# 4. Plotting Command
# Col 1 (RA), Col 2 (Dec), Col 3 (vmag). Using 0.3 scaling as you preferred.
#plot 'preproc_aitoff.dat' using $1:$2:((12 - $3) * 0.3) \
plot 'temp.dat' with points
#with points pt 7 ps variable lc rgb 'blue' title 'Messier Objects (Aitoff)'
