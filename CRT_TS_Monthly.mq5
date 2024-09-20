//+------------------------------------------------------------------+
//|                                                        CRTTS.mq5 |
//|                                                              N30 |
//|                               https://www.tiktok.com/@n30dyn4m1c |
//+------------------------------------------------------------------+
#property copyright "N30"
#property link      "https://www.tiktok.com/@n30dyn4m1c"
#property version   "1.00"

// List of instruments (symbols) to loop through
string symbols[] = {

"AUDCADm#",
"AUDCHFm#",
"AUDJPYm#",
"AUDNZDm#",
"AUDUSDm#",

"AUS200Cash",
"BRENTCash",
"CA60Cash",
"EU50Cash",
"FRA40Cash",

"BTCEUR#",
"BTCGBP#",
"BTCUSD#",
"ETHEUR#",
"ETHGBP#",
"ETHUSD#",

"CADCHFm#",
"CADJPYm#",
"CHFJPYm#",

"EURAUDm#",
"EURCADm#",
"EURCHFm#",
"EURGBPm#",
"EURJPYm#",
"EURNZDm#",
"EURUSDm#",

"GBPAUDm#",
"GBPCADm#",
"GBPCHFm#",
"GBPJPYm#",
"GBPNZDm#",
"GBPUSDm#",

"GER40Cash",
"GOLDm#",
"HK50Cash",
"IT40Cash",
"JP225Cash",
"NETH25Cash",
"NGASCash",
"OILCash",
"SA40Cash",
"SILVERm#",
"SPAIN35Cash",
"SWI20Cash",
"Sing30Cash",
"UK100Cash",
"US100Cash",
"US2000Cash",
"US30Cash",
"US500Cash",

"NZDCADm#",
"NZDCHFm#",
"NZDJPYm#",
"NZDUSDm#",

"USDCADm#",
"USDCHFm#",
"USDJPYm#",
"XAUEURm#",
"XPDUSDm#",
"XPTUSDm#"

};

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("CRT_TS_MN1_EA initialized.");
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    // Loop through all instruments
    for (int i = 0; i < ArraySize(symbols); i++)
    {
        string currentSymbol = symbols[i]; // Current instrument in the loop

        // Ensure we have at least 2 MN1 candles to work with for this symbol
        if (Bars(currentSymbol, PERIOD_MN1) < 2)
        {
            Print(currentSymbol, ": Not enough bars to calculate the high and low of previous periods.");
            continue; // Move to the next symbol
        }

        // Get the index for the previous MN1 candle (index 1) for this symbol
        double prevMN1Open = iOpen(currentSymbol, PERIOD_MN1, 1);
        double prevMN1Close = iClose(currentSymbol, PERIOD_MN1, 1);
        double prevMN1High = iHigh(currentSymbol, PERIOD_MN1, 1);  
        double prevMN1Low = iLow(currentSymbol, PERIOD_MN1, 1);    

        // Get the MN1 candle before the previous one (index 2) for this symbol
        double b4prevMN1Open = iOpen(currentSymbol, PERIOD_MN1, 2);
        double b4prevMN1Close = iClose(currentSymbol, PERIOD_MN1, 2);
        double b4prevMN1High = iHigh(currentSymbol, PERIOD_MN1, 2);
        double b4prevMN1Low = iLow(currentSymbol, PERIOD_MN1, 2);  
        double b4prevMN1Mid = (b4prevMN1Open + b4prevMN1Close) / 2.0;

        // Check if the previous MN1 candle is bullish or neutral
        bool prevMN1Bullish = IsBullish(prevMN1Open, prevMN1Close);
        bool prevMN1Neutral = IsNeutral(prevMN1Open, prevMN1Close);

        // Check if the MN1 candle before the previous one is bullish or neutral
        bool b4prevMN1Bullish = IsBullish(b4prevMN1Open, b4prevMN1Close);
        bool b4prevMN1Neutral = IsNeutral(b4prevMN1Open, b4prevMN1Close);

        // Now check and print the combination of both candles
        if (!prevMN1Neutral && !b4prevMN1Neutral) // Only check combinations if none are neutral
        {
            if (prevMN1Bullish && !b4prevMN1Bullish)
            {
                // Turtle Soup condition
                if (prevMN1Low < b4prevMN1Low && prevMN1Open > b4prevMN1Close
                     && prevMN1High < b4prevMN1Open && prevMN1High < b4prevMN1Mid)
                {
                    Print(currentSymbol, " ", TimeFrameToString(PERIOD_MN1), ": Turtle Soup setup detected!");
                }
            }
            else if (prevMN1Bullish && b4prevMN1Bullish)
            {
                // Turtle Soup condition
                if (prevMN1High > b4prevMN1High && prevMN1Close < b4prevMN1Close
                  && prevMN1Low > b4prevMN1Open && prevMN1Low > b4prevMN1Mid)
                {
                    Print(currentSymbol, " ", TimeFrameToString(PERIOD_MN1), ": Turtle Soup setup detected!");
                }
            }
            else if (!prevMN1Bullish && b4prevMN1Bullish)
            {
                // Turtle Soup condition
                if (prevMN1High > b4prevMN1High && prevMN1Open < b4prevMN1Close
                   && prevMN1Low > b4prevMN1Open && prevMN1Low > b4prevMN1Mid)
                {
                    Print(currentSymbol, " ", TimeFrameToString(PERIOD_MN1), ": Turtle Soup setup detected!");
                }
            }
            else
            {
                // Turtle Soup condition
                if (prevMN1Low < b4prevMN1Low && prevMN1Close > b4prevMN1Close
                  && prevMN1High < b4prevMN1Open && prevMN1High < b4prevMN1Mid)
                {
                    Print(currentSymbol, " ", TimeFrameToString(PERIOD_MN1), ": Turtle Soup setup detected!");
                }
            }
        }
        else
        {
            //Print(currentSymbol, " ", TimeFrameToString(PERIOD_MN1), ": Cannot calculate combination due to a neutral candle.");
        }
    }
}

//+------------------------------------------------------------------+
//| Function to check if a candle is bullish or neutral               |
//+------------------------------------------------------------------+
bool IsBullish(double open, double close)
{
    return (close > open);
}

bool IsNeutral(double open, double close)
{
    return (close == open);
}

//+------------------------------------------------------------------+
//| Function to convert timeframe constants to readable strings       |
//+------------------------------------------------------------------+
string TimeFrameToString(int period)
{
    switch(period)
    {
        case PERIOD_M1:   return "M1";   // 1 minute
        case PERIOD_M5:   return "M5";   // 5 minutes
        case PERIOD_M15:  return "M15";  // 15 minutes
        case PERIOD_M30:  return "M30";  // 30 minutes
        case PERIOD_H1:   return "H1";   // 1 hour
        case PERIOD_H4:   return "H4";   // 4 hours
        case PERIOD_D1:   return "D1";   // Daily
        case PERIOD_W1:   return "W1";   // Weekly
        case PERIOD_MN1:  return "MN1";  // Monthly
        default:          return "Unknown Timeframe";
    }
}
