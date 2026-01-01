# RikkaHub v0.1.0 发行说明

## 概述

欢迎使用 RikkaHub v0.1.0！这是 RikkaHub 项目的第一个发行版本。

RikkaHub 是一个跨平台的高性能 AI 聊天客户端，使用 Rust 和 GPUI 框架构建，提供现代化的用户界面和流畅的用户体验。

## 发行日期

2025-01-01

## 版本信息

- **版本号**: 0.1.0
- **代码名**: release-initial
- **状态**: 初始发行版本 (Alpha)

## 主要特性

### ✨ 核心功能

#### 1. 桌面客户端 (rikkahub)
- **现代化 UI 界面**
  - 基于 GPUI 0.2.2 和 gpui-component 0.5.0
  - Catppuccin Mocha 深色主题
  - 响应式布局，支持窗口调整大小

- **界面组件**
  - 标题栏：显示应用名称和版本信息
  - 工具栏：显示当前 AI 模型和连接状态
  - 消息区：聊天消息显示区域，支持滚动
  - 输入区：文本输入框和发送按钮
  - 欢迎界面：空状态时的友好提示

#### 2. 后端服务器 (rikkahub-server)
- **API 服务**
  - 基于 Axum 0.8 框架
  - RESTful API 设计
  - 支持聊天消息处理
  - 模型和会话管理

- **功能特性**
  - 结构化日志输出
  - CORS 跨域支持
  - GZIP 压缩
  - 可配置的主机和端口

### 📦 技术栈

- **语言**: Rust 2024 Edition
- **异步运行时**: Tokio
- **日志**: tracing & tracing-subscriber
- **序列化**: serde & serde_json
- **HTTP**: reqwest (客户端), axum + tower (服务端)
- **UI**: GPUI 0.2.2, gpui-component 0.5.0

## 系统要求

### 最低要求
- **操作系统**:
  - Windows 10/11 (64位)
  - Linux (64位，支持 X11 或 Wayland)
  - macOS 11+ (64位)
- **架构**: x86_64
- **内存**: 4GB RAM (推荐 8GB+)
- **磁盘空间**: 500MB 可用空间

### 软件依赖
- 现代图形驱动程序
- 网络连接（用于 API 通信）

## 安装方法

### 方法 1: 使用预编译二进制文件

1. 下载对应平台的发布包
2. 解压到任意目录
3. 运行启动脚本：
   - **Windows**: 双击 `start-server.bat` 和 `start-client.bat`
   - **Linux/macOS**: 运行 `./start-server.sh` 和 `./start-client.sh`

### 方法 2: 从源码构建

```bash
# 克隆仓库
git clone https://github.com/yourusername/rikkahub.git
cd rikkahub

# 切换到发布版本
git checkout v0.1.0

# 构建 release 版本
cargo build --release

# 运行
./target/release/rikkahub-server    # 服务器
./target/release/rikkahub          # 客户端
```

## 快速开始

### 1. 启动后端服务器

```bash
# 方法 A: 使用启动脚本
./start-server.sh   # Linux/macOS
start-server.bat    # Windows

# 方法 B: 直接运行二进制文件
./bin/rikkahub-server
.\bin\rikkahub-server.exe
```

服务器默认监听 `http://localhost:3000`

### 2. 启动桌面客户端

```bash
# 方法 A: 使用启动脚本
./start-client.sh   # Linux/macOS
start-client.bat    # Windows

# 方法 B: 直接运行二进制文件
./bin/rikkahub
.\bin\rikkahub.exe
```

### 3. 开始使用

1. 客户端启动后会显示欢迎界面
2. 工具栏显示连接状态（应为"已连接"）
3. 当前版本为 UI 展示版本，支持查看界面布局和组件

## 已知限制

这是初始发行版本，以下功能尚未完全实现：

### ⚠️ 当前限制

1. **输入功能**
   - 文本输入框为静态展示
   - 暂不支持键盘输入
   - 发送按钮未绑定事件

2. **API 集成**
   - 未实现与后端服务器的实际通信
   - 消息发送和接收功能待开发

3. **功能缺失**
   - 模型选择功能未实现
   - 会话管理未实现
   - 消息历史记录未持久化
   - 配置面板未实现

4. **用户体验**
   - 无错误提示和通知
   - 无加载状态动画
   - 不支持快捷键

## 后续计划

### 短期目标 (v0.2.0)
- [ ] 实现真实的文本输入组件
- [ ] 添加按钮点击事件处理
- [ ] 集成异步 API 调用
- [ ] 实现消息发送和接收
- [ ] 添加加载状态动画

### 中期目标 (v0.3.0 - v0.4.0)
- [ ] 添加模型选择下拉菜单
- [ ] 实现会话管理功能
- [ ] 添加消息持久化存储
- [ ] 优化性能和内存使用
- [ ] 添加更多 UI 组件和交互

### 长期目标 (v1.0.0)
- [ ] 完整的配置面板
- [ ] 主题切换功能
- [ ] 快捷键支持
- [ ] 消息搜索功能
- [ ] 导出对话历史
- [ ] 多语言支持
- [ ] 跨平台安装程序

## 文档

详细文档包含在发布包中：

- **README.md** - 项目介绍和概览
- **QUICKSTART_WINDOWS.md** - Windows 平台快速开始指南
- **TEST_PLAN.md** - 详细的测试计划和验证清单
- **CHANGES.md** - 完整的变更日志
- **VERSION.txt** - 版本信息和系统要求

## 测试

参考 `TEST_PLAN.md` 文件了解详细的测试方法和验证清单。

## 故障排除

### 常见问题

**Q: 客户端无法连接到服务器**
A:
- 确认服务器已启动
- 检查端口 3000 是否被占用
- 查看终端日志获取错误信息

**Q: 窗口无法显示**
A:
- 确保安装了必要的图形驱动
- 检查系统兼容性
- Linux 用户确保安装了 X11/Wayland 依赖

**Q: 编译错误**
A:
- 更新 Rust 工具链: `rustup update`
- 清理构建缓存: `cargo clean`
- 检查依赖项版本

## 反馈和贡献

我们欢迎您的反馈和建议！

- **问题报告**: [GitHub Issues](https://github.com/yourusername/rikkahub/issues)
- **功能请求**: [GitHub Discussions](https://github.com/yourusername/rikkahub/discussions)
- **贡献**: [Pull Requests](https://github.com/yourusername/rikkahub/pulls)

## 许可证

MIT License - 详见 LICENSE 文件

## 致谢

感谢以下开源项目：

- [GPUI](https://github.com/zed-industries/zed) - UI 框架
- [gpui-component](https://github.com/longbridgeapp/gpui-component) - 组件库
- [Axum](https://github.com/tokio-rs/axum) - Web 框架
- [Tokio](https://github.com/tokio-rs/tokio) - 异步运行时

---

**RikkaHub v0.1.0 - 初始发行版本**

*构建您的 AI 对话体验*
