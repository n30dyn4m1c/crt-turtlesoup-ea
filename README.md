# 🐢🍲 Turtle Soup Detection EAs for MT5

A multi-timeframe MetaTrader 5 EA suite for detecting high-probability Turtle Soup reversal setups across over 60 forex, index, commodity, and crypto instruments. Developed for price action traders who seek clean, structured, wick-based entries without indicators.

---

## 🧰 Tech Stack

- **Platform**: MetaTrader 5
- **Language**: MQL5
- **Alert System**: Terminal-based alerts (planned: push/email)
- **Trade Logic**: Price-action, Turtle Soup reversal strategy
- **Symbol Coverage**: 60+ FX pairs, indices, metals, crypto
- **Timeframes**: M15, H4, D1, W1, MN1

---

## 🚀 Key Features

- ✅ Detects 3-candle Turtle Soup setups (range → false breakout → reversal)
- ✅ Long wick validation: wick ≥ 2× body
- ✅ Trade level alerts on H4: Entry, SL, TP1, TP2
- ✅ Multi-asset scanning from one chart
- ✅ Pure price-action: no indicators used
- 🔜 Push/email/mobile alerts
- 🔜 Auto-trading logic with risk controls
- 🔜 On-chart dashboard for signal display

---

## 📊 Turtle Soup Logic (H4 EA)

The H4 script follows strict 3-candle logic:
- **Candle2**: Range candle
- **Candle1**: False breakout candle with a long wick
- **Candle0**: Currently forming candle (entry reference)

### Trade Levels
- **Entry**: Open of Candle0 (Buy Below / Sell Above)
- **SL**: Wick extreme of Candle1
- **TP1**: Midpoint of Candle2 range
- **TP2**: Candle2 extreme (opposite direction of the setup)

### Detection Conditions
- **Bullish TS**:
  - Candle2 is bearish
  - Candle1 is bullish and breaks Candle2 low
  - Candle1 closes above Candle2 close
  - Candle1 has a long lower wick

- **Bearish TS**:
  - Candle2 is bullish
  - Candle1 is bearish and breaks Candle2 high
  - Candle1 closes below Candle2 close
  - Candle1 has a long upper wick

---

## 🗂 Included Files

| File                | Timeframe | Wick Requirement | Trade Alerts | Notes                          |
|---------------------|-----------|------------------|---------------|--------------------------------|
| `CRTTS_M15.mq5`     | M15       | ≥ 3× body        | No            | For high-frequency setups      |
| `CRTTS_H4.mq5`      | H4        | ≥ 2× body        | Yes           | 3-candle logic + full alerts   |
| `CRTTS_Daily.mq5`   | D1        | ≥ 2× body        | No            | Clean daily signal filter      |
| `CRTTS_Weekly.mq5`  | W1        | ≥ 2× body        | No            | Long-term signal confirmation  |
| `CRTTS_Monthly.mq5` | MN1       | ≥ 2× body        | No            | Macro-level reversals          |

> All EAs are alert-only by default. No auto-trading yet.

---

## ⏰ When to Run

- **M15**: Continuously during active sessions
- **H4**: NY time – 1 AM, 5 AM, 9 AM or PM
- **Daily**: At the start of the trading day
- **Weekly**: Mondays after weekly open
- **Monthly**: First calendar day of the month

---

## 🛠️ Setup Instructions

1. Open MetaTrader 5  
2. Press `F4` to open MetaEditor  
3. Copy `.mq5` files into the `MQL5/Experts` directory  
4. Compile your EA (`Right-click → Compile`)  
5. Open MT5 → Navigator → Drag the EA onto any chart  
6. Enable **Algo Trading**  
7. Wait for alerts (pop-up) when a valid pattern is detected

---

## 📸 Screenshot

![Turtle Soup Alert](screenshot.png)

---

## 🎯 Future Improvements

- ⏱️ Timed trigger: H4 scans only during first 30 min of each candle
- 🧠 Filter: Require TS body < 50% of range body
- 📈 Expand logic to multi-candle range breaks (2–5 bars)
- ↔️ Same-direction Turtle Soup (e.g. bullish candle + bullish wick)
- 🚫 Prevent duplicate alerts using per-symbol memory
- 🔀 Merge timeframes into one EA with toggle switches
- 📊 Add dashboard with HTMX-style signal display
- ✉️ Push/email/mobile notifications
- 🤖 Add trading logic with SL/TP and lot sizing

---

## 📝 License & Acknowledgments

- © 2025 **Neo Malesa** – [@n30dyn4m1c on X](https://www.x.com/n30dyn4m1c)  
- Built with 💚 for MT5 CRT traders   
- Strategy inspired by Turtle Soup, coined by Linda Raschke, and Candle Range Theory by Romeo

---

