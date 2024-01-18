NumPy 提供了一种通过使用现有数据来创建数组的方式。
### numpy.asarray
这个例程用于通过使用列表或元组等形式的现有数据来创建数组。在需要将 Python 序列转换为 NumPy 数组对象的场景中非常有用。
使用 asarray() 例程的语法如下。
```python
numpy.asarray(sequence, dtype=None, order=None)
```

它接受以下参数:
- sequence：要转换为数组的 Python 序列。
- dtype：数组的每个项的数据类型。
- order：可以设置为 C 或 F。默认为 C。

示例：使用列表创建 Numpy 数组
```python
import numpy as np
l = [1, 2, 3, 4, 5, 6, 7]
a = np.asarray(l)
print(type(a))
print(a)
```
输出：
```python
<class 'numpy.ndarray'>
[1 2 3 4 5 6 7]
```

示例：使用元组创建 Numpy 数组
```python
import numpy as np
l = (1, 2, 3, 4, 5, 6, 7)
a = np.asarray(l)
print(type(a))
print(a)
```
输出：
```python
<class 'numpy.ndarray'>
[1 2 3 4 5 6 7]
```
示例：使用多个列表创建 Numpy 数组
```python
import numpy as np
l = [[1, 2, 3, 4, 5, 6, 7], [8, 9]]
a = np.asarray(l)
print(type(a))
print(a)
```
输出：
```python
<class 'numpy.ndarray'>
[list([1, 2, 3, 4, 5, 6, 7]) list([8, 9])]
```

### numpy.frombuffer
这个函数用于通过指定的缓冲区创建数组。使用该缓冲区的语法如下。
```python
numpy.frombuffer(buffer, dtype=float, count=-1, offset=0)
```

它接受以下参数:
- buffer：表示暴露缓冲区接口的对象.
- dtype：返回的数据类型数组的数据类型。默认为 float。可以使用任何标准数据类型。
- count：返回的 ndarray 的长度。默认值为 -1。
- offset：从中读取的起始位置。默认值为 0。

示例
```python
import numpy as np
l = b'hello world'
print(type(l))
a = np.frombuffer(l, dtype="S1")  # S1 表示一个字节
print(a)
print(type(a))
```
输出：
```python
<class 'bytes'>
[b'h' b'e' b'l' b'l' b'o' b' ' b'w' b'o' b'r' b'l' b'd']
<class 'numpy.ndarray'>
```

### numpy.fromiter
这个例程用于通过使用可迭代对象创建一个 ndarray。它返回一个一维的 ndarray 对象。
语法如下。
```python
numpy.fromiter(iterable, dtype, count=-1)
```

它接受以下参数。
- Iterable：表示可迭代对象。
- dtype：结果数组项的数据类型。
- count：从数组中缓冲区中读取的项数。

示例
```python
import numpy as np
lst = [0, 2, 4, 6]
it = iter(lst)
x = np.fromiter(it, dtype=float)
print(x)
print(type(x))
```
输出：
```python
[0. 2. 4. 6.]
<class 'numpy.ndarray'>
```
