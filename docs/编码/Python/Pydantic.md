pydantic库是一种常用的用于数据接口 schema 定义与检查的库。
## 一、基本使用方法
### 1.1 schema基本定义方法
pydantic库的数据定义方式是通过BaseModel类来进行定义的，所有基于pydantic的数据类型本质上都是一个BaseModel类。
```
from pydantic import BaseModel

class Person(BaseModel):
    name:str
```
### 1.2 schema基本实例化方法
直接传值
```
p = Person(name="Tom")
print(p.json()). # {"name":"Tom"}
```
通过字典传入
```
p = {"name": "Tom"}
p = Persoon(**p)
print(p.json()). # {"name":"Tom"}
```
通过其他的实例化对象传入
```
p2 = Person.copy(p)
print(p2.json()) # {"name": "Tom"}
```
当传错值时就会报错
当传入多余定义值时，BaseModel也会进行过滤
```
p = Person(name="Tom", gender="man", age=24)
print(p.json()) # {"name": "Tom"}
```
通过这种方式，数据的传递将会更为安全，但是，同样的，这也要求我们在前期的schema定义中必须要尽可能地定义完全。

### 1.3 pydantic基本数据类型
```
from pydantic import BaseModel
from typing import Dict, List, Sequence, Set, Tuple
 
class Demo(BaseModel):
    a: int             # 整型
    b: float           # 浮点型
    c: str             # 字符串
    d: bool            # 布尔型
    e: List[int]       # 整型列表
    f: Dict[str, int]  # 字典型，key为str，value为int
    g: Set[int]        # 集合
    h: Tuple[str, int] # 元组
```
## 二、高级数据类型
### 2.1 enum数据类型
```
from enum import Enum
 
class Gender(str, Enum):
    man = "man"
    women = "women"
```
### 2.2 可选数据类型
如果一个数据类型不是必须的，可以允许用户在使用中不进行传入，则我们可以使用typing库中的Optional方法进行实现。
```
from typing import Optional
from pydantic import BaseModel
 
class Person(BaseModel):
    name: str
    age: Optional[int]
```
设置为可选之后，数据中仍然会有age字段，但是其默认值为None，即当不传入age字段时，Person仍然可以取到age，只是其值为None
```
p = Person(name="Tom")
print(p.json()) # {"name": "Tom", "age": None}
```
### 2.3 数据默认值的设置
可选数据类型方法事实上是一种较为特殊的给予数据默认值的方法，只是给其的默认值为None。
可以给出一些更加一般性的给出数据默认值的方法
```
from pydantic import BaseModel
 
class Person(BaseModel):
    name: str
    gender: str = "man"
 
p = Person(name="Tom")
print(p.json()) # {"name": "Tom", "gender": "man"}
```
### 2.4 允许多种数据类型
如果一个数据可以允许多种数据类型，我们可以通过typing库中的Union方法进行实现。
```
from typing import Union
from pydantic import BaseModel
 
class Time(BaseModel):
    time: Union[int, str]
         
t = Time(time=12345)
print(t.json()) # {"time": 12345}
t = Time(time = "2020-7-29")
print(t.json()) # {"time": "2020-7-29"}
```
### 2.5 异名数据传递方法
假设我们之前已经定义了一个schema，将其中某一个参量命名为了A，但是在后续的定义中，我们希望这个量被命名为B，要如何完成这两个不同名称参量的相互传递
可以使用 “alias”
```
from pydantic import BaseModel, Field
 
class Password(BaseModel):
    password: str = Field(alias = "key")
```
但是在传入时，我们需要用key关键词来传入password变量。
```
p = Password(key="123456")
print(p.json()) # {"password": "123456"}
```
## 三、多级schema定义
较为复杂的基于pydantic的schema定义实现样例。
```
from enum import Enum
from typing import List, Union
from datetime import date
from pydantic import BaseModel
 
class Gender(str, Enum):
    man = "man"
    women = "women"
 
class Person(BaseModel):
    name : str
    gender : Gender
         
class Department(BaseModel):
    name : str
    lead : Person
    cast : List[Person]
         
class Group(BaseModel):
    owner: Person
    member_list: List[Person] = []
 
class Company(BaseModel):
    name: str
    owner: Union[Person, Group]
    regtime: date
    department_list: List[Department] = []
```
我们除了可以一步一步地实例化之外，如果我们已经有了一个完整的Company的内容字典，我们也可以一步到位地进行实例化
```
sales_department = {
    "name": "sales",
    "lead": {"name": "Sarah", "gender": "women"},
    "cast": [
        {"name": "Sarah", "gender": "women"},
        {"name": "Bob", "gender": "man"},
        {"name": "Mary", "gender": "women"}
    ]
}
 
research_department = {
    "name": "research",
    "lead": {"name": "Allen", "gender": "man"},
    "cast": [
        {"name": "Jane", "gender": "women"},
        {"name": "Tim", "gender": "man"}
    ]
}
 
company = {
    "name": "Fantasy",
    "owner": {"name": "Victor", "gender": "man"},
    "regtime": "2020-7-23",
    "department_list": [
        sales_department,
        research_department
    ]
}
 
company = Company(**company)
```
## 四、数据检查方法考察
pydantic本身提供了上述基本类型的数据检查方法，但是，除此之外，我们也可以使用validator和config方法来实现更为复杂的数据类型定义以及检查
### 4.1 validator用法考察
用validator方法，我们可以对数据进行更为复杂的数据检查
```
import re
from pydantic import BaseModel, validator
 
class Password(BaseModel):
    password: str
         
    @validator("password")
    def password_rule(cls, password):
        def is_valid(password):
            if len(password) < 6 or len(password) > 20:
                return False
            if not re.search("[a-z]", password):
                return False
            if not re.search("[A-Z]", password):
                return False
            if not re.search("\d", password):
                return False
            return True
        if not is_valid(password):
            raise ValueError("password is invalid")
```
通过这种方式，我们就可以额外对密码类进行格式要求，对其字符数以及内部字符进行要求。
### 4.2 Config方法考察
如果要对BaseModel中的某一基本型进行统一的格式要求，还可以使用Config方法来实现
```
from pydantic import BaseModel
 
class Password(BaseModel):
    password: str
         
    class Config:
        min_anystr_length = 6 # 令Password类中所有的字符串长度均要不少于6
        max_anystr_length = 20 # 令Password类中所有的字符串长度均要不大于20
```
有关Config类中的特殊关键词名称，这里只给出了两个简单的例子，更多的内容可以参考官网

## 五、参考链接
- https://pydantic-docs.helpmanual.io/
- https://blog.csdn.net/swinfans/article/details/89629641
