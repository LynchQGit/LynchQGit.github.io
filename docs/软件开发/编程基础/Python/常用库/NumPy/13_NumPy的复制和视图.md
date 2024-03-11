## NumPy的复制和视图

输入数组的副本在某个其他位置物理存储，并返回存储在该特定位置的内容，这是输入数组的副本，而在视图的情况下，返回同一内存位置的不同视图。
在本教程的本节中，我们将考虑从某个内存位置生成不同副本和视图的方法。

### 数组赋值
将`numpy`数组赋值给另一个数组不会直接复制原始数组，而是创建另一个具有相同内容和相同id的数组。它表示对原始数组的引用。对这个引用所做的更改也会反映在原始数组中。

`id()`函数返回数组的通用标识符，类似于C中的指针。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [9, 0, 2, 3], [1, 2, 3, 19]])

print("Original Array:\n", a)
print("\nID of array a:", id(a))

b = a

print("\nmaking copy of the array a")
print("\nID of b:", id(b))

b.shape = 4,3;

print("\nChanges on b also reflect to a:")
print(a)
```
输出：
```python
Original Array:
 [[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

ID of array a: 139663602288640
making copy of the array a
ID of b: 139663602288640
Changes on b also reflect to a:
[[ 1  2  3]
 [ 4  9  0]
 [ 2  3  1]
 [ 2  3 19]]
```

### ndarray.view()方法
`ndarray.view()`方法返回一个包含与原始数组相同内容的新数组对象。由于它是一个新的数组对象，因此对此对象进行的更改不会反映在原始数组中。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [9, 0, 2, 3], [1, 2, 3, 19]])

print("Original Array:\n", a)

print("\nID of array a:", id(a))

b = a.view()

print("\nID of b:", id(b))

print("\nprinting the view b")
print(b)

b.shape = 4,3;

print("\nChanges made to the view b do not reflect a")
print("\nOriginal array \n", a)
print("\nview\n", b)
```
输出：
```python
Original Array:
 [[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

ID of array a: 140280414447456

ID of b: 140280287000656

printing the view b
[[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

Changes made to the view b do not reflect a

Original array
 [[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

view
 [[ 1  2  3]
 [ 4  9  0]
 [ 2  3  1]
 [ 2  3 19]]
```

### ndarray.copy()方法
它返回原始数组的深度副本，与原始数组不共享任何内存。对深度副本进行的修改不会反映在原始数组中。

考虑以下示例。

示例
```python
import numpy as np

a = np.array([[1, 2, 3, 4], [9, 0, 2, 3], [1, 2, 3, 19]])

print("Original Array:\n", a)

print("\nID of array a:", id(a))

b = a.copy()

print("\nID of b:", id(b))

print("\nprinting the deep copy b")
print(b)

b.shape = 4,3;

print("\nChanges made to the copy b do not reflect a")
print("\nOriginal array \n", a)
print("\nCopy\n",b)
```
输出：
```python
Original Array:
 [[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

ID of array a: 139895697586176

ID of b: 139895570139296

printing the deep copy b
[[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

Changes made to the copy b do not reflect a

Original array
 [[ 1  2  3  4]
 [ 9  0  2  3]
 [ 1  2  3 19]]

Copy
 [[ 1  2  3]
 [ 4  9  0]
 [ 2  3  1]
 [ 2  3 19]
```
