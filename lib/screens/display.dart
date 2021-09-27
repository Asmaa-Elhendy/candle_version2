import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trainaing1/models/candle_models.dart';
import 'package:trainaing1/services/local.dart';
import 'package:trainaing1/services/localizationmethods.dart';


import 'dart:convert';


import 'cost_calculator.dart';
class Display extends StatefulWidget {


  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List<String>? myList   ;

  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-6990296689643792/6345802649",
    size: AdSize.banner,
    request:  AdRequest(),
    listener: BannerAdListener(),
  );


  List<Candle>? candles=[Candle(fragranceOil: 0.07, totalWeight: 7.0, result_fo: '3', result_wax: '46',unitWax: 'g',unitOil: 'g',totalcandles: 1)];
  getMyList() async {
    myList= await SaveInShared.getAllData();

    if(myList == null || myList?.length==0)
    {
      print('null list');
      setState(() {
        //candles = [];
      });
      return;
    }
    print('here');
    myList!.forEach((element) {
      print(element);
      candles?.add(Candle.fromJson(json.decode(element)));
    });

    await Future.delayed(Duration(milliseconds: 20));
    setState(() {

    });

  }
  @override
  void initState() {
    super.initState();
    getMyList();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0E59C4),
          title: Text('${gettranslated(context, 'my templates')}'),
        ),
        body: candles == null?Center(child : CircularProgressIndicator()): candles!.isEmpty || candles!.length-1==0? Center(child:Text("${gettranslated(context,"NO DATA")}")) :
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(

                            itemCount:candles!.length-1,  //?
                            itemBuilder: (context,i){
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        children: [
                                          Text('${gettranslated(context, "wax you need :")} ',style: TextStyle(fontWeight: FontWeight.bold),),
                                          Expanded(child: Text('${candles![i+1].result_wax} ${candles![i+1].unitWax}',style: TextStyle(fontWeight: FontWeight.bold),)),
                                        ],
                                      ),
                                      SizedBox(width: 15,),
                                      Row(
                                        children: [
                                          Text('${gettranslated(context, "oil you need :")} ',style: TextStyle(fontWeight: FontWeight.bold)),
                                          Expanded(child: Text('${candles![i+1].result_fo} ${candles![i+1].unitOil}',style: TextStyle(fontWeight: FontWeight.bold))),

                                        ],
                                      ),
                                    ],),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Text('${gettranslated(context, "Total Weight")} : ${candles![i+1].totalWeight.toStringAsFixed(2)}')),
                                          SizedBox(width: 8,),
                                          Expanded(child: Text('${gettranslated(context, "Fragrance Oil")} : ${candles![i+1].fragranceOil.toStringAsFixed(2)}')),

                                        ],
                                      ), Text('${gettranslated(context,"Total Candles:")} ${candles![i+1].totalcandles}')
                                    ],
                                  ),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CostCalculator(
                                            candles![i+1].result_wax,
                                            candles![i+1].result_fo,
                                            1,
                                            candles![i+1].unitOil,
                                            candles![i+1].unitWax,
                                          )),
                                    );
                                  },
                                ),
                              );
                            }
                        ))
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
        )

    )
    ;
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