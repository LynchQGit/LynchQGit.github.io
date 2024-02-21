这一部分将演示如何使用给定的特定范围创建 Numpy 数组。
### Numpy.arrange
它通过在给定区间上使用均匀分布的值来创建数组。使用这个函数的语法如下。
```python
numpy.arange(start, stop, step, dtype)
```
它接受以下参数。

- start：区间的起始值。默认为 0。

- stop：区间结束的值，不包括此值。

- step：区间值之间的变化量。

- dtype：Numpy 数组项的数据类型。

示例
```python
import numpy as np
arr = np.arange(0, 10, 2, float)
print(arr)
```
输出：
```python
[0. 2. 4. 6. 8.]
```

示例
```python
import numpy as np
arr = np.arange(10, 100, 5, int)
print("The array over the given range is ", arr)
```
输出：
```python
The array over the given range is  [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]
```

### NumPy.linspace
它类似于`arrange`函数，但它在语法中不允许我们指定步长。
相反，它只返回在指定时间段内均匀分隔的值。系统隐式地计算步长。
语法如下。
```python
numpy.linspace(start, stop, num, endpoint, retstep, dtype)
```
它接受以下参数。

- start：区间的起始值。

- stop：区间的结束值。

- num：在区间内生成均匀间隔样本的数量。默认为 50。

- endpoint：其真值表示停止值是否包含在区间内。

- rettstep：这必须是一个布尔值。表示连续数字之间的步长和样本数。

- dtype：数组项的数据类型。

示例
```python
import numpy as np
arr = np.linspace(10, 20, 5)
print("The array over the given range is ", arr)
```
输出：
```python
The array over the given range is  [10.  12.5 15.  17.5 20.]
```
示例
```python
import numpy as np
arr = np.linspace(10, 20, 5, endpoint=False)
print("The array over the given range is ", arr)
```
输出：
```python
The array over the given range is  [10. 12. 14. 16. 18.]
```

### numpy.logspace
它通过在对数刻度上均匀分隔的数字来创建数组。

语法如下。
```python
numpy.logspace(start, stop, num, endpoint, base, dtype)
```
它接受以下参数。

- start：区间的起始值（在指定的基数中）。

- stop：区间的结束值（在指定的基数中）。

- num：范围之间的值的数量。

- endpoint：它是一个布尔类型的值。使表示的停止值成为区间的最后一个值。

- base：对数空间的基数。

- dtype：数组项的数据类型。

示例
```python
import numpy as np
arr = np.logspace(10, 20, num=5, endpoint=True)
print("The array over the given range is ", arr)
```
输出：
```python
The array over the given range is  [1.00000000e+10 3.16227766e+12 1.00000000e+15 3.16227766e+17
 1.00000000e+20]
```
示例
```python
import numpy as np
arr = np.logspace(10, 20, num=5, base=2, endpoint=True)
print("The array over the given range is ", arr)
```
输出：
```python
The array over the given range is  [1.02400000e+03 5.79261875e+03 3.27680000e+04 1.85363800e+05
 1.04857600e+06]
```
