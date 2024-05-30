import os, sys
"""
Tazaki 2018 used these inputs and got the following outputs:
d1_11 = 0.352 + 0.245i
d2_11 = 0.396 + 0.124i

Lodge 2023 used the same inputs and calculated the following values (in microns):
C_ext = 92.374
C_sca = 92.285
C_abs = 0.0898
g = 0.9008
"""
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))
sys.path.append(os.path.dirname("/home/dsc/master/yasf_testing"))
sys.path.append(os.path.dirname("/home/dsc/master/"))
sys.path.append(os.path.dirname("/home/dsc/master/virga/"))
sys.path.append(os.path.dirname("/home/dsc/master/frameworks/"))

import numpy as np
import optool
from frameworks.mmf import mmf_parsing
mmf_parsing.OPTOOL_BIN_PATH = "./optool"
N = 64
R0 = 0.5
refrinds = np.array([1.4+0.0001*1j])
print(refrinds)
df = 2.0
kf = 0.825
wv = np.array([0.8])
p = mmf_parsing.run_optool(N=N, a0=R0, refrinds=refrinds, df=df, kf=kf, wavelengths=wv)

print(p.gsca)
print(p.ksca)
print(p.kext)
q_ext,q_scat = mmf_parsing.get_efficiencies(p, N, 1.0, Df=df, kf=kf)

print(q_ext)
print(q_scat)
