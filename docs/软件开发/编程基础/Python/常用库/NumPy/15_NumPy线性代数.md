## NumPy线性代数

NumPy提供了以下函数来对输入数据执行不同的代数计算。

| 序号 | 函数     | 定义                         |
| ---- | -------- | ---------------------------- |
| 1    | dot()    | 用于计算两个数组的点积。     |
| 2    | vdot()   | 用于计算两个向量的点积。     |
| 3    | inner()  | 用于计算两个数组的内积。     |
| 4    | matmul() | 用于计算两个数组的矩阵乘法。 |
| 5    | det()    | 用于计算矩阵的行列式。       |
| 6    | solve()  | 用于解线性矩阵方程。         |
| 7    | inv()    | 用于计算矩阵的乘法逆。       |

### numpy.dot() 函数
此函数用于返回两个矩阵的点积。它类似于矩阵乘法。考虑以下示例。

示例
```python
import numpy as np  

a = np.array([[100, 200], [23,12]])
b = np.array([[10, 20], [12, 21]])  

dot = np.dot(a, b)
print(dot)
```
输出：
```python
[[3400 6200]
 [ 374  712]]


The dot product is calculated as:

[100 * 10 + 200 * 12, 100 * 20 + 200 * 21] [23*10+12*12, 23*20 + 12*21]
```

### numpy.vdot() 函数
此函数用于计算两个向量的点积。可以定义为多维数组的相应元素的乘积的总和。

考虑以下示例。

示例
```python
import numpy as np  

a = np.array([[100,200],[23,12]])  
b = np.array([[10,20],[12,21]])  
vdot = np.vdot(a,b)  
print(vdot)
```
输出：
```python
5528


np.vdot(a,b) = 100 *10 + 200 * 20 + 23 * 12 + 12 * 21 = 5528
```

### numpy.inner() 函数
此函数返回一维数组的内积的乘积之和。对于n维数组，它返回沿最后一个轴的元素的乘积之和。

考虑以下示例。

示例
```python
import numpy as np  

a = np.array([1,2,3,4,5,6])  
b = np.array([23,23,12,2,1,2])  
inner = np.inner(a,b)  
print(inner)  
```
输出：
```python
130
```

### numpy.matmul() 函数
此函数用于返回两个矩阵的乘积。如果两个矩阵的形状不对应于乘法，它会报错。考虑以下示例。

示例
```python
import numpy as np  

a = np.array([[1,2,3],[4,5,6],[7,8,9]])  
b = np.array([[23,23,12],[2,1,2],[7,8,9]])  
mul = np.matmul(a,b)  
print(mul)
```
输出：
```python
[[ 48  47  45]
 [129 128 123]
 [210 209 201]]
```

### numpy 行列式
矩阵的行列式可以使用对角元素来计算。以下2 X 2矩阵的行列式

A B

C D

可以计算为AD - BC。

可以使用`numpy.linalg.det()`函数来计算矩阵的行列式。考虑以下示例。

示例
```python
import numpy as np  

a = np.array([[1,2],[3,4]])  
print(np.linalg.det(a)) 
```
输出：
```python
-2.0000000000000004
```

### numpy.linalg.solve() 函数
此函数用于解二次方程，其中值可以以矩阵的形式给出。

以下线性方程组
```
3X + 2 Y + Z = 10

X + Y + Z = 5
```
可以使用三个矩阵来表示：
```
3   2   1  
1   1   1  
X  
Y  
Z  and  
10  
5. 
```
可以将两个矩阵传递给numpy.solve()函数，如下所示。
示例
```python
import numpy as np  

a = np.array([[1,2],[3,4]])  
b = np.array([[1,2],[3,4]])  
print(np.linalg.solve(a, b)) 
``` 
输出：
```python
[[1. 0.]
 [0. 1.]]
```

### numpy.linalg.inv() 函数
此函数用于计算输入矩阵的乘法逆。考虑以下示例。

示例
```python
import numpy as np  

a = np.array([[1,2],[3,4]])  
print("Original array:\n",a)  
b = np.linalg.inv(a)  
print("Inverse:\n",b) 
```
输出：
```python
Original array:
 [[1 2]
 [3 4]]
Inverse:
 [[-2.   1. ]

 [ 1.5 -0.5]]
```