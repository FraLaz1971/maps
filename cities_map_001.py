import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature

# Load data
lats, lons, names = [], [], []
with open("cities.txt") as f:
    for line in f:
        if line.startswith("#") or line.startswith("\n"):
            continue
        print("line: ",line)
#        lat, lon, name = line.split(" ")
        fields = line.split(" ")
        print(fields)
        lat = fields[0]
        lon = fields[1]
        name = fields[2]
        lats.append(float(lat))
        lons.append(float(lon))
        names.append(name)

# Mercator projection
proj = ccrs.Mercator()

fig = plt.figure(figsize=(10, 6))
ax = plt.axes(projection=proj)

ax.set_global()
ax.add_feature(cfeature.LAND)
ax.add_feature(cfeature.OCEAN)
ax.add_feature(cfeature.COASTLINE)
ax.gridlines(draw_labels=True)

ax.scatter(
    lons, lats,
    transform=ccrs.PlateCarree(),
    color="red", s=40
)

for lon, lat, name in zip(lons, lats, names):
    ax.text(lon, lat, name, transform=ccrs.PlateCarree(), fontsize=9)

plt.title("Cities on Earth – Mercator Projection")
plt.show()

