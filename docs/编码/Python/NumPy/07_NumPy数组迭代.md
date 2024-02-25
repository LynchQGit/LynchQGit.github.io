## NumPy 数组迭代

NumPy 提供了一个迭代器对象，即 `nditer`，可以使用 Python 标准的迭代器接口来迭代给定的数组。
考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [2, 4, 5, 6], [10, 20, 39, 3]])
print("Printing array:")
print(a)
print("Iterating over the array:")

for x in np.nditer(a):
    print(x, end=' ')
```
输出：
```python
Printing array:
[[ 1  2  3  4]
 [ 2  4  5  6]
 [10 20 39  3]]
Iterating over the array:
1 2 3 4 2 4 5 6 10 20 39 3
```
迭代的顺序不遵循特殊的排序，如行优先或列优先。但是，它的意图是匹配数组的内存布局。

让我们迭代上面示例中数组的转置。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [2, 4, 5, 6], [10, 20, 39, 3]])
print("Printing the array:")
print(a)
print("Printing the transpose of the array:")

at = a.T
print(at)
print("\nIterating over the transposed array:")

for x in np.nditer(at):
    print(x, end=' ')
```
输出：
```python
Printing the array:
[[ 1  2  3  4]
 [ 2  4  5  6]
 [10 20 39  3]]
Printing the transpose of the array:
[[ 1  2 10]
 [ 2  4 20]
 [ 3  5 39]
 [ 4  6  3]]
Iterating over the transposed array:
1 2 3 4 2 4 5 6 10 20 39 3
```

### 迭代顺序
正如我们所知，有两种方式将值存储到 numpy 数组中：

- F 风格顺序

- C 风格顺序

让我们看一个示例，演示 numpy 迭代器如何处理特定的顺序（F 或 C）。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [2, 4, 5, 6], [10, 20, 39, 3]])

print("\nPrinting the array:\n")
print(a)

print("\nPrinting the transpose of the array:\n")
at = a.T
print(at)

print("\nIterating over the transposed array\n")
for x in np.nditer(at):
    print(x, end=' ')

print("\nSorting the transposed array in C-style:\n")

print("\nIterating over the C-style array:\n")
for x in np.nditer(at, order='C'):
    print(x, end=' ')

d = at.copy(order='F')

print(d)
print("Iterating over the F-style array:\n")
for x in np.nditer(d):
    print(x, end=' ')
```

输出：
```python
Iterating over the transposed array

1 2 3 4 2 4 5 6 10 20 39 3
Sorting the transposed array in C-style:

Iterating over the C-style array:

1 2 10 2 4 20 3 5 39 4 6 3
Iterating over the F-style array:

1 2 3 4 2 4 5 6 10 20 39 3
我们可以在定义迭代器对象本身时指定顺序 'C' 或 'F'。考虑以下示例。
```

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [2, 4, 5, 6], [10, 20, 39, 3]])

print("\nPrinting the array:\n")
print(a)

print("\nPrinting the transpose of the array:\n")
at = a.T
print(at)

print("\nIterating over the transposed array\n")
for x in np.nditer(at):
    print(x, end=' ')

print("\nSorting the transposed array in C-style:\n")

print("\nIterating over the C-style array:\n")
for x in np.nditer(at, order='C'):
    print(x, end=' ')
```
输出：
```python
Iterating over the transposed array

1 2 3 4 2 4 5 6 10 20 39 3
Sorting the transposed array in C-style:


Iterating over the C-style array:

1 2 10 2 4 20 3 5 39 4 6 3
```

### 数组值的修改
在迭代过程中，我们不能修改数组元素，因为与迭代器对象关联的 `op-flag` 设置为 `readonly`。

然而，我们可以将此标志设置为 `readwrite` 或 `writeonly`，以修改数组值。考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [2, 4, 5, 6], [10, 20, 39, 3]])

print("\nPrinting the original array:\n")
print(a)

print("\nIterating over the modified array\n")
for x in np.nditer(a, op_flags=['readwrite']):
    x[...] = 3 * x
    print(x, end=' ')
```
输出：
```python
Printing the original array:

[[ 1  2  3  4]
 [ 2  4  5  6]
 [10 20 39  3]]

Iterating over the modified array

3 6 9 12 6 12 15 18 30 60 117 9
```
