//+------------------------------------------------------------------+
//|                                                     CRTTS_H4.mq5 |
//|                                                       Neo Malesa |
//|                                     https://www.x.com/n30dyn4m1c |
//+------------------------------------------------------------------+
#property copyright "Neo Malesa"
#property link      "https://www.x.com/n30dyn4m1c"
#property version   "1.04"

input ENUM_TIMEFRAMES TimeFrame = PERIOD_H4;

// List of instruments (symbols) to loop through
string symbols[] = {
    // Major forex pairs
    "EURUSD", "USDJPY", "GBPUSD", "USDCHF", "AUDUSD", "USDCAD", "NZDUSD",

    // Minor forex pairs
    "EURGBP", "EURJPY", "EURCHF", "EURCAD", "EURAUD", "EURNZD",
    "GBPJPY", "GBPCHF", "GBPCAD", "GBPAUD", "GBPNZD",
    "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD",
    "CADCHF", "CADJPY", "CHFJPY",
    "NZDCAD", "NZDCHF", "NZDJPY",

    // Indices, commodities, and crypto
    "AUS200Cash", "BRENTCash", "CA60Cash", "China50Cash", "ChinaHCash", "EU50Cash", "FRA40Cash",
    "GER40Cash", "HK50Cash", "IT40Cash", "JP225Cash",
    "NETH25Cash", "NGASCash", "OILCash", "SA40Cash", "SILVER",
    "SPAIN35Cash", "SWI20Cash", "Sing30Cash", "UK100Cash",
    "US100Cash", "US2000Cash", "US30Cash", "US500Cash", "GerMid50Cash", "GerTech30Cash", "TaiwanCash",

    "BTCEUR", "BTCGBP", "BTCUSD", "ETHEUR", "ETHGBP", "ETHUSD",

    "GOLD", "XAUUSD", "SILVER", "XAUEUR", "XPDUSD", "XPTUSD"
};

int OnInit() {
    Print("CRT_TS_H4_EA initialized.");
    return INIT_SUCCEEDED;
}

void OnTick() {
    static datetime lastChecked = 0;
    if (TimeCurrent() - lastChecked < 600) return;
    lastChecked = TimeCurrent();

    for (int i = 0; i < ArraySize(symbols); i++) {
        string symbol = symbols[i];

        // Require 3 bars for Turtle Soup pattern: Candle1, Candle2, and forming Candle3
        if (Bars(symbol, TimeFrame) < 3) continue;

        double o0 = iOpen(symbol, TimeFrame, 0);

        // Candle1: pattern range
        double o2 = iOpen(symbol, TimeFrame, 2);
        double c2 = iClose(symbol, TimeFrame, 2);
        double h2 = iHigh(symbol, TimeFrame, 2);
        double l2 = iLow(symbol, TimeFrame, 2);

        // Candle2: false breakout (TS candle)
        double o1 = iOpen(symbol, TimeFrame, 1);
        double c1 = iClose(symbol, TimeFrame, 1);
        double h1 = iHigh(symbol, TimeFrame, 1);
        double l1 = iLow(symbol, TimeFrame, 1);

        bool c1Bull = c1 > o1;
        bool c1Bear = c1 < o1;
        bool c2Bull = c2 > o2;
        bool c2Bear = c2 < o2;

        if (!c1Bull && !c1Bear) continue;
        if (!c2Bull && !c2Bear) continue;

        double body1 = MathAbs(c1 - o1);
        double lowerWick1 = MathMin(o1, c1) - l1;
        double upperWick1 = h1 - MathMax(o1, c1);

        bool longLowerWick1 = lowerWick1 > 2.0 * body1;
        bool longUpperWick1 = upperWick1 > 2.0 * body1;

        // Bullish Turtle Soup
        if (c2Bull && c1Bear && l1 < l2 && longLowerWick1 && c1 > o2) {
            double entry = o0;
            string entryText = "Buy Below: " + DoubleToString(entry, _Digits);
            double sl = l1;
            double tp1 = (l2 + h2) / 2.0;
            double tp2 = h2;
            Alert(symbol + " H4: Bullish Turtle Soup detected.");
            Alert(symbol + " " + entryText + " | SL: " + DoubleToString(sl, _Digits) + " | TP1: " + DoubleToString(tp1, _Digits) + " | TP2: " + DoubleToString(tp2, _Digits));
        }

        // Bearish Turtle Soup
        if (c2Bear && c1Bull && h1 > h2 && longUpperWick1 && c1 < o2) {
            double entry = o0;
            string entryText = "Sell Above: " + DoubleToString(entry, _Digits);
            double sl = h1;
            double tp1 = (h2 + l2) / 2.0;
            double tp2 = l2;
            Alert(symbol + " H4: Bearish Turtle Soup detected.");
            Alert(symbol + " " + entryText + " | SL: " + DoubleToString(sl, _Digits) + " | TP1: " + DoubleToString(tp1, _Digits) + " | TP2: " + DoubleToString(tp2, _Digits));
        }
    }
}
