# 1. Configuration and Data Handling
set datafile separator ','
set angles degrees
unset border
unset tics
set size ratio 0.5

# 2. Mathematical Functions for Mollweide Projection
# The Mollweide projection requires an iterative solution for the auxiliary angle theta.
# Gnuplot can't easily do this iteratively in a function definition, so we define 
# a common approximation or use a predefined version if available in newer gnuplot versions.
# We will use the standard explicit form for demonstration.

# For gnuplot versions that do not support iterative calculation easily:
# The Mollweide projection is defined implicitly, making it tricky for single-line gnuplot functions.
# Instead, let's use the explicit formulas provided in gnuplot demos for Hammer projection 
# which is very similar to Aitoff. Let's try to isolate the issue to the data plotting first.

# The previous Aitoff math should have been sufficient. The persistent single point 
# implies the loop iteration might be failing to pick up all points.

# Let's try the simplest projection: Plate Carrée (Cartesian)

# 2. Simple Plate Carrée (Cartesian) Projection Functions
# This is a direct mapping of RA and Dec to X and Y.
ra_shift(h) = (h > 180) ? h - 360 : h
pc_x(ra) = ra_shift(ra)
pc_y(dec) = dec

# 3. Plotting Configuration
set term pngcairo size 1000,500
set output 'messier_map_cartesian.png'
set xrange [-180:180]
set yrange [-90:90]
set xlabel "Right Ascension (Shifted Degrees)"
set ylabel "Declination (Degrees)"
set border 1
set tics in

# 4. Plotting Command for 100 points
plot 'messier_short.csv' using (pc_x($1)):(pc_y($2)):((12 - $3)*0.3) \
     with points pt 7 ps variable lc rgb "blue" title "Messier Objects (Cartesian)"

