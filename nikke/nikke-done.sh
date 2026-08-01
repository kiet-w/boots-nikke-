#!/bin/bash
# === Chạy SAU KHI CHƠI NIKKE XONG ===
# Khôi phục hệ thống về trạng thái tiết kiệm điện

echo "🔄 Khôi phục hệ thống sau khi chơi game..."

# Dọn sạch Wine/NIKKE
pkill -9 -f tbs_browser 2>/dev/null
pkill -9 -f nikke 2>/dev/null
pkill -9 -f wineserver 2>/dev/null
pkill -9 -f UnityCrashHandler 2>/dev/null
echo "✅ Đã dọn sạch tiến trình NIKKE"

# CPU về powersave
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo powersave | sudo tee "$cpu" > /dev/null 2>&1
done
echo "✅ CPU → Powersave (tiết kiệm pin)"

# Khởi động lại headroom
systemctl --user start headroom-default.service 2>/dev/null
echo "✅ Headroom restarted"

echo ""
free -h | head -2
echo ""
echo "✅ Xong! Hệ thống đã về chế độ bình thường."
