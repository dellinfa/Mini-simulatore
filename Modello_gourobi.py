# la mia x è la flessibilità
# la mia y è il costo
# la mia z sono le richieste
#
# funzione obiettivo. Io devo minimizzare questa funzione

#       y * ( x - z )^ 2

#  i miei vincoli sono far ricaredere sia la flessibilità che il costo rispettivamente nell'intervallo tra la flex_M eflex_m e costo_M e costo_m
#        x >= flex_m
#        x <= flex_M
#        y >= costo_m
#        y <= costo_M
#


import gurobipy as gp
from gurobipy import *
from gurobipy import GRB


def optimize(flex_m,flex_M,costo_m,costo_M,richiesta):

        result = []
        # Create a new model
        m = gp.Model("modFabio")

        # Create variables
        x = m.addVar(vtype=GRB.INTEGER, name="x")
        y = m.addVar(vtype=GRB.INTEGER, name="y")
        richiesta = m.addVar(vtype=GRB.INTEGER, name="z")

        expr = QuadExpr(x - (y * richiesta) )

        # Set objective
        obj =  expr
        m.setObjective( obj , GRB.MINIMIZE)
        m.params.NonConvex = 2

            # Add constraint1:
        m.addConstr( x >= flex_m ,"c1")

            # Add constraint2:
        m.addConstr(x <= flex_M , "c2")

            # Add constraint3:
        m.addConstr(y <= costo_M , "c3")

        m.addConstr(y >= costo_m , "c4")

        m.update()
        m.optimize()

        



        for v in m.getVars():
            result.append('%g' %(v.x))
            print('%s %g' % (v.varName, v.x))

        result.append('%g' % obj.getValue())

        print('Obj: %g' % obj.getValue(),result)

        for i in range(0, len(result)):
            result[i] = int(float(result[i]))


        return(result)
