import os
localx=True
if localx:
    # os.chdir("C:\\Users\\jcai\\Desktop\\sergio_test")
    os.chdir("U:\\GitHub\\quantum\\qpic_test")
else:
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)

import numpy as np
import pandas as pd
from qpic.qpic import *


