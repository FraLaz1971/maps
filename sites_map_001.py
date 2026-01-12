import numpy as np
import matplotlib.pyplot as plt

lats, lons, names = [], [], []
with open("lunar_sites.txt") as f:
    for line in f:
        if line.startswith("#") or line.startswith("\n"):
            continue
        print("line: ",line)
        fields = line.split(",")
        print(fields)
        lat = fields[0]
        lon = fields[1]
        name = fields[2]
        lats.append(float(lat))
        lons.append(float(lon))
        names.append(name)

x = lons
y = lats

plt.figure(figsize=(10,5))
plt.scatter(x, y, s=40)
for xi, yi, ni in zip(x, y, names):
	print(xi,yi,ni)
	plt.text(xi, yi, ni, fontsize=8)

plt.xlabel("Longitude (deg)")
plt.ylabel("Latitude (deg)")
plt.title("Moon Sites Equirectangular Projection")
plt.grid(True)
plt.show()
