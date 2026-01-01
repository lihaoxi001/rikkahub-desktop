@echo off
chcp 65001 >nul
echo ========================================
echo RikkaHub Windows 测试界面 - 构建脚本
echo ========================================
echo.

echo [1/3] 检查 Rust 环境...
where rustc >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: 未找到 Rust 环境
    echo 请先安装 Rust: https://rustup.rs/
    pause
    exit /b 1
)
echo ✅ Rust 环境正常

echo.
echo [2/3] 清理旧的构建文件...
cargo clean
if %errorlevel% neq 0 (
    echo ❌ 清理失败
    pause
    exit /b 1
)
echo ✅ 清理完成

echo.
echo [3/3] 开始构建 Release 版本...
cargo build --release --bin rikkahub
if %errorlevel% neq 0 (
    echo ❌ 构建失败
    echo 请检查上面的错误信息
    pause
    exit /b 1
)
echo ✅ 构建成功!

echo.
echo ========================================
echo 构建完成！
echo ========================================
echo.
echo 可执行文件位置:
echo %CD%\target\release\rikkahub.exe
echo.
echo 运行前请确保:
echo 1. API 服务器已启动 (cargo run --bin rikkahub-server)
echo 2. 服务器运行在 http://localhost:3000
echo.
echo 运行命令:
echo %CD%\target\release\rikkahub.exe
echo.
pause
