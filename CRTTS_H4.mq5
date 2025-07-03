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
    if (TimeCurrent() - lastChecked < 60) return;
    lastChecked = TimeCurrent();

    for (int i = 0; i < ArraySize(symbols); i++) {
        string symbol = symbols[i];

        if (Bars(symbol, TimeFrame) < 4) continue;

        double o0 = iOpen(symbol, TimeFrame, 0);

        double o1 = iOpen(symbol, TimeFrame, 1);
        double c1 = iClose(symbol, TimeFrame, 1);
        double h1 = iHigh(symbol, TimeFrame, 1);
        double l1 = iLow(symbol, TimeFrame, 1);

        double o2 = iOpen(symbol, TimeFrame, 2);
        double c2 = iClose(symbol, TimeFrame, 2);
        double h2 = iHigh(symbol, TimeFrame, 2);
        double l2 = iLow(symbol, TimeFrame, 2);
        double mid2 = (o2 + c2) / 2.0;

        double o3 = iOpen(symbol, TimeFrame, 3);
        double c3 = iClose(symbol, TimeFrame, 3);
        double h3 = iHigh(symbol, TimeFrame, 3);
        double l3 = iLow(symbol, TimeFrame, 3);

        bool c1Bull = c1 > o1;
        bool c1Bear = c1 < o1;
        bool c2Bull = c2 > o2;
        bool c2Bear = c2 < o2;

        if (!c1Bull && !c1Bear) continue;
        if (!c2Bull && !c2Bear) continue;

        double body2 = MathAbs(c2 - o2);
        double lowerWick2 = MathMin(o2, c2) - l2;
        double upperWick2 = h2 - MathMax(o2, c2);

        bool longLowerWick2 = lowerWick2 > 2.0 * body2;
        bool longUpperWick2 = upperWick2 > 2.0 * body2;

        // Bullish Turtle Soup
        if (c1Bull && c2Bear && l2 < l3 && o2 > c3 && h2 < o3 && h2 < mid2 && longLowerWick2) {
            double entry = o0;
            double sl = l2;
            double tp1 = (o1 + c1) / 2.0;
            double tp2 = h1;
            Alert(symbol + " H4: Bullish Turtle Soup detected.");
            Alert(symbol + " Buy Below: " + DoubleToString(entry, _Digits) + " | SL: " + DoubleToString(sl, _Digits) + " | TP1: " + DoubleToString(tp1, _Digits) + " | TP2: " + DoubleToString(tp2, _Digits));
        }

        // Bearish Turtle Soup
        if (c1Bear && c2Bull && h2 > h3 && o2 < c3 && l2 > o3 && l2 > mid2 && longUpperWick2) {
            double entry = o0;
            double sl = h2;
            double tp1 = (o1 + c1) / 2.0;
            double tp2 = l1;
            Alert(symbol + " H4: Bearish Turtle Soup detected.");
            Alert(symbol + " Sell Above: " + DoubleToString(entry, _Digits) + " | SL: " + DoubleToString(sl, _Digits) + " | TP1: " + DoubleToString(tp1, _Digits) + " | TP2: " + DoubleToString(tp2, _Digits));
        }
    }
}
