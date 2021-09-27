import 'package:flutter/material.dart';
import 'package:trainaing1/services/localizationmethods.dart';
import '../Widgets/InputData.dart';
import '../Widgets/drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CandleCalc extends StatefulWidget {
  const CandleCalc({Key? key}) : super(key: key);

  @override
  _CandleCalcState createState() => _CandleCalcState();
}

class _CandleCalcState extends State<CandleCalc> {
  double fragranceOil = 0;
  double totalWeight = 0;
  String result_fo_var='0';
  String result_wax_var='0';

  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-6990296689643792/6345802649",
    size: AdSize.banner,
    request:  AdRequest(),
    listener: BannerAdListener(),
  );

  void initState() {
    super.initState();
    myBanner.load();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    myBanner.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus;
        currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }},
      child : Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff90B5EA),
        appBar: AppBar(
          centerTitle: true,
          title: Text("${gettranslated(context, "Candle Calculator")}",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),
          backgroundColor: Colors.white.withOpacity(0.2),
        ),

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            InputData(),
                            SizedBox(height:MediaQuery.of(context).size.height*.09,)
                          ],

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
        drawer: AppDrawer(),
      ),
    );
  }

}

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