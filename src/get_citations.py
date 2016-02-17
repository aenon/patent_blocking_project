# -*- coding: utf-8 -*-
"""
Created on Wed Jan 20 16:08:56 2016

@author: Thibault
"""

import pandas as pd
import numpy as np

# Loading the data
data_dir = '../data'

# training and validation sets
train_file = data_dir + '/blocking1114.csv'

# Opening the blocking data
TrainFile = pd.read_csv(train_file, header=None)
TrainFile.columns = ['Application', 'Patent_Blocking']


# Opening the Portfolio database

portf = data_dir + '/SamplePortfolioforBerkeley.csv'
Moto_database = pd.read_csv(portf, sep=',')


# Creating the query

Moto_Patents = np.asarray(Moto_database['Patent #'])

# Returns


def foo(s1):
    return "'{}'".format(s1)


def query(table):
    query = 'SELECT uspatentcitation.citation_id, uspatentcitation.patent_id FROM uspatentcitation WHERE uspatentcitation.citation_id='
    for k in table:
        if k != table[-1]:
            query += foo(str(k)) + ' OR uspatentapplication.patent_id='
        else:
            query += foo(str(k))
    return query

print(query(Moto_Patents))


# Connecting to the server
"NEED TO CONNECT TO SQL DATABASE USING MySQL"

# Doing the query to get the database


"""

SELECT uspatentcitation.citation_id, uspatentcitation.patent_id
FROM uspatentcitation
WHERE uspatentcitation.citation_id='7046910'
OR uspatentcitation.citation_id='5903133'
OR uspatentcitation.citation_id='8395587'
OR uspatentcitation.citation_id='6408436'
OR uspatentcitation.citation_id='7190956'
OR uspatentcitation.citation_id='6778512'
OR uspatentcitation.citation_id='5794185'
OR uspatentcitation.citation_id='6592696'
OR uspatentcitation.citation_id='8078203'
OR uspatentcitation.citation_id='8229428'
OR uspatentcitation.citation_id='7555696'
OR uspatentcitation.citation_id='5946653'
OR uspatentcitation.citation_id='7675970'


""""
