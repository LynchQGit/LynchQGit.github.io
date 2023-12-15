MySQL 支持查询 JSON 字段内部的 key。从 MySQL 5.7.8 版本开始，MySQL 提供了 JSON 数据类型以及一些 JSON 函数来处理 JSON 数据。您可以使用这些 JSON 函数来查询、修改和操作 JSON 字段中的数据。
假设有一个名为 users 的表，其中有一个 JSON 类型的字段叫做 user_data。user_data 的 JSON 数据结构如下：
```
{
  "name": "John Doe",
  "age": 30,
  "address": {
    "city": "New York",
    "state": "NY"
  }
}
```
### 查询
如果您想查询 user_data 中的 name key，可以使用 -> 或 ->> 操作符，或者使用 JSON_EXTRACT() 函数。以下是一些示例查询：
```
-- 使用 -> 操作符
SELECT user_data->'$.name' AS name FROM users;

-- 使用 ->> 操作符（返回 unquoted 的值）
SELECT user_data->>'$.name' AS name FROM users;

-- 使用 JSON_EXTRACT() 函数
SELECT JSON_EXTRACT(user_data, '$.name') AS name FROM users;
```

如果您想查询嵌套的 key，比如 address 对象中的 city，只需提供正确的 JSON 路径即可：
```
-- 使用 -> 操作符
SELECT user_data->'$.address.city' AS city FROM users;

-- 使用 ->> 操作符（返回 unquoted 的值）
SELECT user_data->>'$.address.city' AS city FROM users;

-- 使用 JSON_EXTRACT() 函数
SELECT JSON_EXTRACT(user_data, '$.address') AS city FROM users;
```

### 插入 or 更新
要修改和操作 MySQL 中的 JSON 字段，您可以使用一些专用的 JSON 函数。以下是一些常用的修改和操作 JSON 数据的函数及其用法。
- JSON_SET(): 在 JSON 文档中插入或更新值。
```
UPDATE users
SET user_data = JSON_SET(user_data, '$.name', 'Jane Doe')
WHERE id = 1;
```
这将更新 id 为 1 的用户的 name 值为 "Jane Doe"。
- JSON_REPLACE(): 在 JSON 文档中替换现有值。
```
UPDATE users
SET user_data = JSON_REPLACE(user_data, '$.age', 35)
WHERE id = 1;
```
这将把 id 为 1 的用户的 age 值替换为 35。

JSON_REMOVE(): 从 JSON 文档中删除键值对。
```
UPDATE users
SET user_data = JSON_REMOVE(user_data, '$.address.state')
WHERE id = 1;
```
这将从 id 为 1 的用户的 address 对象中删除 state 键值对。

- JSON_INSERT(): 在 JSON 文档中插入新的键值对，如果键已经存在，则不执行任何操作。
```
UPDATE users
SET user_data = JSON_INSERT(user_data, '$.address.country', 'USA')
WHERE id = 1;
```
这将在 id 为 1 的用户的 address 对象中插入新的键值对 country: USA。

- JSON_ARRAY_APPEND(): 在 JSON 数组中追加一个值。
```
{
  "name": "John Doe",
  "age": 30,
  "address": {
    "city": "New York",
    "state": "NY"
  },
  "hobbies": ["reading", "swimming"]
}
```
- 使用 JSON_ARRAY_APPEND() 函数将新的爱好 "travelling" 追加到 hobbies 数组：
```
UPDATE users
SET user_data = JSON_ARRAY_APPEND(user_data, '$.hobbies', 'travelling')
WHERE id = 1;
```
这些函数可以帮助我们在 MySQL 中修改和操作 JSON 字段。可以组合使用这些函数对 JSON 数据进行复杂的操作。

