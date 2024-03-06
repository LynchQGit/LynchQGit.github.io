## NumPy排序和搜索

Numpy提供了各种用于排序和搜索的函数。有各种排序算法，如快速排序、归并排序和堆排序，可以使用numpy.sort()函数来实现。
在函数调用中必须指定要在排序操作中使用的排序算法的类型。

### numpy.sort() 函数
让我们讨论在numpy.sort()中实现的排序算法。

| 序号 | 算法     | 最坏情况复杂性 |
| ---- | -------- | -------------- |
| 1    | 快速排序 | O(n^2)         |
| 2    | 归并排序 | O(n * log(n))  |
| 3    | 堆排序   | O(n * log(n))  |

使用numpy.sort()函数的语法如下：
> numpy.sort(a, axis, kind, order)

它接受以下参数。
| 序号 | 参数  | 描述                                                                   |
| ---- | ----- | ---------------------------------------------------------------------- |
| 1    | input | 表示要排序的输入数组。                                                 |
| 2    | axis  | 表示要沿其排序数组的轴。如果未提及轴，则会在最后一个可用轴上进行排序。 |
| 3    | kind  | 表示在排序时要使用的排序算法的类型。默认为快速排序。                   |
| 4    | order | 如果数组包含字段，则表示按哪个字段对数组进行排序。                     |
考虑以下示例。
示例
```python
import numpy as np

a = np.array([[10, 2, 3], [4, 5, 6], [7, 8, 9]])

print("Sorting along the columns:")
print(np.sort(a))

print("Sorting along the rows:")
print(np.sort(a, 0))

data_type = np.dtype([('name', 'S10'),('marks', int)])

arr = np.array([('Mukesh',200),('John',251)],dtype = data_type)

print("Sorting data ordered by name")

print(np.sort(arr,order = 'name'))
```
输出：
```python
Sorting along the columns:
[[ 2  3 10]
 [ 4  5  6]
 [ 7  8  9]]
Sorting along the rows:
[[ 4  2  3]
 [ 7  5  6]
 [10  8  9]]
Sorting data ordered by name
[(b'John', 251) (b'Mukesh', 200)]
```

### numpy.argsort()函数
此函数用于对输入数组执行间接排序，即返回数据的索引数组，该索引数组用于构建排序后的数据数组。

考虑以下示例。
示例
```python
import numpy as np

a = np.array([90, 29, 89, 12])

print("Original array:\n", a)

sort_ind = np.argsort(a)

print("Printing indices of sorted data\n", sort_ind)

sort_a = a[sort_ind]

print("printing sorted array")

for i in sort_ind:
    print(a[i],end = " ")
```
输出：
```python
Original array:
 [90 29 89 12]
Printing indices of sorted data
 [3 1 2 0]
printing sorted array
12 29 89 90
```

### numpy.lexsort()函数
此函数用于使用键的序列间接排序数组。此函数的执行方式类似于numpy.argsort()，后者返回已排序数据的索引数组。

考虑以下示例。
示例
```python
import numpy as np

a = np.array(['a', 'b', 'c', 'd', 'e'])

b = np.array([12, 90, 380, 12, 211])

ind = np.lexsort((a, b))

print("printing indices of sorted data")

print(ind)

print("using the indices to sort the array")

for i in ind:
    print(a[i], b[i])
```
输出：
```python
printing indices of sorted data
[0 3 1 4 2]
using the indices to sort the array
a 12
d 12
b 90
e 211
c 380
```

### numpy.nonzero()函数
此函数用于找到数组中非零元素的位置。

考虑以下示例。
示例
```python
import numpy as np

b = np.array([12, 90, 380, 12, 211])

print("printing original array", b)

print("printing location of the non-zero elements")

print(b.nonzero())
```
输出：
```python
printing original array [ 12  90 380  12 211]
printing location of the non-zero elements
(array([0, 1, 2, 3, 4]),)
```

### numpy.where()函数
此函数用于返回满足特定条件的所有元素的索引。

考虑以下示例。
示例
```python
import numpy as np

b = np.array([12, 90, 380, 12, 211])

print(np.where(b > 12))

c = np.array([[20, 24], [21, 23]])

print(np.where(c > 20))
```
输出：
```python
(array([1, 2, 4]),)

(array([0, 1, 1]), array([1, 0, 1]))
```
