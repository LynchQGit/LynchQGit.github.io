## Numpy 数组创建
Numpy 数组创建可以使用以下例程构造 ndarray 对象。

### Numpy.empty

顾名思义，`empty` 例程用于创建一个未初始化的指定形状和数据类型的数组。

语法如下。
```python
numpy.empty(shape, dtype=float, order='C')
```
它接受以下参数:
- Shape：所需数组的形状。
- dtype：数组项的数据类型。默认为浮点数。
- Order：默认顺序是 C 风格的行主序。可以设置为 F 以使用 FORTRAN 风格的列主序。

示例
```python
import numpy as np
arr = np.empty((3, 2), dtype=int)
print(arr)
```
输出：
```python
[[ 140482883954664   36917984]
 [ 140482883954648  140482883954648]
 [6497921830368665435 172026472699604272]]
```

### NumPy.zeros
此例程用于创建具有指定形状的 numpy 数组，其中每个 numpy 数组项都初始化为 0。

语法如下。
```python
numpy.zeros(shape, dtype=float, order='C')
```
它接受以下参数。
- Shape：所需数组的形状。
- dtype：数组项的数据类型。默认为浮点数。
- Order：默认顺序是 C 风格的行主序。可以设置为 F 以使用 FORTRAN 风格的列主序。

示例
```python
import numpy as np
arr = np.zeros((3, 2), dtype=int)
print(arr)
```
输出：
```python
[[0 0]
 [0 0]
 [0 0]]
```

### NumPy.ones
此例程用于创建具有指定形状的 numpy 数组，其中每个 numpy 数组项都初始化为 1。

使用此模块的语法如下。
```python
numpy.ones(shape, dtype=None, order='C')
```
它接受以下参数。
- Shape：所需数组的形状。
- dtype：数组项的数据类型。
- Order：默认顺序是 C 风格的行主序。可以设置为 F 以使用 FORTRAN 风格的列主序。

示例
```python
import numpy as np
arr = np.ones((3, 2), dtype=int)
print(arr)
```
输出：
```python
[[1 1]
 [1 1]
 [1 1]]
```
