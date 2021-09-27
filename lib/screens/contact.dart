import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trainaing1/services/localizationmethods.dart';
import 'package:url_launcher/url_launcher.dart';
class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("${gettranslated(context, "Candles academy")}"),
        backgroundColor: Color(0xff0E59C4),
      ),
      //   backgroundColor: Colors.white,
      body:Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.all(12.0),
                child: Text("${gettranslated(context,"To know more about us , visit our pages.")}",style: TextStyle(fontSize: 18,fontWeight:  FontWeight.bold),),
              ),SizedBox(height: MediaQuery.of(context).size.height*.05,),
              Center(
                  child: GFButton(
                    color:Color(0xff4267B2),
                    onPressed: ()async{
                      await _launchURL("https://www.facebook.com/Candles-soap-making-103006038753456/");
                    },
                    text: "${gettranslated(context,"Facebook")}",textColor: Colors.white,textStyle: TextStyle(fontSize: 18),
                    icon: Icon(Icons.facebook,color: Colors.white,),
                    type: GFButtonType.solid,
                    blockButton: true,
                  )
              ),SizedBox(height: MediaQuery.of(context).size.height*.05,),
              Center(
                child: GFButton(
                  color:Color(0xffFF0000),
                  onPressed: ()async{
                    await _launchURL("https://youtube.com/c/AhmedHamedelsaraya");
                  },
                  text: "${gettranslated(context,"Youtube")}",textColor: Colors.white,textStyle: TextStyle(fontSize: 18),
                  icon: Icon(Icons.youtube_searched_for,color: Colors.white,),
                  type: GFButtonType.solid,
                  blockButton: true,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*.08 ,right:MediaQuery.of(context).size.width*.08 ),
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


    );
  }
}

_launchURL(String url) async {
  url = url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
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