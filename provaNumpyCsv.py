#!/usr/bin/env python
# coding: utf-8

# In[137]:


import numpy as np
from numpy import savetxt
import random as random
from math import *
from numpy import asarray
import pandas as pd
import csv

def creaDataSet():
    n = input('Dammi il numero di pod :' )
    nu= int(n)
    f=open('file.csv','a')
    savetxt(f,[np.arange(0,96)], delimiter = ',',fmt= "%i",)
    f.close()

    for _ in range(nu):
        f=open('file.csv','a')
        i=(0,1,2,3)
        flexM = np.random.randint(100, size=(4,96))
        flexM[i,0]=1
        print(flexM)
        flexm = np.random.randint(100, size=(4,96))
        flexm[i,0]=1
        costoM = np.random.randint(100, size=(4,96))
        costoM[i,0]=1
        costom = np.random.randint(100, size=(4,96))
        costom[i,0]=1



        tot = np.append(flexM,flexm, axis=0)
        tot1 = np.append(tot,costoM,axis = 0)
        tot2= np.append(tot1,costom,axis = 0)

        savetxt(f, tot2 , delimiter = ',',fmt= "%i",newline='\r\n' )
        f.write("\n")
        f.close()
    return i
