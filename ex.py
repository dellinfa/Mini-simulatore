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

def createList(arr):
    i=0
    val = 0
    for i in range(10):
        val = int(random()*100)
        arr.append(val)
    print("ok arr creato")
    print(arr)
    return arr
