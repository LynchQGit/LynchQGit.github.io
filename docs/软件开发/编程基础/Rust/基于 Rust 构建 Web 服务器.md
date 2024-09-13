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

**性能考虑**
> **多线程实现**

1. 首先，我们在文件顶部添加了 use std::thread; 来引入 Rust 的线程模块。
2. 在 main 函数中，我们修改了处理incoming连接的逻辑：
    - 使用 match 语句来处理 stream 的 Result，这样我们可以更好地处理可能的错误。
    - 对于每个成功的连接（Ok(stream)），我们使用 thread::spawn 创建一个新线程。
    - 新线程执行 handle_connection(stream) 函数。
    - 如果接受连接时出错，我们会记录错误信息。
3. `handle_connection` 函数及其他函数保持不变。

这些更改的效果是：
- 服务器现在可以并发处理多个连接，每个连接在自己的线程中运行。
- 主线程不会被单个连接阻塞，可以继续接受新的连接。
- 服务器的响应能力和吞吐量都会提高，特别是在高并发情况下。

```rust
use std::thread;

fn main() {
    env_logger::init();
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    info!("Listening on 127.0.0.1:7878");

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                thread::spawn(|| {
                    handle_connection(stream);
                });
            }
            Err(e) => {
                error!("Failed to accept connection: {}", e);
            }
        }
    }
}
```

> **添加线程池**

可以限制并发线程的数量，从而更有效地管理系统资源。我们将使用 `threadpool crate` 来实现这一点。
首先，需要在 `Cargo.toml` 文件中添加 `threadpool` 依赖：

```toml
[dependencies]
threadpool = "1.8.1"
```

然后修改 `src/main.rs` 文件:

```rust
use threadpool::ThreadPool;

fn main() {
    env_logger::init();
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    let pool = ThreadPool::new(4);

    info!("Listening on 127.0.0.1:7878");

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                pool.execute(|| {
                    handle_connection(stream);
                })
            }
            Err(e) => {
                error!("Failed to accept connection: {}", e);
            }
        }
    }
}
```
1. 我们添加了 `use threadpool::ThreadPool;` 来引入 `ThreadPool` 类型。
2. 在 `main` 函数中，我们创建了一个有 4 个线程的 `ThreadPool`。你可以根据你的系统性能和需求调整这个数字。
3. 在处理每个连接时，我们不再直接创建新线程，而是使用 `pool.execute()` 来将任务提交到线程池。

这种方法的优点是：
- 限制了并发线程的最大数量，防止在高负载情况下创建过多线程。
- 重用线程，避免频繁创建和销毁线程的开销。
- 通过队列机制管理任务，当所有线程都忙时，新任务会等待直到有线程可用。

如果你想进一步优化，可以考虑：
1. 让线程池大小可配置，例如通过命令行参数或配置文件设置。
2. 实现优雅关闭，确保在服务器关闭时所有正在处理的请求都能完成。
3. 添加一些监控指标，如当前活跃线程数、等待队列长度等。

> **异步 I/O 实现**

首先，更新 Cargo.toml 文件，添加必要的依赖：
```toml
[dependencies]
tokio = { version = "1.28", features = ["full"] }
log = "0.4"
env_logger = "0.10"
```

然后重写 `src/main.rs` 文件:
```rust
use tokio::net::{TcpListener, TcpStream};
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use std::fs;
use log::{info, error};

#[tokio::main]
async fn main() {
    env_logger::init();
    let listener = TcpListener::bind("127.0.0.1:7878").await.unwrap();

    info!("Listening on 127.0.0.1:7878");

    loop {
        match listener.accept().await {
            Ok((stream, _)) => {
                tokio::spawn(async move {
                    handle_connection(stream).await;
                });
            }
            Err(e) => {
                error!("Error accepting connection: {}", e);
            }
        }
    }
}

async fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];

    match stream.read(&mut buffer).await {
        Ok(_) => {
            let request = String::from_utf8_lossy(&buffer[..]);
            let request_line = request.lines().next().unwrap_or("");

            info!("Received request: {}", request_line);

            let (status_line, filename) = handle_request(request_line);

            let contents = match fs::read_to_string(filename) {
                Ok(contents) => contents,
                Err(e) => {
                    error!("Failed to read file: {}", e);
                    "File not found".to_string()
                }
            };

            let response = handle_response(status_line, &contents);

            if let Err(e) = stream.write_all(response.as_bytes()).await {
                error!("Failed to write to stream: {}", e);
            }
            if let Err(e) = stream.flush().await {
                error!("Failed to flush stream: {}", e);
            }
        }
        Err(e) => {
            error!("Failed to read from stream: {}", e);
        }
    }
}

// handle_request 和 handle_response 函数保持不变
// ...
```

