import matplotlib.pyplot as plt
import cartopy.crs as ccrs

# Read ASCII file
lats = []
lons = []
names = []

with open("cities.txt") as f:
    for line in f:
        if line.startswith("#") or line.startswith("\n"):
            continue
        fields = line.split()
        lat = fields[0]
        lon = fields[1]
        name = fields[2]
        lats.append(float(lat))
        lons.append(float(lon))
        names.append(name)

# Projection
proj = ccrs.Mollweide()

fig = plt.figure(figsize=(10, 5))
ax = plt.axes(projection=proj)

ax.set_global()
ax.coastlines()
ax.gridlines(draw_labels=False)

# Scatter points (data are lon/lat in PlateCarree)
ax.scatter(
    lons, lats,
    transform=ccrs.PlateCarree(),
    color="red",
    s=40
)
 
# Labels
for name, lat, lon in zip(names, lats, lons):
    ax.text(
        lon, lat, name,
        transform=ccrs.PlateCarree(),
        fontsize=8
    )

ax.set_title("Cities on Earth – Mollweide Projection")
plt.show()

#Switch to Moon craters

#Replace coastlines with a circle outline:

ax.stock_img()   # optional grayscale background Or no background at all.
