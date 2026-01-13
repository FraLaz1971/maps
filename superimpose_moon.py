import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

# ----------------------------------------
# Load image
# ----------------------------------------
img = Image.open("Moon_nearside_LRO.jpg")

# ----------------------------------------
# Load crater data
# ----------------------------------------
lats, lons, names = [], [], []

with open("lunar_crater_sites.txt") as f:
    for line in f:
        if line.startswith("#") or not line.strip():
            continue
        lat, lon, name = line.split("\t")
        lats.append(float(lat))
        lons.append(float(lon))
        names.append(name.strip())

# Convert to radians
lat = np.radians(lats)
lon = np.radians(lons)

# ----------------------------------------
# Orthographic projection (center lat0=0, lon0=0)
# ----------------------------------------
x = np.cos(lat) * np.sin(lon)
y = np.sin(lat)

# Visibility condition (near side only)
visible = np.cos(lat) * np.cos(lon) >= 0

x = x[visible]
y = y[visible]
names = np.array(names)[visible]

# ----------------------------------------
# Plot
# ----------------------------------------
plt.figure(figsize=(6, 6))

plt.imshow(
    img,
    extent=[-1, 1, -1, 1]
)

plt.scatter(x, y, s=80, c="red", edgecolors="black", zorder=3)

for xi, yi, ni in zip(x, y, names):
    plt.text(xi, yi, ni, color="white", fontsize=10,
             ha="left", va="bottom")

plt.axis("off")
plt.title("Moon Nearside – Orthographic Projection with Craters")

plt.show()

