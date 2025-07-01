# Turtle Soup Detection EAs for MT5

This repository contains a group of Expert Advisors (EAs) for MetaTrader 5 that detect high-quality **Turtle Soup** reversal setups across multiple timeframes—H4, Daily, Weekly, and Monthly. Each EA scans over 60 instruments including forex pairs, indices, commodities, and crypto.

## What is Turtle Soup?

Turtle Soup is a reversal strategy based on false breakouts. These EAs detect such setups when:
- A candle breaks the previous high/low and then closes back inside
- The wick is more than 2× the body, ensuring strong rejection

## Included Files
- `CRTTS.mq5` – H4 timeframe
- `CRTTS_Daily.mq5` – Daily (D1) timeframe
- `CRTTS_Weekly.mq5` – Weekly (W1) timeframe
- `CRTTS_Monthly.mq5` – Monthly (MN1) timeframe

Each EA sends alerts only (no auto-trading).

## How to Use in MT5

1. Open **MetaTrader 5**
2. Press `F4` to open **MetaEditor**
3. Copy any `.mq5` file into the `MQL5/Experts` folder
4. In MetaEditor, right-click the file and select **Compile**
5. Return to MT5
6. Open the **Navigator** panel (`Ctrl+N`)
7. Drag the compiled EA onto any chart
8. Enable **Algo Trading** and ensure chart is open for alerts to trigger

## Author

Created by **Neo Malesa**  
[X Profile](https://www.x.com/n30dyn4m1c)

