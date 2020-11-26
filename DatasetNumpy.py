import csv
from random import random
import numpy as np
with open('file.csv', mode='w') as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    #scriviamo prima la riga di intestazione
    #csv_writer.writerow(['Time','Flex'])
    i=0
    numero=0
    arr = []
    for numero in range(96):
        csv_writer.writerow([numero])
        numero = numero +1
        list = []
        for i in range(96):
          val = int(random()*100)
          list.append(val)
        csv_writer.writerow(list )


    #aggiungiamo ora i dati
def sommatrice(a,b):
    print('Questa è la funzione somma.')
    print('Fornisce la somma di due numeri passati come parametri.')
    risultato = a + b
    print('Il risultato della somma è ' + str(risultato))

def createList(arr1,nu):
    arr1 = [np.arange(0,96)]
    for _ in range(nu):

        flex_M = np.random.randint(1000, size=(1,96))
        flex_M[0,0]=1
        flexm = np.random.randint(50, size=(1,96))
        flexm[0,0]=1
        costo_M = np.random.randint(1000,size=(1,96))
        costo_M = costo_M/100
        costo_M[0,0]=1
        costom = np.random.randint(20,size=(1,96))
        costom = costom/100
        costom[0,0]=1


        tot = np.append(flex_M,flexm,axis=0)
        tot1= np.append(tot,costo_M,axis = 0)
        tot2= np.append(tot1,costom,axis = 0)
        arr1 = np.append(arr1,tot2,axis=0)



    print("ok arr creato")
    print(arr1)
    return arr1
