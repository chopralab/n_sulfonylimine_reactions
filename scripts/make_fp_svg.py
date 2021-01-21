from __future__ import print_function
from rdkit.Chem import *
from rdkit.Chem import AllChem
from rdkit.Chem import Draw
import re
import sys

fp_id = int(sys.argv[1])

needs_adjust = 0

if fp_id > 2048:
    needs_adjust = 1
    fp_id = fp_id - 2048

with open("reactions.csv") as f:
    for line in f:
        x = re.split(",", line)
        m = {}
        if not needs_adjust:
            m = MolFromSmiles(x[1])
        else:
            m = MolFromSmiles(x[2])
        bi = {}
        bits = AllChem.GetMorganFingerprintAsBitVect(m,3,nBits=2048,bitInfo=bi)

        if bits[fp_id - 1] == 0:
            continue

        mfp3_svg = Draw.DrawMorganBit(m, fp_id - 1, bi)

        out = open("%d.svg" % (fp_id + needs_adjust * 2048), 'w')
        out.write(mfp3_svg)
        out.close()

        break

