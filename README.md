# Turtle Soup Detection EAs for MT5

This repository contains a suite of Expert Advisors (EAs) for MetaTrader 5 that detect high-quality **Turtle Soup** reversal setups across multiple timeframes—M15, H4, Daily, Weekly, and Monthly. Each EA scans over 60 instruments including forex pairs, indices, commodities, and crypto.

## What is Turtle Soup?

Turtle Soup is a reversal strategy based on false breakouts. These EAs detect such setups when:
- A candle breaks the previous high/low and then closes back inside
- The wick is significantly longer than the body (strong rejection)

## Included Files
- `CRTTS_M15.mq5` – 15-minute (M15), wick must be ≥ 3× candle body
- `CRTTS.mq5` – 4-hour (H4), wick must be ≥ 2× candle body
- `CRTTS_Daily.mq5` – Daily (D1)
- `CRTTS_Weekly.mq5` – Weekly (W1)
- `CRTTS_Monthly.mq5` – Monthly (MN1)

All EAs send alerts only and do not place trades.

## How to Use in MT5

1. Open **MetaTrader 5**
2. Press `F4` to open **MetaEditor**
3. Copy any `.mq5` file into the `MQL5/Experts` directory
4. In MetaEditor, right-click the file and select **Compile**
5. Return to MT5
6. Open the **Navigator** panel (`Ctrl+N`)
7. Drag the EA onto any chart
8. Enable **Algo Trading** (top toolbar button)

Alerts will be triggered whenever valid Turtle Soup patterns are detected.

## Author

Created by **Neo Malesa**  
[X Profile](https://www.x.com/n30dyn4m1c)
