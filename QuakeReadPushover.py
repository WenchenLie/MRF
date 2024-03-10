import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path


folder = Path(r'H:/MRF_results/4SMRF_pushover/Pushover')

weight = 0
time = np.loadtxt(folder/'Time.out')
shear = np.zeros(len(time))
SDR = np.loadtxt(folder/'SDRALL_MF.out')
for i in range(1, 6):
    data = np.loadtxt(folder/f'Support{i}.out')
    weight += data[10, 1]
    shear += data[:, 0]
shear /= -weight
print('最大剪力 =', max(shear * abs(weight)))
print('weight =', weight)
plt.plot(SDR * 100, shear)
plt.xlabel('Roof drift ratio [%]')
plt.ylabel('Normalised base shear, V/W')
plt.xlim(0, 6)
plt.ylim(0)
plt.show()
plt.show()




