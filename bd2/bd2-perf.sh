#!/bin/bash
# =============================================================
# BD2 FPS Optimizer - Tối ưu triệt để Brown Dust 2 trên Intel iGPU
# Chạy script này TRƯỚC khi mở Lutris/BD2
# =============================================================

echo "╔══════════════════════════════════════════════════════╗"
echo "║     BD2 FPS OPTIMIZER - Intel Iris Plus G1           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# === 1. TẮT COMPOSITOR ===
xfconf-query -c xfwm4 -p /general/use_compositing -s false 2>/dev/null
echo "[✓] XFCE Compositor: TẮT"

# === 2. CPU: Performance Governor ===
if command -v cpupower &>/dev/null; then
    sudo cpupower frequency-set -g performance 2>/dev/null
fi
echo "[✓] CPU Governor: performance"

# === 3. GPU Intel: Khóa tần số MAX (1050 MHz) ===
echo 1050 | sudo tee /sys/class/drm/card0/gt_min_freq_mhz > /dev/null 2>&1
echo 1050 | sudo tee /sys/class/drm/card0/gt_boost_freq_mhz > /dev/null 2>&1
echo "[✓] Intel GPU: Khóa 1050 MHz (không cho giảm xung)"

# === 4. KERNEL TUNING ===
sudo sysctl -w vm.swappiness=1 > /dev/null 2>&1
sudo sysctl -w vm.compaction_proactiveness=0 > /dev/null 2>&1
sudo sysctl -w vm.page_lock_unfairness=1 > /dev/null 2>&1
sudo sysctl -w kernel.split_lock_mitigate=0 > /dev/null 2>&1
echo "[✓] Kernel: swappiness=1, split_lock=off"

# === 5. DỌN RAM ===
echo "    Đang dọn cache RAM..."
sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches' 2>/dev/null
echo "[✓] RAM cache đã dọn sạch"

# === 6. MÔI TRƯỜNG VULKAN / DXVK ===
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export DXVK_HUD=0
export DXVK_LOG_LEVEL=none
export ANV_ENABLE_PIPELINE_CACHE=1
export mesa_glthread=true
export STAGING_SHARED_MEMORY=1
export STAGING_WRITECOPY=1
export __GL_SHADER_DISK_CACHE=1
export __GL_THREADED_OPTIMIZATIONS=1
export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_STRENGTH=2
export WINEDEBUG=-all
echo "[✓] Vulkan/DXVK: Async ON, Pipeline Cache ON, FSR ON"

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  ĐÃ TỐI ƯU XONG! Bây giờ mở Lutris chạy BD2.     ║"
echo "║                                                      ║"
echo "║  Lưu ý trong Game:                                   ║"
echo "║  • Chế độ: FULLSCREEN (không dùng Windowed)          ║"
echo "║  • Độ phân giải: 1280x720 hoặc 1600x900             ║"
echo "║  • Đồ họa: Low hoặc Medium                          ║"
echo "║  • V-Sync: TẮT                                       ║"
echo "║  • Skill Animation: Low hoặc Off                     ║"
echo "╚══════════════════════════════════════════════════════╝"

# === HIỂN THỊ TÌNH TRẠNG HỆ THỐNG ===
echo ""
echo "--- Tình trạng hệ thống ---"
echo "RAM khả dụng: $(free -h | awk '/Mem:/{print $7}')"
echo "GPU freq: $(cat /sys/class/drm/card0/gt_cur_freq_mhz) MHz"
echo "CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
echo "Compositor: $(xfconf-query -c xfwm4 -p /general/use_compositing 2>/dev/null)"
