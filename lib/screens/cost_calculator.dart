import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trainaing1/services/localizationmethods.dart';



class CostCalculator extends StatefulWidget {
  String weightOfWax;
  String weightOfOil;
  String unitOil;
  String unitWax;
  int totalCandles;

  CostCalculator(
      this.weightOfWax,
      this.weightOfOil,
      this.totalCandles,
      this.unitOil,
      this.unitWax,

      );

  static const routeName = '/CostCalculator';

  @override
  _CostCalculatorState createState() => _CostCalculatorState();
}

class _CostCalculatorState extends State<CostCalculator> {
  String waxprice = '0';
  String waxWeight = '0';
  String oilPrice = '0';
  String oilWeight = "0";
  String jarPrice = "0";
  String jarCount = "1";
  String wickPrice = "0";
  String wickCount =" 0";
  int var_CandlesCount = 1;
  String selectedWax = "g";
  String selectedOil = "g";


  bool resultContainer = false;

  double result_totalWAxPrice = 0;
  double result_totalOilPrice = 0;
  double result_totalJarPrice = 0;
  double result_totalWickPrice = 0;

  double result_costperCandle = 0;
  double result_costTotalCandels = 0;
  double result_weightPricePerCandle = 0;
  double result_oilPricePerCanlde = 0;
  double result_jarPricePerCandle = 0;
  double result_WickPricePerCandle = 0;



  final TextEditingController waxpricePerKiloController = TextEditingController();
  final TextEditingController waxWeightController = TextEditingController();
  final TextEditingController jarPriceController = TextEditingController();
  final TextEditingController jarCountController = TextEditingController();
  final TextEditingController wickPriceController = TextEditingController();
  final TextEditingController wickCountController = TextEditingController();
  final TextEditingController oilPriceController = TextEditingController();
  final TextEditingController oilweightController = TextEditingController();
  final TextEditingController totalCandelsController = TextEditingController();

  final BannerAd myBanner = BannerAd(
    adUnitId:"ca-app-pub-6990296689643792/6345802649",
    size: AdSize.banner,
    request:  AdRequest(),
    listener: BannerAdListener(),
  );




