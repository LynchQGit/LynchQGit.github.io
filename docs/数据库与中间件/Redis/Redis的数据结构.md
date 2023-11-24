Redis支持多种数据结构，包括字符串（String）、列表（List）、集合（Set）、有序集合（Sorted Set）和哈希（Hash）。以下是这些数据结构的详细介绍以及它们各自的增删查改命令：

### 字符串（String）：
字符串是Redis最简单的数据结构，可以存储文本或二进制数据。字符串值的最大长度为512MB。
- 增（Set）：`SET key value`，将字符串值value关联到key。
- 删（Delete）：`DEL key`，删除存储的键值对。
- 查（Get）：`GET key`，获取与key关联的字符串值。
- 改（Update）：`SET key new_value`，将新的字符串值new_value关联到key。
### 列表（List）：
列表是一种简单的字符串链表，按照插入顺序排序。列表的元素可以重复。
- 增（Push）：
  - `LPUSH key value`，将一个或多个值插入到列表头部。
  - `RPUSH key value`，将一个或多个值插入到列表尾部。
- 删（Remove）：
  - `LPOP key`，移除并返回列表的第一个元素。
  - `RPOP key`，移除并返回列表的最后一个元素。
- 查（Get）：
  - `LRANGE key start stop`，获取列表指定范围内的元素。
  - `LINDEX key index`，通过索引获取列表中的元素。
- 改（Update）：
  - `LSET key index value`，通过索引设置列表元素的值。
### 集合（Set）：
集合是一种无序的字符串集合，集合中的元素是唯一的。
- 增（Add）：`SADD key member`，将一个或多个成员元素加入到集合中。
- 删（Remove）：`SREM key member`，移除集合中一个或多个成员元素。
- 查（Get）：
  - `SMEMBERS key`，返回集合中的所有成员。
  - `SISMEMBER key member`，判断成员元素是否是集合的成员。
- 改（Update）：集合没有直接的更新命令。要更新元素，需要先删除旧元素，然后添加新元素。
### 有序集合（Sorted Set）：
有序集合是一种排序的字符串集合，每个元素关联一个分数（浮点数），元素按分数排序。
- 增（Add）：`ZADD key score member`，将一个或多个成员元素及其分数加入到有序集合中。
- 删（Remove）：`ZREM key member`，移除有序集合中一个或多个成员元素。
- 查（Get）：
  - `ZRANGE key start stop [WITHSCORES]`，返回有序集合指定范围内的成员。
  - `ZRANK key member`，返回有序集合中指定成员的排名。
- 改（Update）：ZADD key new_score member，更新成员元素的分数。

### 哈希（Hash）：
哈希是一种键值对集合，适用于存储对象。
- 增（Set）：`HSET key field value`，将哈希表key中的字段field的值设为value。
- 删（Delete）：`HDEL key field`，删除哈希表key中的一个或多个指定字段。
- 查（Get）：
  - `HGET key field`，获取存储在哈希表中指定字段的值。
  - `HGETALL key`，获取哈希表中所有的字段和值。
- 改（Update）：`HSET key field new_value`，将哈希表key中的字段field的值设为new_value。

以上是Redis数据结构及其增删查改的常用命令。实际上，Redis还有许多其他的命令用于操作这些数据结构，可以参考Redis官方文档了解更多信息。
