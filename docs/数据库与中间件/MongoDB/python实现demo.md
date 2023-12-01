首先，我们需要安装Python的MongoDB驱动模块pymongo。可以使用以下命令安装：
```
pip install pymongo
```
```
import pymongo

# 连接 MongoDB
client = pymongo.MongoClient("mongodb://localhost:27017/")

# 创建数据库
db = client["mydatabase"]

# 创建集合
collection = db["mycollection"]

# 插入一条数据
data = {"name": "Alice", "age": 20}
collection.insert_one(data)

# 查询数据
query = {"name": "Alice"}
result = collection.find(query)
for document in result:
    print(document)
```
然后，使用pymongo模块连接MongoDB数据库。这里使用pymongo.MongoClient()方法连接本地MongoDB数据库。连接字符串的格式为mongodb://host:port/，其中host是MongoDB服务器的IP地址或主机名，port是MongoDB服务器的端口号，默认是27017。

接着，创建一个名为mydatabase的数据库。如果这个数据库不存在，则会在连接时自动创建。

然后，创建一个名为mycollection的集合。如果这个集合不存在，则会在插入数据时自动创建。

接下来，插入一条数据。这里使用collection.insert_one()方法插入一条数据，数据格式为Python字典。

最后，查询数据。这里使用collection.find()方法查询符合条件的所有数据，并使用循环输出每条数据。

需要注意的是，在生产环境中，为了保证MongoDB服务器的安全，需要对MongoDB服务器进行授权和认证。另外，还需要使用连接池等技术来优化MongoDB数据库的性能和稳定性。
