#!/bin/bash
# RikkaHub 发行版本构建脚本
# 用于创建v0.1.0初始发行版本

set -e

VERSION="0.1.0"
RELEASE_NAME="rikkahub-${VERSION}"
RELEASE_DIR="dist/${RELEASE_NAME}"

echo "========================================="
echo "  RikkaHub 发行版本构建脚本 v${VERSION}"
echo "========================================="
echo ""

# 创建发布目录
echo "📦 创建发布目录..."
rm -rf dist
mkdir -p "${RELEASE_DIR}"
mkdir -p "${RELEASE_DIR}/bin"
mkdir -p "${RELEASE_DIR}/docs"
mkdir -p "${RELEASE_DIR}/scripts"

# 构建release版本
echo "🔨 构建release版本..."
cargo build --release --bins

# 复制二进制文件
echo "📋 复制二进制文件..."
if [ -f "target/release/rikkahub" ]; then
    cp target/release/rikkahub "${RELEASE_DIR}/bin/"
    echo "  ✓ 复制 rikkahub (桌面客户端)"
else
    echo "  ✗ rikkahub 二进制文件未找到"
    exit 1
fi

if [ -f "target/release/rikkahub-server" ]; then
    cp target/release/rikkahub-server "${RELEASE_DIR}/bin/"
    echo "  ✓ 复制 rikkahub-server (后端服务器)"
else
    echo "  ✗ rikkahub-server 二进制文件未找到"
    exit 1
fi

# 复制文档
echo "📚 复制文档..."
cp README.md "${RELEASE_DIR}/docs/"
cp QUICKSTART_WINDOWS.md "${RELEASE_DIR}/docs/"
cp TEST_PLAN.md "${RELEASE_DIR}/docs/"
cp CHANGES.md "${RELEASE_DIR}/docs/"
echo "  ✓ 复制文档文件"

# 复制脚本
echo "📜 复制构建脚本..."
cp build-windows.bat "${RELEASE_DIR}/scripts/"
cp run-test.bat "${RELEASE_DIR}/scripts/"
echo "  ✓ 复制脚本文件"

# 创建版本信息
echo "📝 创建版本信息..."
cat > "${RELEASE_DIR}/VERSION.txt" << EOF
RikkaHub v${VERSION}
================

发行日期: $(date +%Y-%m-%d)

包含组件:
- rikkahub: 跨平台桌面AI聊天客户端
- rikkahub-server: 后端API服务器

系统要求:
- Linux/macOS: 支持Rust 1.75+的系统
- 64位x86_64架构

主要功能:
- 现代化深色主题UI界面
- 实时聊天消息显示
- 连接本地API服务器
- 响应式布局

文档:
- docs/README.md - 项目介绍
- docs/QUICKSTART_WINDOWS.md - Windows快速开始
- docs/TEST_PLAN.md - 测试计划
- docs/CHANGES.md - 变更日志

使用方法:
1. 启动服务器: ./bin/rikkahub-server
2. 启动客户端: ./bin/rikkahub

更多信息请查看 docs/ 目录下的文档。
EOF
echo "  ✓ 创建版本信息"

# 创建README
cat > "${RELEASE_DIR}/README.md" << EOF
# RikkaHub v${VERSION}

欢迎使用 RikkaHub v${VERSION}！

## 快速开始

\`\`\`bash
# 启动服务器
./bin/rikkahub-server

# 在另一个终端启动客户端
./bin/rikkahub
\`\`\`

## 文档

详细文档请查看 \`docs/\` 目录：

- \`README.md\` - 项目介绍
- \`QUICKSTART_WINDOWS.md\` - Windows快速开始指南
- \`TEST_PLAN.md\` - 测试计划和验证清单
- \`CHANGES.md\` - 版本变更日志
- \`VERSION.txt\` - 版本信息

## 系统要求

- Linux或macOS操作系统
- 64位x86_64架构
- 支持显示图形界面

## 已知限制

这是初始发行版本，目前功能包括：

✓ 完整的UI界面
✓ 连接状态显示
✓ 消息显示区域
⚠ 输入框和发送功能为静态展示
⚠ 需要配合本地API服务器使用

更多详细信息请查看文档。

## 许可证

MIT License

---

构建日期: $(date +%Y-%m-%d)
版本: ${VERSION}
EOF

echo "  ✓ 创建README"

# 创建启动脚本
cat > "${RELEASE_DIR}/start-server.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
./bin/rikkahub-server
EOF
chmod +x "${RELEASE_DIR}/start-server.sh"

cat > "${RELEASE_DIR}/start-client.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
./bin/rikkahub
EOF
chmod +x "${RELEASE_DIR}/start-client.sh"
echo "  ✓ 创建启动脚本"

# 设置二进制文件可执行权限
chmod +x "${RELEASE_DIR}/bin/rikkahub"
chmod +x "${RELEASE_DIR}/bin/rikkahub-server"
echo "  ✓ 设置可执行权限"

# 创建压缩包
echo "📦 创建发布压缩包..."
cd dist
tar -czf "${RELEASE_NAME}.tar.gz" "${RELEASE_NAME}"
cd ..
echo "  ✓ 创建 dist/${RELEASE_NAME}.tar.gz"

# 显示文件大小
echo ""
echo "========================================="
echo "  构建完成！"
echo "========================================="
echo ""
echo "📁 发布目录: ${RELEASE_DIR}/"
echo "📦 压缩包: dist/${RELEASE_NAME}.tar.gz"
echo ""
echo "文件大小:"
du -sh "${RELEASE_DIR}" | awk '{print "  " $1 "  (目录)"}'
du -sh "dist/${RELEASE_NAME}.tar.gz" | awk '{print "  " $1 "  (压缩包)"}'
echo ""
echo "包含内容:"
echo "  - bin/rikkahub           ($(stat -f%z "${RELEASE_DIR}/bin/rikkahub" 2>/dev/null || stat -c%s "${RELEASE_DIR}/bin/rikkahub" 2>/dev/null | awk '{print int($1/1024/1024)}')MB)"
echo "  - bin/rikkahub-server    ($(stat -f%z "${RELEASE_DIR}/bin/rikkahub-server" 2>/dev/null || stat -c%s "${RELEASE_DIR}/bin/rikkahub-server" 2>/dev/null | awk '{print int($1/1024/1024)}')MB)"
echo "  - docs/                  (文档目录)"
echo "  - scripts/               (脚本目录)"
echo "  - start-server.sh        (服务器启动脚本)"
echo "  - start-client.sh        (客户端启动脚本)"
echo ""
echo "发布版本已准备就绪！"
