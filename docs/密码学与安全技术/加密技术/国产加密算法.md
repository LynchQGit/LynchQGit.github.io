## 一. 简介
事实上从 2010 年开始，我国国家密码管理局就已经开始陆续发布了一系列国产加密算法，这其中就包括`SM1、SM2、SM3 、SM4、SM7、SM9、ZUC（祖冲之加密算法）`等，`SM`代表商密，即商业密码，是指用于商业的、不涉及国家秘密的密码技术。`SM1` 和 `SM7` 的算法不公开，其余算法都已成为 `ISO/IEC` 国际标准。
在这些国产加密算法中，`SM2、SM3、SM4` 三种加密算法是比较常见的
## 二. SM2加密算法
`SM2` 为椭圆曲线`（ECC）`公钥加密算法，非对称加密，`SM2` 算法和 `RSA` 算法都是公钥加密算法，`SM2` 算法是一种更先进安全的算法，在我们国家商用密码体系中被用来替换 `RSA` 算法，在不少官方网站会见到此类加密算法
## 三. 需要安装第三方库
1. `python`安装。
在 `Python` 里面并没有比较官方的库来实现国密算法，这里仅列出了其中两个较为完善的第三方库，需要注意的是，`SM1` 和 `SM7` 算法不公开，目前大多库仅实现了 `SM2`、`SM3`、`SM4` 三种密算法。

    ```
    pip install gmssl
    ```

2. JavaScript安装
    ```
    npm install sm-crypto --save
    ```

## 四. SM2加密用法，类似RSA加密
- 在 `Python` 里面并没有比较官方的库来实现国密算法，这里仅列出了其中两个较为完善的第三方库，需要注意的是，`SM1` 和 `SM7` 算法不公开，目前大多库仅实现了 `SM2`、`SM3`、`SM4` 三种密算法。
1. python实现
```
from gmssl import sm2

# 16 进制的公钥和私钥
private_key = '00B9AB0B828FF68872F21A837FC303668428DEA11DCD1B24429D0C99E24EED83D5'
public_key = 'B9C9A6E04E9C91F7BA880429273747D7EF5DDEB0BB2FF6317EB00BEF331A83081A6994B8993F3F5D6EADDDB81872266C87C018FB4162F5AF347B483E24620207'
sm2_crypt = sm2.CryptSM2(public_key=public_key, private_key=private_key)

# 待加密数据和加密后数据为 bytes 类型
data = "明文数据"
enc_data = sm2_crypt.encrypt(data.encode())
dec_data = sm2_crypt.decrypt(enc_data)

print('加密数据: ', enc_data.hex())  # 不固定
print('解密明文: ', dec_data.decode())  # 明文数据
```

- 在 `JavaScript` 中已有比较成熟的实现库，这里推荐 `sm-crypto[4]`，目前支持 `SM2`、`SM3` 和 `SM4`，需要注意的是，`SM2` 非对称加密的结果由 `C1`、`C2`、`C3` 三部分组成，其中 `C1` 是生成随机数的计算出的椭圆曲线点，`C2` 是密文数据，`C3` 是 `SM3` 的摘要值，最开始的国密标准的结果是按 `C1C2C3` 顺序的，新标准的是按 `C1C3C2` 顺序存放的，`sm-crypto` 支持设置 `cipherMode`，也就是 `C1C2C3` 的排列顺序

2. JavaScript实现
```
const sm2 = require('sm-crypto').sm2

// 1 - C1C3C2，0 - C1C2C3，默认为1
const cipherMode = 1

// 获取密钥对
let keypair = sm2.generateKeyPairHex()
let publicKey = keypair.publicKey   // 公钥
let privateKey = keypair.privateKey // 私钥

let msgString = "我是sm加密"
let encryptData = sm2.doEncrypt(msgString, publicKey, cipherMode)    // 加密结果
let decryptData = sm2.doDecrypt(encryptData, privateKey, cipherMode) // 解密结果

console.log("加密密文: ", encryptData)
console.log("解密明文: ", decryptData)
```

## 五. SM3加密,类似SHA加密
1. python实现
```
from gmssl.sm3 import sm3_hash


message = '你想要加密的消息'
# 将消息转换为字节
message_bytes = [ord(char) for char in message]
# 生成哈希值
hash_value = sm3_hash(message_bytes)
print(hash_value)
```

2. JavaScript实现
```
const sm3 = require('sm-crypto').sm3;

// 待哈希的数据
const data = 'hello world';
const options={
  key:'aaaaaaa',
  mode:'hmac'
}
// 计算SM3哈希值
const hash = sm3(data,options)

// 输出哈希结果
console.log(hash.toString()); // 794943fc0229eeef9f1b0b35948e1ac55910ad86572baa53c8331f3e9e85b10b
```

## 六. SM4加密，类似DES \ AES加密
`SM4 `为无线局域网标准的分组加密算法，对称加密，用于替代 `DES/AES` 等国际算法，`SM4` 算法与 `AES` 算法具有相同的密钥长度和分组长度，均为 `128` 位，故对消息进行加解密时，若消息长度过长，需要进行分组，要消息长度不足，则要进行填充。加密算法与密钥扩展算法都采用 `32` 轮非线性迭代结构，解密算法与加密算法的结构相同，只是轮密钥的使用顺序相反，解密轮密钥是加密轮密钥的逆序。
1. python实现
```
# -*- coding: utf-8 -*-
# Auther : Lynch
# Date : 2023/9/10 13:32
# File : sm4加密.py


from gmssl import sm4, func

# 密钥（16字节）

def sm4_crypt(data_byte,key_byte):
    # 创建SM4对象
    crypt_sm4 = sm4.CryptSM4()
    # 设置密钥
    crypt_sm4.set_key(key_byte, sm4.SM4_ENCRYPT)
    # 加密数据
    encrypted_data = crypt_sm4.crypt_ecb(data_byte)
    return encrypted_data


def sm4_decrypt(encrypted_data,key_byte):
    # 创建一个新的SM4对象用于解密
    decrypt_sm4 = sm4.CryptSM4()
    # 设置密钥
    decrypt_sm4.set_key(key_byte, sm4.SM4_DECRYPT)
    # 解密数据

    decrypted_data = decrypt_sm4.crypt_ecb(encrypted_data)
    return decrypted_data

if __name__ == '__main__':
    # 明文数据（确保是16的倍数）
    data = 'Hello, SM4 encryption!'
    key = '0123456789abcdeffedcba9876543210'
    key_byte=key.encode("utf-8")
    data_byte=data.encode("utf-8")

    encrypted_data_byte=sm4_crypt(data_byte=data_byte,key_byte=key_byte)
    decrypted_data_byte=sm4_decrypt(encrypted_data_byte,key_byte)

    print("加密后的数据：", encrypted_data_byte) # b'\xdf\xa4\xcfb\x9e\x97K\x1a\x10\xaee@gBn\x07G\xd6\xf9\xb0\xcbD\x97\x86\x84\xaa\x05&\x98\x01oq'
    print("解密后的数据：", decrypted_data_byte.decode("utf-8")) # Hello, SM4 encryption!
```

2. JavaScript实现
```
const sm4 = require('sm-crypto').sm4;

// 密钥（16字节）
const key = '0123456789abcdeffedcba9876543210';

// 明文数据（确保是16的倍数）
const plaintext = 'Hello, SM4 encryption!';

// 加密数据
const cipherText = sm4.encrypt(plaintext,key);
console.log('加密后的数据：', cipherText);

// 解密数据
const decryptedText = sm4.decrypt(cipherText,key);
console.log('解密后的数据：', decryptedText);
```
