# -*- coding: utf-8 -*-
"""
Created on Sat Feb  6 03:02:19 2016

@author: xilin
"""

import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import pandas as pd
# Data generation
blocking_dist = pd.read_csv("../data/Blocking_distribution_all.csv")

fig = plt.figure()
ax1 = fig.add_subplot(111, projection='3d')
xpos = blocking_dist['pub_year'].tolist()
num_elements = len(xpos)

ypos = blocking_dist['blocking_month'].tolist()
ypos1 = [0] * num_elements
# for i in range(0,num_elements):
#    yposelement = ypos[i].split('-')
#    ypos1[i] = float(yposelement[0]+'.'+yposelement[1])
for i in range(0, num_elements):
    monthStrings = ypos[i].split('-')
    monthCount = 12 * (int(monthStrings[0]) - 2011) + int(monthStrings[1])
    ypos1[i] = monthCount


zpos = z = [0] * num_elements
dx = [0.35] * num_elements
#dx = np.ones(num_elements)
dy = [0.9] * num_elements
#dy = np.ones(num_elements)
dz = blocking_dist['count'].tolist()

ax1.set_xlabel('Year of Publication')
ax1.set_ylabel('Month of Blocking from 2011 to 2014')
# ax1.bar3d(xpos, ypos1, zpos, dx, dy, dz, color='#00ceaa')
ax1.bar3d(xpos, ypos1, zpos, dx, dy, dz, color='#C4D4FF')
plt.show()