**安全性考虑**
> **防止目录遍历攻击**
修改 `src/main.rs` 文件:

```rust
use std::path::Path;

fn handle_request(request_line: &str) -> (&str, String) {
    let (status_line, file_path) = match request_line {
        "GET / HTTP/1.1" => ("HTTP/1.1 200 OK", "src/hello.html"),
        _ => ("HTTP/1.1 404 NOT FOUND", "src/404.html"),
    };

    let safe_path = Path::new(file_path).canonicalize().unwrap_or_default();
    let root_dir = Path::new("src").canonicalize().unwrap_or_default();

    if safe_path.starts_with(&root_dir) {
        (status_line, safe_path.to_str().unwrap_or("").to_string())
    } else {
        ("HTTP/1.1 403 FORBIDDEN", "src/403.html".to_string())
    }
}
```

> **实现简单的路由功能**
让我们来实现一个简单的路由功能，这将使服务器更加灵活和易于扩展。我们将使用闭包来定义路由处理函数，这样可以轻松地添加新的路由。
以下是实现路由功能的方法：

```rust
use std::collections::HashMap;
use tokio::net::{TcpListener, TcpStream};
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use std::sync::Arc;
use log::{info, error};

type RouteHandler = Arc<dyn Fn(String) -> String + Send + Sync>;

struct Router {
    routes: HashMap<String, RouteHandler>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: HashMap::new(),
        }
    }

    fn add_route<F>(&mut self, path: &str, handler: F)
    where
        F: Fn(String) -> String + Send + Sync + 'static,
    {
        self.routes.insert(path.to_string(), Arc::new(handler));
    }

    fn handle_request(&self, path: &str, body: String) -> (String, String) {
        match self.routes.get(path) {
            Some(handler) => ("HTTP/1.1 200 OK".to_string(), handler(body)),
            None => ("HTTP/1.1 404 NOT FOUND".to_string(), "404 Not Found".to_string()),
        }
    }
}

#[tokio::main]
async fn main() {
    env_logger::init();
    let mut router = Router::new();

    // 添加路由
    router.add_route("/", |_| "Hello, World!".to_string());
    router.add_route("/about", |_| "About page".to_string());
    router.add_route("/echo", |body| body);

    let router = Arc::new(router);

    let listener = TcpListener::bind("127.0.0.1:7878").await.unwrap();
    info!("Listening on 127.0.0.1:7878");

    loop {
        match listener.accept().await {
            Ok((stream, _)) => {
                let router = router.clone();
                tokio::spawn(async move {
                    handle_connection(stream, router).await;
                });
            }
            Err(e) => {
                error!("Error accepting connection: {}", e);
            }
        }
    }
}

async fn handle_connection(mut stream: TcpStream, router: Arc<Router>) {
    let mut buffer = [0; 1024];

    match stream.read(&mut buffer).await {
        Ok(_) => {
            let request = String::from_utf8_lossy(&buffer[..]);
            let request_line = request.lines().next().unwrap_or("");
            let (method, path, _) = parse_request_line(request_line);

            info!("Received request: {} {}", method, path);

            let body = extract_body(&request);
            let (status_line, response_body) = router.handle_request(path, body);

            let response = format!(
                "{}\r\nContent-Length: {}\r\n\r\n{}",
                status_line,
                response_body.len(),
                response_body
            );

            if let Err(e) = stream.write_all(response.as_bytes()).await {
                error!("Failed to write to stream: {}", e);
            }
            if let Err(e) = stream.flush().await {
                error!("Failed to flush stream: {}", e);
            }
        }
        Err(e) => {
            error!("Failed to read from stream: {}", e);
        }
    }
}

fn parse_request_line(request_line: &str) -> (&str, &str, &str) {
    let mut parts = request_line.split_whitespace();
    let method = parts.next().unwrap_or("");
    let path = parts.next().unwrap_or("");
    let version = parts.next().unwrap_or("");
    (method, path, version)
}

fn extract_body(request: &str) -> String {
    request.split("\r\n\r\n").nth(1).unwrap_or("").to_string()
}
```

