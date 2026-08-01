# 🎮 BD2 — Brown Dust 2 Linux Scripts

> **Brown Dust 2** tối ưu trên Linux · Intel Iris Plus G1 · Lutris

---

## 📁 Files

| File | Mô tả |
|------|-------|
| `bd2-perf.sh` | Tối ưu CPU/GPU/RAM trước khi chơi BD2 |
| `bd2-launch.sh` | Launch BD2 qua Lutris |

---

## 🚀 Cách dùng

```bash
# Bước 1: Tối ưu hệ thống
bash ~/boots-nikke/bd2/bd2-perf.sh

# Bước 2: Launch BD2
bash ~/boots-nikke/bd2/bd2-launch.sh
```

---

## ⚙️ bd2-perf.sh làm gì?

| Tối ưu | Chi tiết |
|--------|---------|
| 🧠 CPU | Governor → `performance` |
| 🎮 GPU | Intel Iris Plus: khóa 1050 MHz (không cho giảm xung) |
| 💾 RAM | Drop cache, swappiness=1 |
| 🪟 Compositor | Tắt XFCE compositor (giảm overhead) |
| ⚡ DXVK | Async ON, FSR ON (`WINE_FULLSCREEN_FSR=1`) |
| 🔧 Kernel | split_lock=off, compaction=off |

---

## 📝 Settings trong game

- **Chế độ hiển thị**: Fullscreen
- **Độ phân giải**: 1280×720 hoặc 1600×900
- **Đồ họa**: Low hoặc Medium
- **V-Sync**: TẮT
- **Skill Animation**: Low hoặc Off

---

## 🔧 Troubleshooting

| Lỗi | Fix |
|-----|-----|
| FPS thấp | Chạy `bd2-perf.sh` trước khi mở game |
| GPU không lên 1050MHz | `sudo` cần password, kiểm tra `/sys/class/drm/card0/` |
| Lutris không nhận slug `bd2` | Mở Lutris → chuột phải game → "Create desktop shortcut" để lấy slug |
