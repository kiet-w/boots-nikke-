#!/bin/bash
# ============================================================
#  NIKKE + Gamescope Virtual Desktop
#  → Thay thế Lossless Scaling trên Linux
#  → Gamescope tạo virtual display riêng, upscale FSR lên màn hình thật
#
#  Dùng: bash ~/nikke-gamescope.sh
# ============================================================

# ── Cấu hình ─────────────────────────────────────────────────
APP_ID=16270348604281978880   # Steam AppID của NIKKE (nikke_lotery.sh)

GAME_W=1280                   # Độ phân giải game bên trong (nhẹ hơn)
GAME_H=720
OUTPUT_W=1600                 # Màn hình thật của bạn
OUTPUT_H=900

FSR_SHARPNESS=5               # 0 = sắc nét nhất / 20 = mượt nhất
LOTTERY_WAIT=10               # Giây chờ mỗi lần thử (tăng nếu PC chậm)
MAX_ATTEMPTS=8

# ── Banner ───────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  🎮 NIKKE · Gamescope Virtual Desktop v2     ║"
echo "║  Virtual: ${GAME_W}x${GAME_H} → Output: ${OUTPUT_W}x${OUTPUT_H}        ║"
echo "║  Upscale: FSR (sharpness=$FSR_SHARPNESS)                  ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ── Bước 1: CPU Performance ──────────────────────────────────
echo "[1/4] CPU → Performance mode..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance | sudo tee "$cpu" > /dev/null 2>&1
done

# ── Bước 2: Dọn dẹp ─────────────────────────────────────────
echo "[2/4] Dọn RAM & tiến trình cũ..."
sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches' 2>/dev/null
pkill -f headroom 2>/dev/null
systemctl --user stop headroom-default.service 2>/dev/null
pkill -9 -f tbs_browser 2>/dev/null
pkill -9 -f UnityCrashHandler 2>/dev/null
pkill -9 -f wineserver 2>/dev/null
pkill -9 -f "NIKKE" 2>/dev/null
sleep 1

# ── Bước 3: Env vars ────────────────────────────────────────
echo "[3/4] Thiết lập môi trường..."
export DXVK_ASYNC=1
export DXVK_CONFIG_FILE="/home/baudui/Games/nikke/dxvk.conf"
export WINE_LARGE_ADDRESS_AWARE=1
export mesa_glthread=true
export vblank_mode=0
export MESA_LOADER_DRIVER_OVERRIDE=iris

# ── Bước 4: Gamescope qua Lutris flatpak ────────────────────
echo "[4/4] Khởi động Gamescope Virtual Desktop..."
echo "      (Lottery sẽ thử tự động cho đến khi Nikke mở)"
echo ""

# Export biến để dùng trong subshell
export _NIKKE_APP_ID="$APP_ID"
export _NIKKE_WAIT="$LOTTERY_WAIT"
export _NIKKE_MAX="$MAX_ATTEMPTS"

flatpak run \
    --command=/usr/lib/extensions/vulkan/gamescope/bin/gamescope \
    --env=DXVK_ASYNC=1 \
    --env=DXVK_CONFIG_FILE=/home/baudui/Games/nikke/dxvk.conf \
    --env=WINE_LARGE_ADDRESS_AWARE=1 \
    --env=mesa_glthread=true \
    --env=vblank_mode=0 \
    --env=MESA_LOADER_DRIVER_OVERRIDE=iris \
    net.lutris.Lutris \
    --output-width "$OUTPUT_W" \
    --output-height "$OUTPUT_H" \
    --nested-width "$GAME_W" \
    --nested-height "$GAME_H" \
    --filter fsr \
    --sharpness "$FSR_SHARPNESS" \
    --fullscreen \
    --backend sdl \
    -- bash -c '
        APP_ID="'"$APP_ID"'"
        WAIT="'"$LOTTERY_WAIT"'"
        MAX="'"$MAX_ATTEMPTS"'"
        ATTEMPT=1

        while true; do
            echo "  ── Lottery Attempt #$ATTEMPT ──"
            pkill -9 -f "NIKKE" 2>/dev/null
            steam "steam://rungameid/$APP_ID" &
            sleep "$WAIT"

            P_COUNT=$(pgrep -cf "NIKKE")
            echo "  Processes found: $P_COUNT"

            if [ "$P_COUNT" -gt 9 ]; then
                echo "  ✅ SUCCESS! Nikke launcher opened (attempt $ATTEMPT)"
                wait
                break
            elif [ "$ATTEMPT" -ge "$MAX" ]; then
                echo "  ❌ Max attempts ($MAX) reached. Check Steam/Nikke manually."
                break
            else
                echo "  ⏳ Stalled, retrying..."
                ((ATTEMPT++))
            fi
        done
    '

# ── Cleanup ──────────────────────────────────────────────────
echo ""
echo "🔄 Gamescope đóng. Khôi phục hệ thống..."
pkill -9 -f "NIKKE" 2>/dev/null
pkill -9 -f wineserver 2>/dev/null
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo powersave | sudo tee "$cpu" > /dev/null 2>&1
done
systemctl --user start headroom-default.service 2>/dev/null
echo "✅ Xong! CPU → Powersave."
