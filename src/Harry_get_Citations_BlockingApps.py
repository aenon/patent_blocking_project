#!/bin/env python
# Get the number of apps blocked by each Motorola patent
# and plot agains the number of citations to that patent

import pandas as pd
import matplotlib as plt

Blocking = pd.read_csv("../data/Motorola_blocking_patents_1114.csv")
MotoPatents = pd.read_csv("../data/Motorola_Patents_Blocking_Citations.csv")

del Blocking['Unnamed: 0']

Blocking['Blocking_patent_str'] = ""

for i in range(0, len(Blocking)):
    Blocking['Blocking_patent_str'][i] = str(Blocking['Blocking_patent'][i])

MotoPatents['Blocking_appnumber'] = 0

for i in range(0, len(MotoPatents)):
    MotoPatents['Blocking_appnumber'][i] = len(set(Blocking['Blocked_app'][
                                               Blocking['Blocking_patent_str'] == MotoPatents['PatentID'][i]]))


X = MotoPatents['Blocking_appnumber']
Y = MotoPatents['Citations']
plt.plot(X, Y)
plt.show()
