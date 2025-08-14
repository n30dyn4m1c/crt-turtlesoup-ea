Understood — here’s the same code with the correct filename and header adjusted to match:

```mq5
//+------------------------------------------------------------------+
//|                                                       crt-ts.mq5 |
//|                                                       Neo Malesa |
//|                                     https://www.x.com/n30dyn4m1c |
//+------------------------------------------------------------------+
#property copyright "Neo Malesa"
#property link      "https://www.x.com/n30dyn4m1c"
#property version   "1.04"
#property strict

input ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;
input int   Lookback=20;
input bool  UseWickFilter=true;
input double WickFactor=3.0;

string symbols[] = {
  "EURUSD","USDJPY","GBPUSD","USDCHF","AUDUSD","USDCAD","NZDUSD",
  "EURJPY","EURGBP","EURCHF","EURCAD","EURAUD","EURNZD",
  "GBPJPY","GBPCHF","GBPCAD","GBPAUD","GBPNZD",
  "AUDCAD","AUDCHF","AUDJPY","AUDNZD",
  "CADCHF","CADJPY","CHFJPY",
  "NZDCAD","NZDCHF","NZDJPY",
  "AUS200Cash","BRENTCash","CA60Cash","China50Cash","ChinaHCash","EU50Cash","FRA40Cash",
  "GER40Cash","HK50Cash","IT40Cash","JP225Cash","NETH25Cash","NGASCash","OILCash",
  "SA40Cash","SPAIN35Cash","SWI20Cash","Sing30Cash","UK100Cash","US100Cash",
  "US2000Cash","US30Cash","US500Cash","GerMid50Cash","GerTech30Cash","TaiwanCash",
  "BTCEUR","BTCGBP","BTCUSD","ETHEUR","ETHGBP","ETHUSD",
  "GOLD","XAUUSD","XAUEUR","XPDUSD","XPTUSD"
};

datetime lastBarTime[];

// ------------ Helpers ------------
bool WickPass(double o1,double c1,double h1,double l1,bool bull,double factor){
  double body=MathAbs(c1-o1);
  if(body<=0) return false;
  double lower=MathMin(o1,c1)-l1;
  double upper=h1-MathMax(o1,c1);
  return bull ? (lower>=factor*body) : (upper>=factor*body);
}

void Extremes(const MqlRates &r[],int lookback,double &ll,double &hh){
  ll=r[1].low; hh=r[1].high;
  for(int k=1;k<=lookback;k++){ if(r[k].low<ll) ll=r[k].low; if(r[k].high>hh) hh=r[k].high; }
}

// ------------ Pattern functions ------------
bool isBullishTurtleSoup(const MqlRates &r[],int lookback,bool useWick,double wickFactor){
  double o1=r[0].open,c1=r[0].close,h1=r[0].high,l1=r[0].low;
  bool bull=c1>o1; if(!bull) return false;
  if(useWick && !WickPass(o1,c1,h1,l1,true,wickFactor)) return false;
  double ll,hh; Extremes(r,lookback,ll,hh);
  return (l1<ll && c1>ll);
}

bool isBearishTurtleSoup(const MqlRates &r[],int lookback,bool useWick,double wickFactor){
  double o1=r[0].open,c1=r[0].close,h1=r[0].high,l1=r[0].low;
  bool bear=c1<o1; if(!bear) return false;
  if(useWick && !WickPass(o1,c1,h1,l1,false,wickFactor)) return false;
  double ll,hh; Extremes(r,lookback,ll,hh);
  return (h1>hh && c1<hh);
}

// ------------ EA ------------
int OnInit(){
  ArrayResize(lastBarTime,ArraySize(symbols));
  for(int i=0;i<ArraySize(symbols);i++){ SymbolSelect(symbols[i],true); lastBarTime[i]=0; }
  return(INIT_SUCCEEDED);
}

void OnTick(){
  ENUM_TIMEFRAMES tf=(TimeFrame==PERIOD_CURRENT?(ENUM_TIMEFRAMES)_Period:TimeFrame);

  for(int i=0;i<ArraySize(symbols);i++){
    string sym=symbols[i];
    if(Bars(sym,tf)<Lookback+5) continue;

    datetime t=iTime(sym,tf,1);
    if(t==0 || t==lastBarTime[i]) continue;
    lastBarTime[i]=t;

    MqlRates r[];
    if(CopyRates(sym,tf,1,Lookback+5,r)<Lookback+2) continue;

    int digits=(int)SymbolInfoInteger(sym,SYMBOL_DIGITS);
    double h2=r[1].high,l2=r[1].low;

    if(isBullishTurtleSoup(r,Lookback,UseWickFilter,WickFactor)){
      double entry=iOpen(sym,tf,0), sl=r[0].low, tp1=(l2+h2)/2.0, tp2=h2;
      Alert(sym+" "+EnumToString(tf)+": Bullish Turtle Soup | Entry "+DoubleToString(entry,digits)
            +" SL "+DoubleToString(sl,digits)
            +" TP1 "+DoubleToString(tp1,digits)
            +" TP2 "+DoubleToString(tp2,digits));
    }
    if(isBearishTurtleSoup(r,Lookback,UseWickFilter,WickFactor)){
      double entry=iOpen(sym,tf,0), sl=r[0].high, tp1=(h2+l2)/2.0, tp2=l2;
      Alert(sym+" "+EnumToString(tf)+": Bearish Turtle Soup | Entry "+DoubleToString(entry,digits)
            +" SL "+DoubleToString(sl,digits)
            +" TP1 "+DoubleToString(tp1,digits)
            +" TP2 "+DoubleToString(tp2,digits));
    }
  }
}
```

Do you also want me to integrate an **ATR-based stop-loss buffer** in this crt-ts.mq5 so it’s more robust in volatile markets?
