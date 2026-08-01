#!/bin/bash
# === NIKKE Ultimate Performance Launch Script ===
# Chạy: bash ~/nikke-perf.sh

echo "🎮 NIKKE Performance Mode v4 — Tối ưu toàn diện"
echo "================================================"

# 1. Dọn RAM cache
echo "[1/5] Dọn RAM cache..."
sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches' 2>/dev/null

# 2. CPU performance
echo "[2/5] CPU → Performance mode..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance | sudo tee "$cpu" > /dev/null 2>&1
done

# 3. Tắt services nặng tạm thời & dọn tiến trình cũ
echo "[3/5] Dọn dẹp tiến trình rác..."
pkill -f headroom 2>/dev/null
systemctl --user stop headroom-default.service 2>/dev/null
pkill -9 -f tbs_browser 2>/dev/null
pkill -9 -f UnityCrashHandler 2>/dev/null
pkill -9 -f wineserver 2>/dev/null

# 4. Tối ưu Intel GPU & DXVK
echo "[4/5] Kích hoạt tối ưu Intel GPU & Wine..."
export mesa_glthread=true
export vblank_mode=0
export MESA_LOADER_DRIVER_OVERRIDE=iris
export __GL_THREADED_OPTIMIZATION=1
export DXVK_ASYNC=1
export WINE_LARGE_ADDRESS_AWARE=1
export STAGING_SHARED_MEMORY=1
export STAGING_WRITECOPY=1
export DXVK_CONFIG_FILE="/home/baudui/Games/nikke/dxvk.conf"

# 5. Background Auto-Killer Guard
(
    for i in $(seq 1 90); do
        if pgrep -f "nikke.exe" > /dev/null 2>&1; then
            sleep 15
            pkill -9 -f "tbs_browser" 2>/dev/null
            pkill -9 -f "nikke_launcher.exe" 2>/dev/null
            pkill -9 -f "UnityCrashHandler" 2>/dev/null
            sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches' 2>/dev/null
            break
        fi
        sleep 2
    done
) &

echo "[5/5] Sẵn sàng! Chạy game qua Lutris..."
echo "================================================"
flatpak run net.lutris.Lutris lutris:rungameid/1
