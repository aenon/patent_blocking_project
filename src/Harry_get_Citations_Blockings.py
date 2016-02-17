# coding: utf-8
# Author: Xilin Sun <xilinsun@berkeley.edu>
# get_Citations_Blockings.py
import pandas as pd

# Read datasets
# Read patent IDs as strings

MotoPatents = pd.read_csv("../data/Motorola_Patent_IDs.csv", dtype=str)
Blocking = pd.read_csv("../Blocking_Count_Str.csv", dtype=str)
Citing = pd.read_csv("../Citing_Count_Str.csv", dtype=str)

# getBlockingNumber: given a patent id, get the number of patents that are
# blocked by it.


def getBlockingNumber(PatentID):
    blockingDF = Blocking['Blockings'][Blocking['PatentID'] == PatentID]
    if len(blockingDF) < 1:
        blockingNumber = 0
    else:
        blockingNumber = int(Blocking['Blockings'][
                             Blocking['PatentID'] == PatentID])
    return blockingNumber

MotoPatents['Blockings'] = ""
# Get number of patents blocked for all Motorola patents
for i in range(0, len(MotoPatents['PatentID'])):
    MotoPatents['Blockings'][i] = getBlockingNumber(MotoPatents['PatentID'][i])

# getCitationNumber: given a patent id, get the number of patents that cite it


def getCitationNumber(PatentID):
    citationDF = Citing['Citations'][Citing['PatentID'] == PatentID]
    if len(citationDF) < 1:
        citationNumber = 0
    else:
        citationNumber = int(Citing['Citations'][
                             Citing['PatentID'] == PatentID])
    return citationNumber

MotoPatents['Citations'] = ""

for i in range(0, len(MotoPatents['PatentID'])):
    MotoPatents['Citations'][i] = getCitationNumber(MotoPatents['PatentID'][i])

# The ratio of #blockings / #citations
# If there are no citations, ratio = 0
MotoPatents['Ratio'] = 0.0

for i in range(0, len(MotoPatents['PatentID'])):
    if MotoPatents['Citations'][i] < 1:
        MotoPatents['Ratio'][i] = 0
    else:
        MotoPatents['Ratio'][i] = float(MotoPatents['Blockings'][
                                        i]) / float(MotoPatents['Citations'][i])

MotoPatents.to_csv("Motorola_Patents_Blocking_Citations.csv", index=False)
