//+------------------------------------------------------------------+
//|                                                  CRTTS_Weekly.mq5|
//|                                                       Neo Malesa |
//|                                     https://www.x.com/n30dyn4m1c |
//+------------------------------------------------------------------+
#property copyright "Neo Malesa"
#property link      "https://www.x.com/n30dyn4m1c"
#property version   "1.04"

input ENUM_TIMEFRAMES TimeFrame = PERIOD_W1;

string symbols[] = {
    "EURUSD", "USDJPY", "GBPUSD", "USDCHF", "AUDUSD", "USDCAD", "NZDUSD",
    "EURJPY", "EURGBP", "EURCHF", "EURCAD", "EURAUD", "EURNZD",
    "GBPJPY", "GBPCHF", "GBPCAD", "GBPAUD", "GBPNZD",
    "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD",
    "CADCHF", "CADJPY", "CHFJPY",
    "NZDCAD", "NZDCHF", "NZDJPY",
    "AUS200Cash", "BRENTCash", "CA60Cash", "China50Cash", "ChinaHCash", "EU50Cash", "FRA40Cash",
    "GER40Cash", "HK50Cash", "IT40Cash", "JP225Cash", "NETH25Cash", "NGASCash", "OILCash",
    "SA40Cash", "SILVER", "SPAIN35Cash", "SWI20Cash", "Sing30Cash", "UK100Cash", "US100Cash",
    "US2000Cash", "US30Cash", "US500Cash", "GerMid50Cash", "GerTech30Cash", "TaiwanCash",
    "BTCEUR", "BTCGBP", "BTCUSD", "ETHEUR", "ETHGBP", "ETHUSD",
    "GOLD", "XAUUSD", "SILVER", "XAUEUR", "XPDUSD", "XPTUSD"
};

int OnInit() {
    Print("CRT_TS_Weekly_EA initialized.");
    return INIT_SUCCEEDED;
}

void OnTick() {
    static datetime lastChecked = 0;
    if (TimeCurrent() - lastChecked < 900) return;
    lastChecked = TimeCurrent();

    for (int i = 0; i < ArraySize(symbols); i++) {
        string symbol = symbols[i];
        if (Bars(symbol, TimeFrame) < 3) continue;

        double o2 = iOpen(symbol, TimeFrame, 2);
        double c2 = iClose(symbol, TimeFrame, 2);
        double h2 = iHigh(symbol, TimeFrame, 2);
        double l2 = iLow(symbol, TimeFrame, 2);

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

        if (c2Bear && c1Bull && l1 < l2 && c1 > c2 && longLowerWick1)
            Alert(symbol + " Weekly: Bullish Turtle Soup detected.");

        if (c2Bull && c1Bear && h1 > h2 && c1 < c2 && longUpperWick1)
            Alert(symbol + " Weekly: Bearish Turtle Soup detected.");
    }
}