这个实现添加了以下功能：
1. Router 结构体，用于存储和管理路由。
2. add_route 方法，允许添加新的路由和对应的处理函数。
3. handle_request 方法，根据请求路径调用相应的处理函数。
4. 在 main 函数中，我们创建 Router 实例并添加一些示例路由。
5. handle_connection 函数现在使用 Router 来处理请求。
6. 添加了 parse_request_line 和 extract_body 辅助函数来解析请求。

这个实现允许你轻松地添加新的路由和处理函数。例如，你可以这样添加新路由：
```rust
router.add_route("/api/users", |_| {
    // 这里可以添加获取用户列表的逻辑
    "{\"users\": [\"Alice\", \"Bob\"]}".to_string()
});
```

> **支持不同的 HTTP 方法**
首先来定义一个枚举来表示不同的 HTTP 方法：
```rust
#[derive(Debug, PartialEq, Eq, Hash, Clone)]
enum HttpMethod {
    GET,
    POST,
    PUT,
    DELETE,
    // 可以根据需要添加其他 HTTP 方法
}
```

创建了 Request 结构体，包含 HTTP 方法、路径和请求体。
```rust
struct Request {
    method: HttpMethod,
    path: String,
    body: String,
}
```

修改了 Router 结构，使用 (HttpMethod, String) 作为路由的键，这样可以同时匹配 HTTP 方法和路径。
```rust
struct Router {
    routes: HashMap<(HttpMethod, String), RouteHandler>,
}
```

更新了 add_route 和 handle_request 方法以支持 HTTP 方法。
```rust
impl Router {
    fn new() -> Self {
        Router {
            routes: HashMap::new(),
        }
    }

    fn add_route<F>(&mut self, method: HttpMethod, path: &str, handler: F)
    where
        F: Fn(Request) -> Response + Send + Sync + 'static,
    {
        self.routes.insert((method, path.to_string()), Arc::new(handler));
    }

    fn handle_request(&self, request: Request) -> (String, Response) {
        match self.routes.get(&(request.method.clone(), request.path.clone())) {
            Some(handler) => ("HTTP/1.1 200 OK".to_string(), handler(request)),
            None => ("HTTP/1.1 404 NOT FOUND".to_string(), "404 Not Found".to_string()),
        }
    }
}
```

添加了 parse_request 函数来解析 HTTP 请求并创建 Request 对象。
```rust
fn parse_request(request: &str) -> Request {
    let lines: Vec<&str> = request.lines().collect();
    let first_line = lines[0];
    let parts: Vec<&str> = first_line.split_whitespace().collect();
    
    let method = match parts[0] {
        "GET" => HttpMethod::GET,
        "POST" => HttpMethod::POST,
        "PUT" => HttpMethod::PUT,
        "DELETE" => HttpMethod::DELETE,
        _ => HttpMethod::GET, // 默认为 GET，实际应用中可能需要更好的错误处理
    };
    
    let path = parts[1].to_string();
    let body = request.split("\r\n\r\n").nth(1).unwrap_or("").to_string();

    Request { method, path, body }
}
```

> **实现更复杂的路由**
现在我们有了简单的路由能力，让我们更进一步的使我们的路由系统更加灵活。
首先，我们需要添加一个新的依赖到`Cargo.toml`

```toml
[dependencies]
regex = "1.5"
```

