# 🎮 NIKKE — Goddess of Victory Linux Scripts

> **Goddess of Victory: NIKKE** trên Linux · Intel Iris Plus G1 · Steam Proton + Gamescope

---

## 📁 Files

| File | Mô tả |
|------|-------|
| `nikke-gamescope.sh` | ⭐ **Script chính** — Gamescope Virtual Desktop + FSR upscale |
| `nikke-perf.sh` | Performance mode + launch qua Lutris |
| `nikke-done.sh` | Cleanup sau khi chơi xong |
| `nikke_lotery.sh` | Anti-cheat lottery bypass (GameGuard race condition) |
| `nikke-lutris.yml` | Lutris installer script (Wine + DXVK + VKD3D) |

---

## 🚀 Cách dùng

### ⭐ Gamescope Virtual Desktop (khuyên dùng)
```bash
bash ~/boots-nikke/nikke/nikke-gamescope.sh
```
- Tạo virtual display `1280×720` → upscale FSR lên `1600×900`
- Lottery tự động bypass anti-cheat (không cần làm gì thêm)
- Cleanup tự động khi thoát

### Cách thường (Lutris)
```bash
bash ~/boots-nikke/nikke/nikke-perf.sh
```

### Sau khi chơi xong
```bash
bash ~/boots-nikke/nikke/nikke-done.sh
```

---

## ⚙️ Setup yêu cầu

1. **Steam** cài sẵn (GameGuard cần Steam để init)
2. **ProtonGE** ≥ 10-25 — cài qua [ProtonPlus](https://github.com/nicowillis/protonplus)
3. **Lutris** Flatpak — `flatpak install flathub net.lutris.Lutris`
4. NIKKE đã thêm vào Steam (Non-Steam Game) theo [hướng dẫn NikkeLinux](https://github.com/koleq/NikkeLinux)
5. Sửa `APP_ID` trong `nikke_lotery.sh` và `nikke-gamescope.sh` theo ID của bạn

---

## 🔧 Cấu hình Gamescope

Chỉnh trong `nikke-gamescope.sh`:

```bash
GAME_W=1280        # Resolution bên trong virtual display
GAME_H=720
OUTPUT_W=1600      # Resolution màn hình thật
OUTPUT_H=900
FSR_SHARPNESS=5    # 0=sắc nét / 20=mượt
LOTTERY_WAIT=10    # Giây chờ mỗi lần thử
MAX_ATTEMPTS=8
```

---

## 🔧 Troubleshooting

| Lỗi | Fix |
|-----|-----|
| SDL backend failed | Đổi `--backend sdl` → `--backend xwayland` |
| Game không mở | Tăng `LOTTERY_WAIT=15` |
| Màn hình đen | Thêm `--nested-refresh 60` |
| Stuck 0% update | Dùng `NikkeMiniloader` thay launcher |

---

## 📖 Credits

- Anti-cheat lottery: **koleq** ([NikkeLinux](https://github.com/koleq/NikkeLinux))
- Gamescope integration: **Antigravity AI**
