# Windows 平台快速开始指南

本指南帮助你在 Windows 平台上快速运行 RikkaHub 测试界面。

## 前置条件

1. **安装 Rust** (如果尚未安装)
   ```powershell
   # 下载并运行 rustup-init.exe
   # 访问: https://rustup.rs/
   ```
   验证安装:
   ```powershell
   rustc --version
   cargo --version
   ```

2. **安装 Visual Studio Build Tools**
   - 下载: https://visualstudio.microsoft.com/downloads/
   - 选择 "Build Tools for Visual Studio"
   - 安装 "C++ 构建工具" 和 "Windows SDK"

## 快速启动 (三步走)

### 第一步: 启动 API 服务器

打开第一个 PowerShell 或 CMD 窗口:

```bash
cd /path/to/rikkahub
cargo run --bin rikkahub-server
```

看到以下输出表示成功:
```
INFO rikkahub_server: 启动 RikkaHub Server
INFO rikkahub_server: 服务器运行在 http://0.0.0.0:3000
```

### 第二步: 构建桌面客户端

打开第二个 PowerShell 或 CMD 窗口:

```bash
cd /path/to/rikkahub

# 方式1: 使用构建脚本 (推荐)
.\build-windows.bat

# 方式2: 直接使用 cargo
cargo build --release --bin rikkahub
```

### 第三步: 运行测试界面

```bash
# 方式1: 使用运行脚本 (推荐)
.\run-test.bat

# 方式2: 直接运行
.\target\release\rikkahub.exe
```

## 界面预览

运行成功后，你会看到一个桌面窗口，包含:

- **顶部标题栏**: "RikkaHub Desktop - 测试界面 | Windows 测试版本"
- **工具栏**: 显示当前模型和连接状态
- **中间消息区**: 聊天消息显示区域
- **底部输入区**: 文本输入框和发送按钮

## 测试功能

### 1. 查看连接状态
- 工具栏右侧显示 "● 已连接" (绿色) 或 "● 连接中..." (黄色)

### 2. 界面元素测试
- 查看标题栏文字
- 检查模型标签 (默认: gpt-3.5-turbo)
- 阅读欢迎提示信息
- 查看输入框占位符文本

### 3. 窗口操作
- 尝试调整窗口大小
- 测试滚动消息区域
- 查看按钮状态变化

## 常见问题

### Q1: 编译时出现 "linking with `link.exe` failed"
**解决方案**:
- 安装 Visual Studio Build Tools
- 确保安装了 C++ 组件和 Windows SDK
- 在 "x64 Native Tools Command Prompt for VS 2022" 中运行

### Q2: 运行时窗口无法显示或闪退
**解决方案**:
- 检查是否安装了最新的显卡驱动
- 尝试以管理员权限运行
- 查看终端输出的错误信息
- 确保安装了 DirectX 和 Visual C++ 运行时

### Q3: 提示端口被占用
**解决方案**:
```bash
# 查找占用端口3000的进程
netstat -ano | findstr :3000

# 结束进程 (替换 PID)
taskkill /PID <进程ID> /F

# 或者修改客户端连接地址 (需要修改代码)
```

### Q4: Cargo 非常慢或卡住
**解决方案**:
```bash
# 使用国内镜像源
# 在 %USERPROFILE%\.cargo\config 中添加:
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
```

## 开发模式

如果想快速迭代开发，使用 Debug 模式:

```bash
# 终端1: 启动服务器
cargo run --bin rikkahub-server

# 终端2: 运行客户端 (更快编译)
cargo run --bin rikkahub
```

## 日志调试

查看详细日志:

```bash
# 设置日志级别
set RUST_LOG=debug

# 运行应用
cargo run --bin rikkahub
```

## 性能优化

发布版本的性能更好:
- Debug: ~50MB 文件，启动慢
- Release: ~8MB 文件，启动快，内存占用低

## 下一步

查看完整文档:
- `README.md` - 项目总览和详细说明
- 代码注释 - 了解实现细节

## 技术支持

遇到问题？
1. 检查 Rust 版本: `rustc --version` (需要 1.75+)
2. 清理并重新构建: `cargo clean && cargo build --release`
3. 查看错误日志并搜索解决方案
4. 在项目 Issues 中提问

---

**提示**: 这是测试界面，目前仅用于UI展示和基本功能验证。完整功能正在开发中！
