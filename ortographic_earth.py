import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
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
proj = ccrs.Orthographic(central_longitude=0, central_latitude=20)
fig = plt.figure(figsize=(6, 6))
ax = plt.axes(projection=proj)
ax.set_global()
ax.add_feature(cfeature.LAND)
ax.add_feature(cfeature.OCEAN)
ax.add_feature(cfeature.COASTLINE)



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

ax.set_title("Earth – Orthographic Projection")
plt.show()


ax.stock_img()   # optional grayscale background Or no background at all.


