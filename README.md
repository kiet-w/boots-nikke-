# 🎮 boots-nikke — NIKKE Linux Boot Scripts

> **Goddess of Victory: NIKKE** — Complete Linux setup with Gamescope Virtual Desktop (Lossless Scaling alternative)

**System tested on:** Debian forky/sid · Intel i5-1035G1 · Intel Iris Plus G1 · X11

---

## 📁 Files

| File | Mô tả |
|------|-------|
| `nikke-gamescope.sh` | ⭐ **Script chính** — Chạy NIKKE trong Gamescope Virtual Desktop (FSR upscale) |
| `nikke-perf.sh` | Tối ưu CPU + DXVK, launch qua Lutris |
| `nikke-done.sh` | Cleanup sau khi chơi xong (CPU powersave, kill processes) |
| `nikke_lotery.sh` | Anti-cheat lottery — thử launch nhiều lần để bypass GameGuard race condition |
| `dxvk.conf` | DXVK config (async, tearFree off) |
| `nikke-lutris.yml` | Lutris installer script (Wine + DXVK + VKD3D) |

---

## 🚀 Quick Start

### Cách 1 — Gamescope Virtual Desktop (khuyên dùng)
```bash
bash ~/nikke-gamescope.sh
```
Gamescope tạo virtual display `1280×720`, upscale FSR lên màn hình thật `1600×900`.  
Lottery tự động bypass anti-cheat, không cần làm thêm gì.

### Cách 2 — Lutris + Performance mode
```bash
bash ~/nikke-perf.sh
```

### Sau khi chơi xong
```bash
bash ~/nikke-done.sh
```

---

## ⚙️ Setup yêu cầu

1. **Steam** phải được cài (anti-cheat cần Steam để init)
2. **ProtonGE** ≥ 10-25 — cài qua [ProtonPlus](https://github.com/nicowillis/protonplus)
3. **Lutris** (Flatpak) — `flatpak install flathub net.lutris.Lutris`
4. **NIKKE** đã được thêm vào Steam dưới dạng Non-Steam Game theo [hướng dẫn gốc](https://github.com/koleq/NikkeLinux)
5. **Sửa `APP_ID`** trong `nikke_lotery.sh` và `nikke-gamescope.sh` theo đúng ID của bạn

---

## 🔧 Gamescope Configuration

Chỉnh trong `nikke-gamescope.sh`:

```bash
GAME_W=1280        # Độ phân giải game bên trong virtual display
GAME_H=720
OUTPUT_W=1600      # Độ phân giải màn hình thật
OUTPUT_H=900
FSR_SHARPNESS=5    # 0 = sắc nét / 20 = mượt
LOTTERY_WAIT=10    # Giây chờ mỗi lần lottery (tăng nếu PC chậm)
MAX_ATTEMPTS=8
```

**Upscale filters:**
- `fsr` — AMD FSR 1.0 (tốt nhất cho Intel GPU) ✅
- `nis` — NVIDIA Image Scaling
- `linear` — đơn giản, không artifact
- `nearest` — pixel perfect

---

## 🔍 Troubleshooting

| Lỗi | Fix |
|-----|-----|
| SDL backend failed | Đổi `--backend sdl` → `--backend xwayland` |
| Game không mở | Tăng `LOTTERY_WAIT=15` |
| Màn hình đen | Thêm `--nested-refresh 60` vào lệnh gamescope |
| Stuck 0% update | Dùng `NikkeMiniloader` làm target Steam thay vì launcher |

---

## 📖 Credits

- Anti-cheat lottery method: **koleq** ([NikkeLinux](https://github.com/koleq/NikkeLinux))
- Gamescope integration: **Antigravity AI**
- DXVK async config: community
