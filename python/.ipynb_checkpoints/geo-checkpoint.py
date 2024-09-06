# Load all importance packages
import geopandas
import matplotlib.pyplot as plt
import missingno as msn
import numpy as np
import pandas as pd
import seaborn as sns
from shapely.geometry import Point

% matplotlib inline
# Getting to know GEOJSON file:
country = geopandas.read_file("data/gz_2010_us_040_00_5m.json")
print(country.head())
