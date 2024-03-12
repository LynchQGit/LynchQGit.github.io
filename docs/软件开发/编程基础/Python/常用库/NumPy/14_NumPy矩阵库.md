## NumPy矩阵库

NumPy包含一个矩阵库，即numpy.matlib，用于创建矩阵而不是ndarray对象。
### numpy.matlib.empty() 函数
此函数用于返回带有未初始化条目的新矩阵。使用此函数的语法如下：
> numpy.matlib.empty(shape, dtype, order)

它接受以下参数：

- shape：定义矩阵的形状的元组。

- dtype：矩阵的数据类型。

- order：矩阵的插入顺序，即C或F。

考虑以下示例。

示例
```python
import numpy as np  
import numpy.matlib  
  
print(numpy.matlib.empty((3, 3)))
```
输出：
```python
[[6.90262230e-310 6.90262230e-310 6.90262304e-310]
 [6.90262304e-310 6.90261674e-310 6.90261552e-310]
 [6.90261326e-310 6.90262311e-310 3.95252517e-322]]
```

### numpy.matlib.zeros() 函数
此函数用于创建初始化为零的矩阵。

考虑以下示例。

示例
```python
import numpy as np    
import numpy.matlib  
  
print(numpy.matlib.zeros((4, 3)))
```
输出：
```python
[[0. 0. 0.]
 [0. 0. 0.]
 [0. 0. 0.]
 [0. 0. 0.]]
```

### numpy.matlib.ones() 函数
此函数返回所有元素都初始化为1的矩阵。

考虑以下示例。

示例
```python
import numpy as np    
import numpy.matlib  
  
print(numpy.matlib.ones((2, 2)))
```
输出：
```python
[[1. 1.]
 [1. 1.]]
```

### numpy.matlib.eye() 函数
此函数返回对角线元素初始化为1，其他元素初始化为零的矩阵。使用此函数的语法如下：

> numpy.matlib.eye(n, m, k, dtype)

它接受以下参数。

- n：所得矩阵的行数。

- m：所得矩阵的列数，默认为n。

- k：对角线的索引。

- dtype：输出的数据类型。

考虑以下示例。

示例
```python
import numpy as np    
import numpy.matlib  
  
print(numpy.matlib.eye(n = 3, M = 3, k = 0, dtype = int))
```
输出：
```python
[[1 0 0]
 [0 1 0]
 [0 0 1]]
```

### numpy.matlib.identity() 函数
此函数用于返回给定大小的单位矩阵。单位矩阵是对角线元素初始化为1，所有其他元素初始化为零的矩阵。

考虑以下示例。

示例
```python
import numpy as np    
import numpy.matlib  
  
print(numpy.matlib.identity(5, dtype = int))  
```
输出：
```python
[[1 0 0 0 0]
 [0 1 0 0 0]
 [0 0 1 0 0]
 [0 0 0 1 0]
 [0 0 0 0 1]]
```

### numpy.matlib.rand() 函数
此函数用于生成所有条目都初始化为随机值的矩阵。

考虑以下示例。

示例
```python
import numpy as np    
import numpy.matlib  
  
print(numpy.matlib.rand(3, 3))
```
输出：
```python
[[0.86201511 0.86980769 0.06704884]
 [0.80531086 0.53814098 0.84394673]
 [0.85653048 0.8146121  0.35744405]]
```