然后, 修改我们的 `main.rs` 文件：
```rust
use regex::Regex;

struct Request {
    method: HttpMethod,
    path: String,
    body: String,
    params: HashMap<String, String>,
}

struct Route {
    method: HttpMethod,
    pattern: Regex,
    handler: RouteHandler,
}

struct Router {
    routes: Vec<Route>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: Vec::new(),
        }
    }

    fn add_route<F>(&mut self, method: HttpMethod, pattern: &str, handler: F)
    where
        F: Fn(Request) -> Response + Send + Sync + 'static,
    {
        let pattern = format!("^{}$", pattern.replace(":param", "(?P<$1>[^/]+)"));
        let regex = Regex::new(&pattern).unwrap();
        self.routes.push(Route {
            method,
            pattern: regex,
            handler: Arc::new(handler),
        });
    }

    fn handle_request(&self, mut request: Request) -> (String, Response) {
        for route in &self.routes {
            if route.method == request.method {
                if let Some(captures) = route.pattern.captures(&request.path) {
                    for name in route.pattern.capture_names().flatten() {
                        if let Some(value) = captures.name(name) {
                            request.params.insert(name.to_string(), value.as_str().to_string());
                        }
                    }
                    return ("HTTP/1.1 200 OK".to_string(), (route.handler)(request));
                }
            }
        }
        ("HTTP/1.1 404 NOT FOUND".to_string(), "404 Not Found".to_string())
    }
}

// handle_connection 函数保持不变

fn parse_request(request: &str) -> Request {
    let lines: Vec<&str> = request.lines().collect();
    let first_line = lines[0];
    let parts: Vec<&str> = first_line.split_whitespace().collect();
    
    let method = match parts[0] {
        "GET" => HttpMethod::GET,
        "POST" => HttpMethod::POST,
        "PUT" => HttpMethod::PUT,
        "DELETE" => HttpMethod::DELETE,
        _ => HttpMethod::GET,
    };
    
    let path = parts[1].to_string();
    let body = request.split("\r\n\r\n").nth(1).unwrap_or("").to_string();

    Request { method, path, body, params: HashMap::new() }
}
```

> **工程化**
目前我们的程序已经初具规模，不能再继续拉屎了，我们需要将代码分散到不同的文件中是一个很好的做法，可以提高代码的可读性和可维护性。以下是一个建议的项目结构，适合开发成一个框架:

```
src/
├── lib.rs
├── main.rs
├── http/
│   ├── mod.rs
│   ├── method.rs
│   ├── request.rs
│   └── response.rs
├── router/
│   ├── mod.rs
│   └── route.rs
├── server/
│   ├── mod.rs
│   └── connection.rs
└── handlers/
    └── mod.rs
```

每个文件包含什么?
1. `src/lib.rs`:

```rust
pub mod http;
pub mod router;
pub mod server;
pub mod handlers;

pub use router::Router;
pub use http::{Request, Response};
```

2. `src/main.rs`:

```rust
use my_webserver_rs::{Router, http::HttpMethod, server};
use my_webserver_rs::handlers::{hello_world, get_user, create_user, update_user, delete_user};

#[tokio::main]
async fn main() {
    env_logger::init();
    let mut router = Router::new();

    router.add_route(HttpMethod::GET, "/", hello_world);
    router.add_route(HttpMethod::GET, "/users/:id", get_user);
    router.add_route(HttpMethod::POST, "/users", create_user);
    router.add_route(HttpMethod::PUT, "/users/:id", update_user);
    router.add_route(HttpMethod::DELETE, "/users/:id", delete_user);

    router.add_route(HttpMethod::GET, "/files/*path", |request| {
        format!("Accessing file: {}", request.params.get("path").unwrap_or(&"unknown".to_string()))
    });

    server::run(router, "127.0.0.1:7878").await;
}
```

3. `src/http/mod.rs`:

```rust
mod method;
mod request;
mod response;

pub use method::HttpMethod;
pub use request::Request;
pub use response::Response;
```

4. `src/http/method.rs`:

```rust
#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub enum HttpMethod {
    GET,
    POST,
    PUT,
    DELETE,
}
```

5. `src/http/request.rs`:

```rust
use std::collections::HashMap;
use super::HttpMethod;

pub struct Request {
    pub method: HttpMethod,
    pub path: String,
    pub body: String,
    pub params: HashMap<String, String>,
}

pub fn parse_request(request: &str) -> Request {
    // 实现 parse_request 函数
    // ...
}
```

6. `src/http/response.rs`:

```rust
pub type Response = String;

pub fn format_response(status_line: &str, body: &str) -> String {
    format!(
        "{}\r\nContent-Length: {}\r\n\r\n{}",
        status_line,
        body.len(),
        body
    )
}
```

