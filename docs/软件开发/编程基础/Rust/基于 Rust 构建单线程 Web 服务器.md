# 基于 Rust 构建单线程 Web 服务器
在当今的互联网时代,Web服务器是支撑各种网络应用的基础设施。作为一名开发者,了解Web服务器的工作原理和实现方式非常重要。本文将带领大家使用Rust语言从零开始构建一个简单的单线程Web服务器,深入理解Web服务器的核心概念和基本架构。

> **为什么选择 Rust 语言**

Rust 是一门系统级编程语言, 具有高性能、内存安全和并发性等特点, 非常适合用来构建 Web 服务器这样的底层基础设施。相比 C/C++, Rust 提供了更好的安全保证; 相比 Go 等高级语言, Rust 又能更好地控制底层细节。因此, 用 Rust 来实现 Web 服务器既能保证性能, 又能提高开发效率和代码质量。

> **Web 服务器的基本原理**

在开始编码之前,我们先来了解一下 Web 服务器的基本工作原理。Web 服务器主要基于 HTTP 协议工作,而 HTTP 又是基于 TCP 协议的。整个过程可以简化为以下步骤:

1. 服务器监听指定的 TCP 端口
2. 客户端(如浏览器)发起 TCP 连接
3. 服务器接受连接,建立 TCP 连接
4. 客户端发送 HTTP 请求
5. 服务器解析 HTTP 请求
6. 服务器处理请求并生成 HTTP 响应
7. 服务器发送 HTTP 响应

> **搭建项目框架**

首先, 创建一个新的 Rust 项目:

```bash
cargo new my-webserver-rs
cd my-webserver-rs
```

然后在 `src/main.rs` 文件中编写代码:

```rust
use std::net::TcpListener;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        println!("Connection established!");
    }
}
```

这段代码实现了最基本的TCP监听功能:
1. 使用 `TcpListener::bind()` 在本地地址 `127.0.0.1` 的 `7878` 端口上创建一个 TCP 监听器。
2. 使用 `for` 循环遍历 `listener.incoming()` 返回的连接流。对于每个连接, 打印一条信息。
3. 运行这段代码, 然后在浏览器中访问 `http://127.0.0.1:7878`, 你会看到终端打印出 "Connection established!"。

> **读取 HTTP 请求**

下一步,我们需要读取客户端发送的HTTP请求。修改 `main.rs` 如下:

```rust
use std::io::prelude::*;
use std::net::TcpStream;
use std::net::TcpListener;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        handle_connection(stream);
    }
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    println!("Request: {}", String::from_utf8_lossy(&buffer[..]));
}
```

这里我们:
1. 定义了一个handle_connection函数来处理每个连接。
2. 在函数中创建一个1024字节的缓冲区来存储请求数据。
3. 使用read()方法读取请求内容到缓冲区。
4. 将缓冲区内容转换为字符串并打印出来。
5. 运行程序并在浏览器中访问,你将看到完整的HTTP请求内容被打印出来。

运行这段代码, 然后在浏览器中访问 `http://127.0.0.1:7878`, 你会看到终端打印出 HTTP 请求的内容:

```
Request: GET / HTTP/1.1
Host: localhost:7878
Connection: keep-alive
Cache-Control: max-age=0
sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "macOS"
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Sec-Fetch-Site: none
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Accept-Encoding: gzip, deflate, br, zstd
Accept-Language: zh-CN,zh;q=0.9
Cookie: id=eb3fcebc-f945-4afe-aca8-f9f82f5def4a;
```

> **解析 HTTP 请求**

现在我们能读取请求了,下一步是解析这个请求。我们主要关注请求的第一行,它包含了请求方法、路径和HTTP版本。修改`handle_connection`函数如下:

```rust
fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let request = String::from_utf8_lossy(&buffer[..]);
    let request_line = request.lines().next().unwrap();
    
    if request_line == "GET / HTTP/1.1" {
        // 处理根路径请求
    } else {
        // 处理其他请求
    }
}
```

这里我们:
1. 将缓冲区内容转换为字符串。
2. 使用lines()方法获取请求的第一行。
3. 检查是否是对根路径("/")的GET请求。
4. 根据请求类型进行不同的处理。

