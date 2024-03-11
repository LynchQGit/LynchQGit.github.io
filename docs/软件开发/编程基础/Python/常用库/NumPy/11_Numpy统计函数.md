## Numpy统计函数

Numpy提供了各种用于执行一些统计数据分析的统计函数。在本教程的这个部分，我们将讨论numpy提供的统计函数。
查找数组中的最小值和最大值
numpy.amin()和numpy.amax()函数分别用于找到数组元素沿指定轴的最小值和最大值。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[2, 10, 20], [80, 43, 31], [22, 43, 10]])

print("The original array:\n")
print(a)


print("\nThe minimum element among the array:", np.amin(a))
print("The maximum element among the array:", np.amax(a))

print("\nThe minimum element among the rows of array", np.amin(a, 0))
print("The maximum element among the rows of array", np.amax(a, 0))

print("\nThe minimum element among the columns of array", np.amin(a, 1))
print("The maximum element among the columns of array", np.amax(a, 1))
```
输出：
```python
The original array:

[[ 2 10 20]
 [80 43 31]
 [22 43 10]]

The minimum element among the array: 2
The maximum element among the array: 80

The minimum element among the rows of array [ 2 10 10]
The maximum element among the rows of array [80 43 31]

The minimum element among the columns of array [ 2 31 10]
The maximum element among the columns of array [20 80 43]
```

### numpy.ptp()函数
函数numpy.ptp()的名称源于峰对峰值（peak-to-peak）。它用于返回沿轴的值范围。考虑以下示例。

示例
```python
import numpy as np

a = np.array([[2, 10, 20], [80, 43, 31], [22, 43, 10]])

print("Original array:\n", a)

print("\nptp value along axis 1:", np.ptp(a, 1))

print("ptp value along axis 0:", np.ptp(a, 0))
```
输出：
```python
Original array:
 [[ 2 10 20]
 [80 43 31]
 [22 43 10]]

ptp value along axis 1: [18 49 33]
ptp value along axis 0: [78 33 21]
```

### numpy.percentile()函数
使用函数的语法如下：

> numpy.percentile(input, q, axis)

它接受以下参数：

- input：输入的数组。

- q：要计算数组元素的百分位数（1-100）。

- axis：要计算百分位数的轴。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[2, 10, 20], [80, 43, 31], [22, 43, 10]])

print("Array:\n", a)

print("\nPercentile along axis 0", np.percentile(a, 10, 0))

print("Percentile along axis 1", np.percentile(a, 10, 1))
```
输出：
```python
Array:
 [[ 2 10 20]
 [80 43 31]
 [22 43 10]]

Percentile along axis 0 [ 6.  16.6 12. ]
Percentile along axis 1 [ 3.6 33.4 12.4]
```

### 计算数组项的中位数、均值和平均值
`numpy.median()`函数：
中位数定义为用于将数据样本的较高范围与较低范围分开的值。函数numpy.median()用于计算多维或一维数组的中位数。

`numpy.mean()`函数：
均值可以通过将数组的所有项相加，然后除以数组元素的数量来计算。我们还可以指定计算均值的轴。

`numpy.average()`函数：
numpy.average()函数用于在多维数组的轴上找到加权平均值，其中权重在另一个数组中给出。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

print("Array:\n", a)

print("\nMedian of array along axis 0:", np.median(a, 0))
print("Mean of array along axis 0:", np.mean(a, 0))
print("Average of array along axis 1:", np.average(a, 1))
```
