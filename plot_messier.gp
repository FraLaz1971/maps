# 1. Configuration and Data Handling
set datafile separator ','
set angles degrees
# Handle missing/non-numeric data robustly
set datafile missing "null"
set datafile missing ":"

# 2. Mathematical Functions
# Ensure RA is in the range [-180, 180] for correct projection centering
ra_shift(h) = (h > 180) ? h - 360 : h

# Sinc function must handle the a==0 case, where sin(a)/a is 1.
# The 'a' here is alpha, which is in degrees as per 'set angles degrees'.
sinc(a) = (a == 0) ? 1.0 : sin(a) / (a * pi / 180.0)

# Main Aitoff projection functions
alpha(lambda, phi) = acos(cos(phi) * cos(lambda / 2.0))
aitoff_x(lambda, phi) = (2.0 * cos(phi) * sin(lambda / 2.0)) / sinc(alpha(lambda, phi))
aitoff_y(lambda, phi) = sin(phi) / sinc(alpha(lambda, phi))

# 3. Plotting Configuration
set term pngcairo size 1000,500
set output 'messier_map.png'
unset border
unset tics
set size ratio 0.5
set xrange [-180:180]
set yrange [-90:90]

# 4. Plotting Command
# Col 1 (RA), Col 2 (Dec), Col 3 (vmag). Use a scaling formula for ps variable.
plot 'messier_short.csv' using (aitoff_x(ra_shift($1), $2)):(aitoff_y(ra_shift($1), $2)):(12 - $3) \
     with points pt 7 ps variable lc rgb "blue" title "Messier Objects"