> **返回 HTTP 响应**

接下来,我们需要根据请求返回相应的HTTP响应。我们将为根路径请求返回一个HTML页面,为其他请求返回`404错误`。首先在项目根目录创建两个HTML文件:

hello.html:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Hello!</title>
</head>
<body>
    <h1>Hello!</h1>
    <p>Hi from Rust</p>
</body>
</html>
```

404.html:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>404 Not Found</title>
</head>
<body>
    <h1>Oops!</h1>
    <p>Sorry, I don't know what you're asking for.</p>
</body>
</html>
```

然后修改`handle_connection`函数, 根据请求路径返回不同的响应:

```rust
use std::fs;

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let request = String::from_utf8_lossy(&buffer[..]);
    let request_line = request.lines().next().unwrap();
    
    let (status_line, filename) = if request_line == "GET / HTTP/1.1" {
        ("HTTP/1.1 200 OK", "hello.html")
    } else {
        ("HTTP/1.1 404 NOT FOUND", "404.html")
    };

    let contents = fs::read_to_string(filename).unwrap();
    let response = format!(
        "{}\r\nContent-Length: {}\r\n\r\n{}",
        status_line,
        contents.len(),
        contents
    );

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}
```

这段代码:
1. 根据请求选择适当的状态行和文件名。
2. 读取对应的HTML文件内容。
3. 构造HTTP响应,包括状态行、Content-Length头和响应体。
4. 将响应写入流并刷新。

运行程序, 然后在浏览器中访问 `http://127.0.0.1:7878` 和 `http://127.0.0.1:7878/some-path`, 你会看到不同的响应内容。

> **优化和重构**

现在我们的Web服务器已经能够正常工作了,但代码还有优化的空间。让我们对代码进行一些重构,使其更加简洁和可维护。首先,我们可以将请求处理逻辑抽取成一个单独的函数:

```rust
fn handle_request(request_line: &str) -> (&str, &str) {
    match request_line {
        "GET / HTTP/1.1" => ("HTTP/1.1 200 OK", "hello.html"),
        _ => ("HTTP/1.1 404 NOT FOUND", "404.html"),
    }
}
```

然后,我们可以将响应构建逻辑也抽取成一个函数:

```rust
fn build_response(status_line: &str, contents: &str) -> String {
    format!(
        "{}\r\nContent-Length: {}\r\n\r\n{}",
        status_line,
        contents.len(),
        contents
    )
}
```

现在,我们的`handle_connection`函数可以简化为:

```rust
fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let request = String::from_utf8_lossy(&buffer[..]);
    let request_line = request.lines().next().unwrap();
    
    let (status_line, filename) = handle_request(request_line);
    let contents = fs::read_to_string(filename).unwrap();
    let response = build_response(status_line, &contents);

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}
```

这样重构后的代码更加模块化,每个函数都有明确的单一职责,使得代码更易于理解和维护。

> **添加日志功能**

为了更好地监控服务器的运行状况,我们可以添加一些简单的日志功能。Rust生态系统中有很多优秀的日志库,如`log`和`env_logger`。这里我们就使用这两个库来实现日志功能。

首先,在`Cargo.toml`中添加依赖:

```toml
[dependencies]
log = "0.4"
env_logger = "0.11"

```

然后,在`main.rs`中初始化日志:

```rust
use log::{info, error};

fn main() {
    env_logger::init();
    // ...
}
```

现在我们可以在代码中添加日志了:

```rust
fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let request = String::from_utf8_lossy(&buffer[..]);
    let request_line = request.lines().next().unwrap();
    
    info!("Received request: {}", request_line);
    
    let (status_line, filename) = handle_request(request_line);
    let contents = match fs::read_to_string(filename) {
        Ok(contents) => contents,
        Err(e) => {
            error!("Failed to read file: {}", e);
            String::from("Internal Server Error")
        }
    };
    let response = build_response(status_line, &contents);

    if let Err(e) = stream.write(response.as_bytes()) {
        error!("Failed to send response: {}", e);
    }
    if let Err(e) = stream.flush() {
        error!("Failed to flush stream: {}", e);
    }
}
```

这样, 我们就可以记录每个请求的信息, 以及可能出现的错误。