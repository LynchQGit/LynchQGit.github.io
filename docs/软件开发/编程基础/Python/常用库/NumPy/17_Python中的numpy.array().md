## Python中的numpy.array()

NumPy中的同质多维数组是主要对象。它基本上是一个由元素组成的表，所有元素的类型都相同，并由一组正整数的元组索引。在NumPy中，这些维度被称为轴。
NumPy的数组类称为ndarray或别名数组。numpy.array与标准Python库的array.array类不同。array.array仅处理一维数组并提供较少的功能。
语法
> numpy.array(object, dtype=None, copy=True, order='K', subok=False, ndmin=0)

#### 参数
在numpy.array()函数中有以下参数。

1) object: array_like
任何对象，它暴露出一个数组接口，其array方法返回任何嵌套序列或数组。

2) dtype : 可选的数据类型
此参数用于定义数组元素的所需参数。如果不定义数据类型，则它将确定类型，以便将对象保留在序列中所需的最小类型。此参数仅用于向上转换数组。

3) copy: 布尔型（可选）
如果我们将copy设置为true，则会复制对象，否则当对象是嵌套序列时，或者需要满足任何其他要求（如dtype、order等）时，将进行复制。

4) order : {'K', 'A', 'C', 'F'}，可选
order参数指定数组的内存布局。当对象不是数组时，新创建的数组将在C顺序（行头或行主要）中，除非指定了'F'。当指定了F时，它将在Fortran顺序（列头或列主要）中。当对象是数组时，它保持以下顺序。
order	no copy	copy=True
'K'	保持不变	保留F和C顺序。
'A'	保持不变	当输入是F且不是C时，F顺序，否则C顺序
'C'	C顺序	C顺序
'F'	F顺序	F顺序
当copy=False或为其他原因进行复制时，结果将与copy=True相同，A的某些异常情况除外。默认顺序为'K'。

5) subok : 布尔型（可选）
当subok=True时，子类将被传递，否则返回的数组将强制成基类数组（默认）。

6) ndmin : 整数（可选）
此参数指定所需的结果数组应具有的最小维数。可以根据需要在形状前面添加用户。

#### 返回值
numpy.array()方法返回一个ndarray。ndarray是一个满足指定要求的数组对象。
示例1：numpy.array()
```python
import numpy as np  

arr = np.array([1, 2, 3])  
arr
```
输出：
```python
array([1, 2, 3])
```

在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们只传递了元素，没有传递轴。

最后，我们尝试打印arr的值。

输出中显示了一个数组。
示例2：
```python
import numpy as np  

arr = np.array([1, 2., 3.])  
arr
```
输出：
```python
array([1., 2., 3.])
```

在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们传递了不同类型的元素，例如整数、浮点数等。

最后，我们尝试打印arr的值。

输出中显示了一个数组，其中的元素类型为能够容纳序列中的对象所需的最小类型。

示例3：多于一个维度
```python
import numpy as np  

arr = np.array([[1, 2., 3.], [4., 5., 7]])  
arr
```
输出：
```python
array([[1., 2., 3.],
        [4., 5., 7.]])
```
在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们通过不同的方括号传递了元素的数量。

最后，我们尝试打印arr的值。

输出中显示了一个多维数组。
示例4：最小维度：2
```python
import numpy as np  

arr = np.array([1, 2., 3.], ndmin=2)  
arr
```
输出：
```python
array([[1., 2., 3.]])
```
在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们通过方括号传递了元素的数量和创建ndarray的维度。

最后，我们尝试打印arr的值。

输出中显示了一个二维数组。

示例5：提供类型
```python
import numpy as np  

arr = np.array([12, 45., 3.], dtype=complex)
arr
```
输出：
```python
array([12.+0.j, 45.+0.j,  3.+0.j])
```
在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们通过方括号传递了元素，并将dtype设置为complex。

最后，我们尝试打印arr的值。

输出中的`arr`元素的值以复数形式显示。

示例6：从子类创建数组
```python
import numpy as np  

arr = np.array(np.mat('1 2;3 4'))  
arr
arr = np.array(np.mat('1 2;3 4'), subok=True)  
arr
```
输出：
```python
array([[1, 2],
       [3, 4]])
matrix([[1, 2],
        [3, 4]])
```
在上面的代码中
我们导入了别名为np的numpy库。

我们声明了变量`arr`并将值分配为np.array()函数返回的值。

在array()函数中，我们通过np.mat()函数以矩阵形式传递了元素，并设置subok=True。

最后，我们尝试打印arr的值。

输出中显示了一个多维数组。