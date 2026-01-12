import numpy as np
import matplotlib.pyplot as plt

from astropy.io import fits
from astropy.coordinates import SkyCoord
import astropy.units as u

# ------------------------------------------------------------
# Input FITS file
# ------------------------------------------------------------
fits_file = "messier_f.fits"

# ------------------------------------------------------------
# Read FITS binary table by EXTNAME
# ------------------------------------------------------------
with fits.open(fits_file) as hdul:
    data = hdul["MESSIER_OBJECTS"].data

names = data["Obj_Name"]
ra = data["Ra"]      # degrees
dec = data["Dec"]    # degrees
vmag = data["vmag"]  # optional, can contain NaNs

# ------------------------------------------------------------
# Create SkyCoord object (ICRS)
# ------------------------------------------------------------
coords = SkyCoord(
    ra=ra * u.deg,
    dec=dec * u.deg,
    frame="icrs"
)

# ------------------------------------------------------------
# Prepare coordinates for Aitoff projection
# RA wrapped at 180° so that RA=0 is at the center
# ------------------------------------------------------------
lon = coords.ra.wrap_at(180 * u.deg).radian
lat = coords.dec.radian

# ------------------------------------------------------------
# Optional: scale symbol size by visual magnitude
# (brighter objects -> larger symbols)
# ------------------------------------------------------------
sizes = np.full(len(vmag), 40.0)
valid = np.isfinite(vmag)
sizes[valid] = 200 / (vmag[valid] + 1.5)

# ------------------------------------------------------------
# Plot
# ------------------------------------------------------------
fig = plt.figure(figsize=(11, 5.5))
ax = fig.add_subplot(111, projection="aitoff")

sc = ax.scatter(
    lon,
    lat,
    s=sizes,
    c=vmag,
    cmap="viridis_r",
    alpha=0.85
)

# Optional labels (can be commented out if too crowded)
#for l, b, name in zip(lon, lat, names):
#    ax.text(l, b, name.strip(), fontsize=6, ha="center", va="center")

ax.grid(True)
ax.set_title("Messier Objects (ICRS) – Aitoff Projection", pad=20)

cbar = plt.colorbar(sc, orientation="horizontal", pad=0.07)
cbar.set_label("Visual magnitude (V)")

plt.tight_layout()
plt.show()

