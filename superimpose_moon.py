import matplotlib.pyplot as plt
import numpy as np
from PIL import Image, ImageOps
lats, lons, names = [], [], []

# Load image
img = Image.open("images/Moon_nearside_LRO.jpg")

# Load points
with open("lunar_crater_sites.txt") as f:
    for line in f:
        if line.startswith("#") or line.startswith("\n"):
            continue
        print("line: ",line)
        fields = line.split("\t")
        print(fields)
        lat = fields[0]
        lon = fields[1]
        name = fields[2]
        lats.append(float(lat))
        lons.append(float(lon))
        names.append(name)

plt.figure()
plt.imshow(img, extent=[-90, 90, -90, 90])
plt.scatter(lons, lats, s=20, c="red")

for xi, yi, ni in zip(lons, lats, names):
        print(xi,yi,ni)
        plt.text(xi, yi, ni,color="white", fontsize=8)

plt.xlabel("Longitude (deg)")
plt.ylabel("Latitude (deg)")
plt.title("Moon – Equirectangular Map with Sites")
plt.show()

