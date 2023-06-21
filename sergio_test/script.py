import os
localx=True
if localx:
    # os.chdir("C:\\Users\\jcai\\Desktop\\sergio_test")
    os.chdir("d:\\GitHub\\quantum\\sergio_test")
else:
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)

import numpy as np
import pandas as pd
from SERGIO.sergio import sergio

sim = sergio(number_genes=3, number_bins = 3, number_sc = 1000, noise_params = 1, decays=0.8, sampling_state=15, noise_type='dpd')
sim.build_graph(input_file_taregts ="in1.txt", input_file_regs="in2.txt", shared_coop_state=2)

sim.simulate()
expr = sim.getExpressions()
expr_clean = np.concatenate(expr, axis = 1)
count_matrix = sim.convert_to_UMIcounts(expr_clean)
# count_matrix = np.concatenate(count_matrix, axis = 1)

#res = pd.DataFrame(count_matrix)
#res.to_csv("output.csv", sep = "\t", index = False, header=False)

