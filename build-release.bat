@echo off
REM RikkaHub 发行版本构建脚本 (Windows)
REM 用于创建v0.1.0初始发行版本

setlocal enabledelayedexpansion

set VERSION=0.1.0
set RELEASE_NAME=rikkahub-%VERSION%
set RELEASE_DIR=dist\%RELEASE_NAME%

echo =========================================
echo   RikkaHub 发行版本构建脚本 v%VERSION%
echo =========================================
echo.

REM 创建发布目录
echo [1/6] 创建发布目录...
if exist dist rmdir /s /q dist
mkdir dist
mkdir "%RELEASE_DIR%"
mkdir "%RELEASE_DIR%\bin"
mkdir "%RELEASE_DIR%\docs"
mkdir "%RELEASE_DIR%\scripts"

REM 构建release版本
echo [2/6] 构建release版本...
cargo build --release --bins
if %errorlevel% neq 0 (
    echo ✗ 构建失败
    exit /b 1
)

REM 复制二进制文件
echo [3/6] 复制二进制文件...
if exist "target\release\rikkahub.exe" (
    copy "target\release\rikkahub.exe" "%RELEASE_DIR%\bin\" >nul
    echo   ✓ 复制 rikkahub.exe (桌面客户端)
) else (
    echo   ✗ rikkahub.exe 未找到
    exit /b 1
)

if exist "target\release\rikkahub-server.exe" (
    copy "target\release\rikkahub-server.exe" "%RELEASE_DIR%\bin\" >nul
    echo   ✓ 复制 rikkahub-server.exe (后端服务器)
) else (
    echo   ✗ rikkahub-server.exe 未找到
    exit /b 1
)

REM 复制文档
echo [4/6] 复制文档...
copy README.md "%RELEASE_DIR%\docs\" >nul
copy QUICKSTART_WINDOWS.md "%RELEASE_DIR%\docs\" >nul
copy TEST_PLAN.md "%RELEASE_DIR%\docs\" >nul
copy CHANGES.md "%RELEASE_DIR%\docs\" >nul
echo   ✓ 复制文档文件

REM 复制脚本
echo [5/6] 复制构建脚本...
copy build-windows.bat "%RELEASE_DIR%\scripts\" >nul
copy run-test.bat "%RELEASE_DIR%\scripts\" >nul
echo   ✓ 复制脚本文件

REM 创建启动脚本
echo   创建启动脚本...
(
echo @echo off
echo cd /d "%%~dp0"
echo .\bin\rikkahub-server.exe
) > "%RELEASE_DIR%\start-server.bat"

(
echo @echo off
echo cd /d "%%~dp0"
echo .\bin\rikkahub.exe
) > "%RELEASE_DIR%\start-client.bat"
echo   ✓ 创建启动脚本

REM 创建VERSION.txt
echo   创建版本信息...
(
echo RikkaHub v%VERSION%
echo ================================
echo.
echo 发行日期: %date%
echo.
echo 包含组件:
echo - rikkahub.exe: 跨平台桌面AI聊天客户端
echo - rikkahub-server.exe: 后端API服务器
echo.
echo 系统要求:
echo - Windows 10/11
echo - 64位x86_64架构
echo.
echo 主要功能:
echo - 现代化深色主题UI界面
echo - 实时聊天消息显示
echo - 连接本地API服务器
echo - 响应式布局
echo.
echo 文档:
echo - docs\README.md - 项目介绍
echo - docs\QUICKSTART_WINDOWS.md - Windows快速开始
echo - docs\TEST_PLAN.md - 测试计划
echo - docs\CHANGES.md - 变更日志
echo.
echo 使用方法:
echo 1. 启动服务器: start-server.bat
echo 2. 启动客户端: start-client.bat
echo.
echo 更多信息请查看 docs\ 目录下的文档。
) > "%RELEASE_DIR%\VERSION.txt"
echo   ✓ 创建版本信息

REM 创建发布包README
(
echo # RikkaHub v%VERSION%
echo.
echo 欢迎使用 RikkaHub v%VERSION%！
echo.
echo ## 快速开始
echo.
echo 双击运行:
echo - `start-server.bat` - 启动API服务器
echo - `start-client.bat` - 启动桌面客户端
echo.
echo 或在命令行中:
echo ```batch
echo .\bin\rikkahub-server.exe
echo ```
echo.
echo 然后在新终端中:
echo ```batch
echo .\bin\rikkahub.exe
echo ```
echo.
echo ## 文档
echo.
echo 详细文档请查看 `docs\` 目录：
echo.
echo - `README.md` - 项目介绍
echo - `QUICKSTART_WINDOWS.md` - Windows快速开始指南
echo - `TEST_PLAN.md` - 测试计划和验证清单
echo - `CHANGES.md` - 版本变更日志
echo - `VERSION.txt` - 版本信息
echo.
echo ## 系统要求
echo.
echo - Windows 10/11
echo - 64位x86_64架构
echo.
echo ## 已知限制
echo.
echo 这是初始发行版本，目前功能包括：
echo.
echo ✓ 完整的UI界面
echo ✓ 连接状态显示
echo ✓ 消息显示区域
echo ⚠ 输入框和发送功能为静态展示
echo ⚠ 需要配合本地API服务器使用
echo.
echo 更多详细信息请查看文档。
echo.
echo ## 许可证
echo.
echo MIT License
echo.
echo ---
echo.
echo 构建日期: %date%
echo 版本: %VERSION%
) > "%RELEASE_DIR%\README.md"

echo [6/6] 创建发布包...
echo   发布包已创建在: %RELEASE_DIR%

echo.
echo =========================================
echo   构建完成！
echo =========================================
echo.
echo 发布目录: %RELEASE_DIR%\
echo.
echo 包含内容:
echo   - bin\rikkahub.exe         (桌面客户端)
echo   - bin\rikkahub-server.exe  (后端服务器)
echo   - docs\                    (文档目录)
echo   - scripts\                 (脚本目录)
echo   - start-server.bat         (服务器启动脚本)
echo   - start-client.bat         (客户端启动脚本)
echo   - VERSION.txt              (版本信息)
echo   - README.md                (说明文档)
echo.
echo 发布版本已准备就绪！
echo.
echo 双击 start-server.bat 启动服务器
echo 双击 start-client.bat 启动客户端
echo.

endlocal