  Widget ListTileDecoration(leading, controller, {selected}) {
    return Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*.01),
      child: Row(
        children: [
          Text(leading,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21
            ),
          ),


          //SizedBox(width: 0.7,),
          Expanded(
            child: Container(
              margin:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.01),//****
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.17, //********
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.5),
                  //errorText: validate? 'Please enter a Username' : null,
                ),
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (value) {

                  if (controller == waxWeightController || controller == waxpricePerKiloController) {

                    setState(() {
                      if(controller == waxWeightController  ){
                        widget.unitWax = "g";
                      }
                      CalcTotalWaxPrice();
                    });
                  }

                  else if (controller == oilPriceController || controller == oilweightController) {
                    setState(() {
                      if(controller == oilweightController){
                        widget.unitOil = "g";
                      }
                      CalcTotalOIlPrice();
                    });
                  } else if (controller == jarPriceController || controller == jarCountController) {
                    setState(() {
                      CalcTotalJarPrice();
                    });
                  }  else if (controller == wickPriceController || controller == wickCountController) {
                    setState(() {
                      CalcTotalWickPrice();
                    });
                  }
                },
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget CostDesign(title, leading1, leading2, controller1, controller2,
      result,) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .5,//***
      height: MediaQuery.of(context).size.height*.40,//***

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: Colors.white
        ),
        color: Colors.white.withOpacity(0.3),
      ),
      child: Column(
        children: <Widget>[
          Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 19,
                color: Colors.white
            ),
          ),
          ListTileDecoration(leading1, controller1,),
          SizedBox(height: 4,),
          ListTileDecoration(leading2, controller2,),

          SizedBox(height: 7.1,),
          Row(
            children: [
              Text("${gettranslated(context,"Total price")}:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800
                ),
              ), Expanded(
                child: Text(" ${result.toStringAsFixed(2)}",//***********
                  style: TextStyle(
                      color: Color(0xff0E59C4),
                      fontSize: 21,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

  @override
  void dispose() {
    myBanner.dispose();

    waxpricePerKiloController.dispose();
    waxWeightController.dispose();
    oilPriceController.dispose();
    oilweightController.dispose();
    jarPriceController.dispose();
    jarCountController.dispose();
    wickPriceController.dispose();
    wickCountController.dispose();
    totalCandelsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myBanner.load();

    result_totalWAxPrice = 0;
    result_totalOilPrice = 0;
    result_totalJarPrice = 0;
    result_totalWickPrice = 0;
    result_costperCandle = 0;
    result_costTotalCandels = 0;

    result_weightPricePerCandle = 0;
    result_oilPricePerCanlde = 0;
    result_jarPricePerCandle = 0;
    result_WickPricePerCandle = 0;

    var_CandlesCount = widget.totalCandles;

    waxpricePerKiloController.addListener(updateWaxPrice);
    waxWeightController.addListener(updateWaxWeight);
    waxWeightController.text = widget.weightOfWax;
    oilPriceController.addListener(updateOilPrice);
    oilweightController.addListener(updateOilWeight);
    oilweightController.text = widget.weightOfOil;
    jarPriceController.addListener(updateJarPrice);
    jarCountController.addListener(updateJarCount);
    jarCountController.text = widget.totalCandles.toString();
    wickPriceController.addListener(updateWickPrice);
    wickCountController.addListener(updateWickCount);
    wickCountController.text = widget.totalCandles.toString();
    totalCandelsController.text = widget.totalCandles.toString();
    totalCandelsController.addListener(updateTotalCandels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus;
        currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("${gettranslated(context, "Cost Calculator")}",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),
          backgroundColor: Colors.white.withOpacity(0.2),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff90B5EA),
        //backgroundColor:Color(0xff90B5EA),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height* 0.8,
                child: Column(
                  children: [
                    Expanded(

                      child: SingleChildScrollView(
                        child:
                        Column(
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).size.height*.008,),

                              Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*.0019),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height*.73, //*******0.75
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  //padding: const EdgeInsets.all(4.0),
                                  childAspectRatio: .9,  //0.82
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 7,  //*********

                                  children: <Widget>[
                                    CostDesign("${gettranslated(context, "Wax")}", "${gettranslated(context, "price/kilo")}", "${gettranslated(context, "Weight")} ${widget.unitWax}",
                                      waxpricePerKiloController, waxWeightController,
                                      result_totalWAxPrice,),
                                    CostDesign(
                                      "${gettranslated(context, 'Oil')}","${gettranslated(context, "price/kilo")}", "${gettranslated(context, "Weight")} ${widget.unitOil}", oilPriceController,
                                      oilweightController, result_totalOilPrice,),
                                    CostDesign("${gettranslated(context, "jar")}", "${gettranslated(context, "price/unit")}", "${gettranslated(context, "count")}       ",
                                      jarPriceController, jarCountController,
                                      result_totalJarPrice,),
                                    CostDesign("${gettranslated(context, "Wick")}", "${gettranslated(context, "price/unit")}", "${gettranslated(context, "count")}       ",
                                        wickPriceController, wickCountController,
                                        result_totalWickPrice),


                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06, right: MediaQuery.of(context).size.width *0.06),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                  children: [
                                    Expanded(child: Text("${gettranslated(context, "Total Candles:")} ${widget.totalCandles}",style: TextStyle(fontSize: 18),)),
                                    // ListTileDecoration(
                                    //     "  total Candles: ", totalCandelsController),
                                    Container(
                                        margin: EdgeInsets.symmetric(vertical: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.02),
                                        child: RaisedButton(

                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                            color: Color(0xff0E59C4),
                                            child: Text("${gettranslated(context, "Cost Candle")}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                resultContainer = true;
                                                CalcCandlePrice();
                                              });
                                            }
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              resultContainer ? Container(
                                padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .1,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .02,
                                ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2,
                                height: widget.totalCandles > 1 ?(MediaQuery
                                    .of(context)
                                    .size
                                    .height -
                                    AppBar().preferredSize.height -
                                    MediaQuery
                                        .of(context)
                                        .padding
                                        .top
                                ) * 0.5:(MediaQuery
                                    .of(context)
                                    .size
                                    .height -
                                    AppBar().preferredSize.height -
                                    MediaQuery
                                        .of(context)
                                        .padding
                                        .top
                                ) * 0.2,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 3, // blur radius
                                        offset: Offset(0, -10) //ition of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                  color: Colors.white,
                                ),
                                child: widget.totalCandles > 1 ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    expandedrow(context, "${gettranslated(context, "Total Candles Cost")}", "${result_costTotalCandels.toStringAsFixed(2)}"),
                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    expandedrow(context,"${gettranslated(context,"Cost per candle")}","${result_costperCandle.toStringAsFixed(2)}"),

                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    expandedrow(context, "${gettranslated(context, "Wax Price Per Candle")}", "${result_weightPricePerCandle.toStringAsFixed(2)}"),
                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    expandedrow(context,  "${gettranslated(context,"Oil Price Per Candle")}", "${result_oilPricePerCanlde.toStringAsFixed(2)}")

                                  ],
                                ) : Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    expandedrow(context, "${gettranslated(context, "Cost per candle")}", "${result_costperCandle.toStringAsFixed(2)}"),

                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    expandedrow(context, "${gettranslated(context, "Wax Price Per Candle")}","${result_weightPricePerCandle.toStringAsFixed(2)}"),

                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    expandedrow(context,"${gettranslated(context,"Oil Price Per Candle")}","${result_oilPricePerCanlde.toStringAsFixed(2)}")

                                  ],
                                ),
                              ) : Container(),

                            ]


                        ),



                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*.05 ,right:MediaQuery.of(context).size.width*.05 ),
                  child: Container(
                    //  color: Colors.white,
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                    child: AdWidget(ad: myBanner),

                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

  void updateWaxPrice() {
    setState(() {
      if (waxpricePerKiloController.text != '') {
        waxprice = (waxpricePerKiloController.text);
      } else {
        waxprice = '0';
      }
    });
  }

  void updateWaxWeight() {
    setState(() {
      if (waxWeightController.text != '') {
        waxWeight =(waxWeightController.text);
      } else {
        waxWeight ="0";
      }
    });
  }

  void updateOilPrice() {
    setState(() {
      if (oilPriceController.text != '') {
        oilPrice = (oilPriceController.text);
      } else {
        oilPrice = "0";
      }
    });
  }

  void updateOilWeight() {
    setState(() {
      if (oilweightController.text != '') {
        oilWeight = (oilweightController.text);
      } else {
        oilWeight = "0";
      }
    });
  }

  void updateJarPrice() {
    setState(() {
      if (jarPriceController.text != '') {
        jarPrice = (jarPriceController.text).toString();
      } else {
        jarPrice = "0";
      }
    });
  }

  void updateJarCount() {
    setState(() {
      if (jarCountController.text != '') {
        jarCount = (jarCountController.text);
      } else {
        jarCount = "1";
      }
    });
  }

  void updateWickPrice() {
    setState(() {
      if (wickPriceController.text != '') {
        wickPrice = (wickPriceController.text);
      } else {
        wickPrice = "0";
      }
    });
  }

  void updateWickCount() {
    setState(() {
      if (wickCountController.text != '') {
        wickCount = (wickCountController.text);
      } else {
        wickCount = "1";
      }
    });
  }

  void updateTotalCandels() {
    setState(() {
      if (totalCandelsController.text != '') {
        widget.totalCandles = int.parse(totalCandelsController.text);
      } else {
        widget.totalCandles = 1;
      }
    });
  }

  void CalcTotalWaxPrice() {
    double totalwaxPrice = 0;
    double pricewax = double.parse(waxprice);
    double weightwax = double.parse(waxWeight);

    //double priceoil = oilPrice;
    if (widget.unitWax == "Kg") {
      totalwaxPrice = pricewax * weightwax;
    } else if (widget.unitWax == "g") {
      pricewax /= 1000;
      totalwaxPrice = pricewax * weightwax;
    }
    setState(() {

      result_totalWAxPrice = totalwaxPrice;
    });
    //widget.unitWax = "g";
  }


  void CalcTotalOIlPrice() {
    double totaloilPrice = 0;
    double priceoil = double.parse(oilPrice);
    double weightoil = double.parse(oilWeight);

    //double priceoil = oilPrice;
    if (widget.unitOil == "Kg") {
      totaloilPrice = priceoil * weightoil;
    } else if (widget.unitOil == "g") {
      priceoil /= 1000;
      totaloilPrice = priceoil * weightoil;
    }
    setState(() {
      result_totalOilPrice = totaloilPrice;
    });
  }

  void CalcTotalJarPrice() {
    double totalPrice;
    totalPrice = double.parse(jarPrice) * double.parse(jarCount);
    setState(() {
      result_totalJarPrice = totalPrice;
    });
  }

  void CalcTotalWickPrice() {
    double totalPrice;
    totalPrice = double.parse(wickPrice) * double.parse(wickCount);
    setState(() {
      result_totalWickPrice = totalPrice;
    });
  }

  void CalcCandlePrice() {
    double pricePerCandle = 0;
    double priceTotalCandle = 0;
    double pricejar = (result_totalJarPrice / widget.totalCandles);
    double pricewick = (result_totalWickPrice / widget.totalCandles);
    double priceWeightPerCandle = (result_totalWAxPrice / widget.totalCandles);
    double priceOilPerCandle = (result_totalOilPrice / widget.totalCandles);

    pricePerCandle = (
        priceWeightPerCandle +
            priceOilPerCandle +
            pricejar +
            pricewick
    );
    priceTotalCandle = pricePerCandle * var_CandlesCount;

    setState(() {
      result_costperCandle = pricePerCandle;
      result_costTotalCandels = priceTotalCandle;
      result_weightPricePerCandle = priceWeightPerCandle;
      result_oilPricePerCanlde = priceOilPerCandle;
    });
  }

  Widget expandedrow(BuildContext context,String title,String res){
    return  Row(
      children: [
        Text('${title} :',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold
          ),
        ),
        Expanded(
          child: Text(res,
            style: TextStyle(
                color: Color(0xff0E59C4),
                fontSize: 21,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }}
final BannerAdListener listener = BannerAdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    // Dispose the ad here to free resources.
    ad.dispose();
    print('Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('Ad closed.'),
  // Called when an impression occurs on the ad.
  onAdImpression: (Ad ad) => print('Ad impression.'),
);