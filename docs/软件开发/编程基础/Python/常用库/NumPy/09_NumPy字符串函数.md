## NumPy字符串函数

NumPy包含以下用于操作字符串数据类型数组的函数。

| 序号  | 函数         | 描述                                                                                |
| :---: | :----------- | :---------------------------------------------------------------------------------- |
|   1   | add()        | 用于连接相应的数组元素（字符串）。                                                  |
|   2   | multiply()   | 返回指定字符串的多个副本，例如，如果字符串'hello'乘以3，则返回字符串'hello hello'。 |
|   3   | center()     | 返回字符串的副本，其中原始字符串在左右填充填充字符的指定数量后居中。                |
|   4   | capitalize() | 返回原始字符串的副本，其中原始字符串的第一个字母转换为大写。                        |
|   5   | title()      | 返回字符串的标题化版本，即字符串中的每个单词的第一个字母转换为大写。                |
|   6   | lower()      | 返回字符串的副本，其中所有字母转换为小写。                                          |
|   7   | upper()      | 返回字符串的副本，其中所有字母转换为大写。                                          |
|   8   | split()      | 返回字符串中的单词列表。                                                            |
|   9   | splitlines() | 返回字符串中的行列表，按行边界分隔。                                                |
|  10   | strip()      | 返回删除了前导和尾随空格的字符串的副本。                                            |
|  11   | join()       | 返回一个字符串，它是给定序列中所有字符串连接而成的。                                |
|  12   | replace()    | 返回一个副本，其中所有出现的特定子字符串都被指定的子字符串替换。                    |
|  13   | decode()     | 用于逐元素地使用指定的编解码器对指定字符串进行解码。                                |
|  14   | encode()     | 用于逐元素地对解码后的字符串进行编码。                                              |

### numpy.char.add() 方法示例
```python
import numpy as np

print("Concatenating two string arrays:")
print(np.char.add(['welcome','Hi'], [' to Python', ' Lynch'] ))
```
输出:
```python
Concatenating two string arrays:
['welcome to Python' 'Hi python']
```

### numpy.char.multiply() 方法示例
```python
import numpy as np

print("Printing a string multiple times:")
print(np.char.multiply("hello ", 3))
```
输出:
```python
Printing a string multiple times:
hello hello hello
```

### numpy.char.center() 方法示例
```python
import numpy as np

print("Padding the string through left and right with the fill char *")
#np.char.center(string, width, fillchar)
print(np.char.center("Python", 20, '*'))
```
输出:
```python
Padding the string through left and right with the fill char *
*****Python*****
```

### numpy.char.capitalize() 方法示例
```python
import numpy as np

print("Capitalizing the string using capitalize()...")
print(np.char.capitalize("welcome to Python"))
```
输出:
```python
Capitalizing the string using capitalize()...
Welcome to Python
```

### numpy.char.title() 方法示例
```python
import numpy as np

print("Converting string into title cased version...")
print(np.char.title("welcome to Python"))
```
输出:
```python
Converting string into title cased version...
Welcome To Python
```

### numpy.char.lower() 方法示例
```python
import numpy as np

print("Converting all the characters of the string into lowercase...")
print(np.char.lower("WELCOME TO PYTHON"))
```
输出:
```python
Converting all the characters of the string into lowercase...
welcome to Python
```

### numpy.char.upper() 方法示例
import numpy as np

print("Converting all the characters of the string into uppercase...")
print(np.char.upper("Welcome To Javatiku"))
```
输出:
```python
Converting all the characters of the string into uppercase...
WELCOME TO PYTHON
```

### numpy.char.split() 方法示例
```python
import numpy as np

print("Splitting the String word by word..")
print(np.char.split("Welcome To Python"), sep = " ")
```
输出:
```python
Splitting the String word by word..
['Welcome', 'To', 'Python']
```

### numpy.char.splitlines() 方法示例
```python
import numpy as np

print("Splitting the String line by line..")
print(np.char.splitlines("Welcome\nTo\nPython"))
```
输出:
```python
Splitting the String line by line..
['Welcome', 'To', 'Python']
```

### numpy.char.strip() 方法示例
```python
import numpy as np

str = "     welcome to Python     "
print("Original String:", str)
print("Removing the leading and trailing whitespaces from the string")
print(np.char.strip(str))
```
输出:
```python
Original String:      welcome to Python
Removing the leading and trailing whitespaces from the string
welcome to Python
```

### numpy.char.join() 方法示例
```python
import numpy as np
print(np.char.join(':','HM'))
```
输出:
```python
H:M
```
### numpy.char.replace() 方法示例
```python
import numpy as np

str = "Welcome to Python"
print("Original String:", str)
print("Modified String:", end=" ")
print(np.char.replace(str, "Welcome to", "www."))
```
输出:
```python
Original String: Welcome to Python
Modified String: www. Python
```

### numpy.char.encode() 和 decode() 方法示例
```python
import numpy as np

enstr = np.char.encode("welcome to pythontpoint", 'cp500')
dstr = np.char.decode(enstr, 'cp500')
print(enstr)
print(dstr)
```
输出:
```python
b'\xa6\x85\x93\x83\x96\x94\x85@\xa3\x96@\x91\x81\xa5\x81\xa3\x97\x96\x89\x95\xa3'
welcome to Python
```
