## NumPy数学函数

NumPy包含大量的数学函数，可用于执行各种数学运算。这些数学函数包括三角函数、算术函数以及处理复数的函数。让我们讨论一下这些数学函数。

### 三角函数
NumPy包含三角函数，用于计算不同角度的正弦、余弦和正切值（弧度制）。

sin、cos和tan函数返回指定角度的三角比值。考虑以下示例。

示例
```python
import numpy as np

arr = np.array([0, 30, 60, 90, 120, 150, 180])
print("\nThe sin value of the angles",end = " ")
print(np.sin(arr * np.pi / 180))
print("\nThe cosine value of the angles",end = " ")
print(np.cos(arr * np.pi / 180))
print("\nThe tangent value of the angles",end = " ")
print(np.tan(arr * np.pi / 180))
```
输出：
```python
The sin value of the angles
[0.00000000e+00 5.00000000e-01 8.66025404e-01 1.00000000e+00
 8.66025404e-01 5.00000000e-01 1.22464680e-16]

The cosine value of the angles
[ 1.00000000e+00  8.66025404e-01  5.00000000e-01  6.12323400e-17
 -5.00000000e-01 -8.66025404e-01 -1.00000000e+00]

The tangent value of the angles [ 0.00000000e+00  5.77350269e-01  1.73205081e+00  1.63312394e+16
 -1.73205081e+00 -5.77350269e-01 -1.22464680e-16]
```
在上面的示例中，我们可以看到sin()、cos()和tan()函数返回指定角度的三角函数值。
另一方面，arcsin()、arccos()和arctan()函数返回指定角度的三角函数反函数值。

numpy.degrees()函数可用于验证这些三角函数的结果。考虑以下示例。

示例
```python
import numpy as np

arr = np.array([0, 30, 60, 90])
print("printing the sin values of different angles")

sinval = np.sin(arr * np.pi / 180)

print(sinval)
print("printing the inverse of the sin")
cosec = np.arcsin(sinval)

print(cosec)

print("printing the values in degrees")
print(np.degrees(cosec))

print("\nprinting the cos values of different angles")
cosval = np.cos(arr * np.pi / 180)

print(cosval)
print("printing the inverse of the cos")
sec = np.arccos(cosval)
print(sec)

print("\nprinting the values in degrees")
print(np.degrees(sec))

print("\nprinting the tan values of different angles")
tanval = np.tan(arr * np.pi / 180)

print(tanval)
print("printing the inverse of the tan")
cot = np.arctan(tanval)
print(cot)

print("\nprinting the values in degrees")
print(np.degrees(cot))
```
输出：
```python
printing the sin values of different angles
[0.        0.5       0.8660254 1.       ]
printing the inverse of the sin
[0.         0.52359878 1.04719755 1.57079633]
printing the values in degrees
[ 0. 30. 60. 90.]

printing the cos values of different angles
[1.00000000e+00 8.66025404e-01 5.00000000e-01 6.12323400e-17]
printing the inverse of the cos
[0.         0.52359878 1.04719755 1.57079633]

printing the values in degrees
[ 0. 30. 60. 90.]

printing the tan values of different angles
[0.00000000e+00 5.77350269e-01 1.73205081e+00 1.63312394e+16]
printing the inverse of the tan
[0.         0.52359878 1.04719755 1.57079633]

printing the values in degrees
[ 0. 30. 60. 90.]
```

### 四舍五入函数
NumPy提供了各种函数，用于将十进制浮点数的值截断为特定精度的十进制数。让我们讨论一下这些四舍五入函数。

`numpy.around()`函数
此函数返回四舍五入到指定小数位数的十进制值。函数的语法如下。

> numpy.around(num, decimals)

它接受以下参数。

| 序号 | 参数     | 描述                                                                  |
| ---- | -------- | --------------------------------------------------------------------- |
| 1    | num      | 输入的数字。                                                          |
| 2    | decimals | 要四舍五入到的小数位数。默认值为0。如果此值为负，则小数点将向左移动。 |

考虑以下示例。

示例
```python
import numpy as np

arr = np.array([12.202, 90.23120, 123.020, 23.202])
print("printing the original array values:",end = " ")
print(arr)
print("Array values rounded off to 2 decimal position",np.around(arr, 2))
print("Array values rounded off to -1 decimal position",np.around(arr, -1))
```
输出：
```python
printing the original array values: [ 12.202   90.2312 123.02    23.202 ]
Array values rounded off to 2 decimal position [ 12.2   90.23 123.02  23.2 ]
Array values rounded off to -2 decimal position [ 10.  90. 120.  20.]
```

numpy.floor()函数
此函数用于返回输入数据的下限值，即不大于输入值的最大整数。考虑以下示例。

示例
```python
import numpy as np

arr = np.array([12.202, 90.23120, 123.020, 23.202])
print(np.floor(arr))
```
输出：
```python
[ 12.  90. 123.  23.]
```

numpy.ceil()函数
此函数用于返回数组元素的上限值，即大于数组元素的最小整数值。考虑以下示例。

示例
```python
import numpy as np

arr = np.array([12.202, 90.23120, 123.020, 23.202])
print(np.ceil(arr))
```

输出：
```python
[ 13.  91. 124.  24.]
```
