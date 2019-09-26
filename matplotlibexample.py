#coding:utf-8

import numpy as np
import matplotlib.pyplot as plt
from pylab import *
# 定义数据部分
x = np.arange(0., 10, 0.2)
y0 = np.arange(0., 10, 0.2)
xt = [1,2,3,4,5]
y= [5,4,5,7,9]
y1 = np.cos(x)
y2 = np.sin(x)
y3 = np.sqrt(x)
#制 4 条函数曲线
# 第一个就能画普通的折线图
plt.plot(xt, y, color='blue', linewidth=1.5, linestyle='-', marker='.', label=r'$y = cos{x}$')
plt.plot(x, y0, color='blue', linewidth=1.5, linestyle='-', marker='.', label=r'$y = cos{x}$')
plt.plot(x, y1, color='blue', linewidth=1.5, linestyle='-', marker='.', label=r'$y = cos{x}$')

plt.plot(x, y2, color='green', linewidth=1.5, linestyle='-', marker='*', label=r'$y = sin{x}$')

plt.plot(x, y3, color='m', linewidth=1.5, linestyle='-', marker='x', label=r'$y = \sqrt{x}$')
plt.show()
