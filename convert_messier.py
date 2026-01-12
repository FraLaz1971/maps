from astropy.table import Table
import pandas as pd

# 1. Load your CSV data (assuming you downloaded the one above)
df = pd.read_csv('messier.csv')

# 2. Convert to an Astropy Table
messier_table = Table.from_pandas(df)

# 3. Write to a FITS file
messier_table.write('messier_catalog.fits', format='fits', overwrite=True)

