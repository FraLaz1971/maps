# --- 1. CONFIGURATION ---
set datafile separator ','
unset border
unset tics
set size ratio 0.5
# Map ranges from -180 to 180 (x) and -90 to 90 (y) in coordinate space
# but the projection math will output values roughly in [-pi, pi]
set xrange [-3.2:3.2]
set yrange [-1.6:1.6]

# --- 2. PROJECTION MATH (Radians-Safe) ---
deg2rad = pi/180.0
ra_shift(h) = (h > 180) ? h - 360 : h
get_alpha(lam, phi) = acos(cos(phi*deg2rad) * cos(lam*deg2rad / 2.0))
get_sinc(a) = (a == 0) ? 1.0 : sin(a) / a

# Projection functions for plotting
aitoff_x(lam, phi) = (2.0 * cos(phi*deg2rad) * sin(lam*deg2rad / 2.0)) / get_sinc(get_alpha(lam, phi))
aitoff_y(lam, phi) = sin(phi*deg2rad) / get_sinc(get_alpha(lam, phi))

# --- 3. COSMETIC SETTINGS ---
set style line 10 lc rgb "#444444" lw 0.5 dt 2  # Grid style: dark gray, dashed
set style line 11 lc rgb "#ffffff" lw 1.2       # Boundary style: white solid

# Labels for RA (Hours) and Dec (Degrees)
set for [d=-60:60:30] label at -3.3, aitoff_y(0, d) sprintf("%+d°", d) textcolor rgb "gray" right font ",8"
set for [r=0:330:30] label at aitoff_x(ra_shift(r), 0), -1.7 sprintf("%dh", r/15) textcolor rgb "gray" center font ",8"

# --- 4. OUTPUT ---
set term pngcairo size 1200,600 background rgb "black"
set output 'messier_aitoff_complete_2026.png'

# --- 5. COSMETIC GRID (GRATICULE) ---
set style line 10 lc rgb "#bbbbbb" lw 0.5 dt 2  # Thin dashed lines for grid
set for [d=-60:60:30] label at -185, d sprintf("%+d°", d) textcolor rgb "gray" right
set for [r=0:330:30] label at ra_shift(r), -95 sprintf("%dh", r/15) textcolor rgb "gray" center

# --- 6. OUTPUT ---
set term pngcairo size 1200,600 background rgb "black"
set output 'messier_map_aitoff_2026.png'

# --- 7. PLOT COMMAND ---
# Includes a dummy plot for the grid and the actual data points
plot \
    for [phi=-60:60:30] [lam=-180:180] '+' using (aitoff_x(lam, phi)):(aitoff_y(lam, phi)) with lines ls 10 notitle, \
    for [lam=-150:150:30] [phi=-90:90] '+' using (aitoff_x(lam, phi)):(aitoff_y(lam, phi)) with lines ls 10 notitle, \
    'messier_short.csv' using (aitoff_x(ra_shift($1), $2)):(aitoff_y(ra_shift($1), $2)):((12 - $3) * 0.3) \
    with points pt 7 ps variable lc rgb "#00ffff" title "Messier Catalog (2026)"