7. `src/router/mod.rs`:

```rust
mod route;

use std::sync::Arc;
use route::Route;
use crate::http::{HttpMethod, Request, Response};

pub struct Router {
    routes: Vec<Route>,
}

impl Router {
    pub fn new() -> Self {
        Router {
            routes: Vec::new(),
        }
    }

    pub fn add_route<F>(&mut self, method: HttpMethod, pattern: &str, handler: F)
    where
        F: Fn(Request) -> Response + Send + Sync + 'static,
    {
        // 实现 add_route 方法
        // ...
    }

    pub fn handle_request(&self, mut request: Request) -> (String, Response) {
        // 实现 handle_request 方法
        // ...
    }
}
```

8. `src/router/route.rs`
```rust
use regex::Regex;
use std::sync::Arc;
use crate::http::{HttpMethod, Request, Response};

pub(crate) type RouteHandler = Arc<dyn Fn(Request) -> Response + Send + Sync>;

pub(crate) struct Route {
    pub method: HttpMethod,
    pub pattern: Regex,
    pub handler: RouteHandler,
}
```

9. `src/server/mod.rs`

```rust
mod connection;

use std::sync::Arc;
use tokio::net::TcpListener;
use log::{info, error};
use crate::Router;

pub async fn run(router: Router, addr: &str) {
    let router = Arc::new(router);
    let listener = TcpListener::bind(addr).await.unwrap();
    info!("Listening on {}", addr);

    loop {
        match listener.accept().await {
            Ok((stream, _)) => {
                let router = router.clone();
                tokio::spawn(async move {
                    connection::handle_connection(stream, router).await;
                });
            }
            Err(e) => {
                error!("Error accepting connection: {}", e);
            }
        }
    }
}
```

10. `src/server/connection.rs`:

```rust
use std::sync::Arc;
use tokio::net::TcpStream;
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use log::{info, error};
use crate::Router;
use crate::http::{parse_request, format_response};

pub(crate) async fn handle_connection(mut stream: TcpStream, router: Arc<Router>) {
    let mut buffer = [0; 1024];

    match stream.read(&mut buffer).await {
        Ok(_) => {
            let request_str = String::from_utf8_lossy(&buffer[..]);
            let request = parse_request(&request_str);

            info!("Received request: {:?} {}", request.method, request.path);

            let (status_line, response_body) = router.handle_request(request);
            let response = format_response(&status_line, &response_body);

            if let Err(e) = stream.write_all(response.as_bytes()).await {
                error!("Failed to write to stream: {}", e);
            }
            if let Err(e) = stream.flush().await {
                error!("Failed to flush stream: {}", e);
            }
        }
        Err(e) => {
            error!("Failed to read from stream: {}", e);
        }
    }
}
```

11. `src/handlers/mod.rs`

```rust
use crate::http::{Request, Response};

pub fn hello_world(_request: Request) -> Response {
    "Hello, World!".to_string()
}

pub fn get_user(request: Request) -> Response {
    format!("Getting user with ID: {}", request.params.get("id").unwrap_or(&"unknown".to_string()))
}

pub fn create_user(request: Request) -> Response {
    format!("Creating user: {}", request.body)
}

pub fn update_user(request: Request) -> Response {
    format!("Updating user with ID: {}, new data: {}", 
        request.params.get("id").unwrap_or(&"unknown".to_string()),
        request.body)
}

pub fn delete_user(request: Request) -> Response {
    format!("Deleting user with ID: {}", request.params.get("id").unwrap_or(&"unknown".to_string()))
}
```

这个结构将代码分成了几个主要模块：http、router、server 和 handlers。这样的组织方式使得代码更加模块化，更容易维护和扩展。

TODO 

> **安全性考虑**

虽然我们的Web服务器很简单,但在实际应用中还需要考虑许多安全性问题,例如: 

1. 输入验证: 确保请求路径不包含恶意内容
2. 资源限制: 限制请求大小, 防止 Dos 攻击
3. HTTPS支持: 加密传输数据
4. 访问控制: 实现身份验证和授权机制

这些都是构建生产级 Web 服务器需要考虑的重要方面。
