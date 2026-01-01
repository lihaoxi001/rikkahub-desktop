@echo off
chcp 65001 >nul
echo ========================================
echo RikkaHub Windows 测试界面 - 启动脚本
echo ========================================
echo.

REM 检查可执行文件是否存在
if not exist "target\release\rikkahub.exe" (
    echo ⚠️  Release 版本未找到
    echo 是否现在构建? (Y/N)
    set /p build_choice=
    if /i "%build_choice%"=="Y" (
        echo.
        echo 正在构建...
        call build-windows.bat
        if %errorlevel% neq 0 (
            pause
            exit /b 1
        )
    ) else (
        echo.
        echo 尝试使用 Debug 版本...
        if not exist "target\debug\rikkahub.exe" (
            echo ❌ 未找到可执行文件
            echo 请先运行: cargo build --release
            pause
            exit /b 1
        )
        set "exe_path=target\debug\rikkahub.exe"
    )
)

if "%exe_path%"=="" (
    set "exe_path=target\release\rikkahub.exe"
)

echo.
echo 启动前检查...
echo.

REM 检查端口3000是否被占用
netstat -ano | findstr ":3000" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 检测到端口 3000 已被占用
    echo    假设 API 服务器正在运行
) else (
    echo ⚠️  警告: 端口 3000 似乎未被占用
    echo    请确保 API 服务器已启动:
    echo    cargo run --bin rikkahub-server
    echo.
    echo    仍然继续? (Y/N)
    set /p continue_choice=
    if /i not "%continue_choice%"=="Y" (
        pause
        exit /b 0
    )
)

echo.
echo ========================================
echo 启动应用程序...
echo ========================================
echo.
echo 可执行文件: %exe_path%
echo API 地址: http://localhost:3000
echo.
echo ========================================
echo.

REM 启动应用程序
"%exe_path%"

if %errorlevel% neq 0 (
    echo.
    echo ❌ 应用程序异常退出 (错误代码: %errorlevel%)
    pause
) else (
    echo.
    echo 应用程序正常退出
)
