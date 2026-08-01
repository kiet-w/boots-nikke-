# 🎮 boots-nikke — Linux Game Boot Scripts

> Scripts tối ưu và khởi động game trên **Linux** · Debian forky/sid · Intel i5-1035G1 · Intel Iris Plus G1

---

## 📁 Cấu trúc

```
boots-nikke/
├── nikke/                    ← Goddess of Victory: NIKKE
│   ├── nikke-gamescope.sh    ⭐ Gamescope Virtual Desktop (main)
│   ├── nikke-perf.sh         Performance launch via Lutris
│   ├── nikke-done.sh         Cleanup sau khi chơi
│   ├── nikke_lotery.sh       Anti-cheat lottery bypass
│   ├── nikke-lutris.yml      Lutris installer
│   └── README.md
│
├── bd2/                      ← Brown Dust 2
│   ├── bd2-perf.sh           Tối ưu CPU/GPU/RAM
│   ├── bd2-launch.sh         Launch qua Lutris
│   └── README.md
│
├── shared/
│   └── dxvk.conf             DXVK config dùng chung
│
└── README.md                 (file này)
```

---

## ⚡ Quick Start

### 🎮 NIKKE
```bash
bash ~/boots-nikke/nikke/nikke-gamescope.sh
```
→ Xem [`nikke/README.md`](nikke/README.md) để biết thêm

### 🎮 Brown Dust 2
```bash
bash ~/boots-nikke/bd2/bd2-perf.sh
bash ~/boots-nikke/bd2/bd2-launch.sh
```
→ Xem [`bd2/README.md`](bd2/README.md) để biết thêm

---

## 🖥️ System Info

| | |
|--|--|
| OS | Debian GNU/Linux forky/sid |
| Kernel | 7.1.4+deb14-amd64 |
| CPU | Intel Core i5-1035G1 @ 1.00GHz (Ice Lake) |
| GPU | Intel Iris Plus Graphics G1 |
| Display | 1600×900 / X11 |

---

## 📖 Credits

- NIKKE lottery method: **koleq** ([NikkeLinux](https://github.com/koleq/NikkeLinux))
- Gamescope: [ValveSoftware/gamescope](https://github.com/ValveSoftware/gamescope)
