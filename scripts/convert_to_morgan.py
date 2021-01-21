from __future__ import print_function
from rdkit.Chem import *
from rdkit.Chem import AllChem
import re
import sys

bits = 3

if len(sys.argv) > 1:
    bits = int(sys.argv[1])

with open("reactions.csv") as f:
    for line in f:
        x = re.split(",", line)

        m1 = MolFromSmiles(x[1])
        bits1 = AllChem.GetMorganFingerprintAsBitVect(m1,bits,nBits=2048)

        m2 = MolFromSmiles(x[2])
        bits2 = AllChem.GetMorganFingerprintAsBitVect(m2,bits,nBits=2048)

        print("%s,%s,%s,%s" % (x[0],bits1.ToBase64(),bits2.ToBase64(),x[4]), end = '')

