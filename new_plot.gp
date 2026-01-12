# --- 1. CONFIGURATION ---
set datafile separator ','
set angles degrees
unset border
unset tics
set size ratio 0.5
#set xrange [-180:180]
#set yrange [-90:90]

# --- 2. PROJECTION MATH ---
ra_shift(h) = (h > 180) ? h - 360 : h
sinc(a) = (a == 0) ? 1.0 : sin(a) / (a * pi / 180.0)
alpha(lam, phi) = acos(cos(phi) * cos(lam / 2.0))
aitoff_x(lam, phi) = (2.0 * cos(phi) * sin(lam / 2.0)) / sinc(alpha(lam, phi))
aitoff_y(lam, phi) = sin(phi) / sinc(alpha(lam, phi))

# --- 3. COSMETIC GRID (GRATICULE) ---
set style line 10 lc rgb "#bbbbbb" lw 0.5 dt 2  # Thin dashed lines for grid
set for [d=-60:60:30] label at -185, d sprintf("%+d°", d) textcolor rgb "gray" right
set for [r=0:330:30] label at ra_shift(r), -95 sprintf("%dh", r/15) textcolor rgb "gray" center

# --- 4. OUTPUT ---
set term pngcairo size 1200,600 background rgb "black"
set output 'messier_map_aitoff_2026.png'

# --- 5. PLOT COMMAND ---
# Includes a dummy plot for the grid and the actual data points
plot \
    for [phi=-60:60:30] [lam=-180:180] '+' using (aitoff_x(lam, phi)):(aitoff_y(lam, phi)) with lines ls 10 notitle, \
    for [lam=-150:150:30] [phi=-90:90] '+' using (aitoff_x(lam, phi)):(aitoff_y(lam, phi)) with lines ls 10 notitle, \
    'messier_short.csv' using (aitoff_x(ra_shift($1), $2)):(aitoff_y(ra_shift($1), $2)):((12 - $3) * 0.3) \
    with points pt 7 ps variable lc rgb "#00ffff" title "Messier Catalog (2026)"

