//+------------------------------------------------------------------+
//|                                                     CRTTS_H4.mq5 |
//|                                                              N30 |
//|                                     https://www.x.com/n30dyn4m1c |
//+------------------------------------------------------------------+
#property copyright "Neo Malesa"
#property link      "https://www.x.com/n30dyn4m1c"
#property version   "1.03"

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
    "AUS200Cash", "BRENTCash", "CA60Cash", "EU50Cash", "FRA40Cash",
    "GER40Cash", "GOLD", "HK50Cash", "IT40Cash", "JP225Cash",
    "NETH25Cash", "NGASCash", "OILCash", "SA40Cash", "SILVER",
    "SPAIN35Cash", "SWI20Cash", "Sing30Cash", "UK100Cash",
    "US100Cash", "US2000Cash", "US30Cash", "US500Cash",

    "BTCEUR", "BTCGBP", "BTCUSD", "ETHEUR", "ETHGBP", "ETHUSD",

    "XAUEUR", "XPDUSD", "XPTUSD"
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

        if (Bars(symbol, TimeFrame) < 3) continue;

        double o1 = iOpen(symbol, TimeFrame, 1);
        double c1 = iClose(symbol, TimeFrame, 1);
        double h1 = iHigh(symbol, TimeFrame, 1);
        double l1 = iLow(symbol, TimeFrame, 1);

        double o2 = iOpen(symbol, TimeFrame, 2);
        double c2 = iClose(symbol, TimeFrame, 2);
        double h2 = iHigh(symbol, TimeFrame, 2);
        double l2 = iLow(symbol, TimeFrame, 2);
        double mid2 = (o2 + c2) / 2.0;

        bool c1Bull = c1 > o1;
        bool c1Bear = c1 < o1;
        bool c2Bull = c2 > o2;
        bool c2Bear = c2 < o2;

        if (!c1Bull && !c1Bear) continue;
        if (!c2Bull && !c2Bear) continue;

        double body1 = MathAbs(c1 - o1);
        double lowerWick = MathMin(o1, c1) - l1;
        double upperWick = h1 - MathMax(o1, c1);

        bool longLowerWick = lowerWick > 2.0 * body1;
        bool longUpperWick = upperWick > 2.0 * body1;

        if (c1Bull && c2Bear && l1 < l2 && o1 > c2 && h1 < o2 && h1 < mid2 && longLowerWick)
            Alert(symbol + " H4: Bullish Turtle Soup detected.");

        if (c1Bear && c2Bull && h1 > h2 && o1 < c2 && l1 > o2 && l1 > mid2 && longUpperWick)
            Alert(symbol + " H4: Bearish Turtle Soup detected.");
    }
}
