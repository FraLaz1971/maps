set style data histograms
set style histogram cluster
set style fill solid 1.0 border lt -1
set terminal pngcairo
set output "histo001.png"
set xtics rotate by 45 right
plot 'histo001.dat' using 2:xtic(1)
