import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:rxdart/rxdart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainaing1/screens/candle_calc.dart';
import 'package:trainaing1/services/localization.dart';
import 'package:trainaing1/services/localizationmethods.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   MobileAds.instance.initialize();
   Wakelock.enable();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setTheLocale(BuildContext context,Locale? locale) async {
    _MyAppState? localSatate = context.findAncestorStateOfType<_MyAppState>();
    localSatate!.setlocale(locale);
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
     Locale? _locale;

  void setlocale(Locale? locale) {
    if(locale!=null ) {
      setState(() {
        _locale = locale;
      });
    }

  }

  void getLocal()async{
    _locale = await getlocale();
    setState(() {

    });
    print(_locale?.languageCode);
  }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   getlocale().then((locale) {
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  // }


  @override
  void initState() {
    super.initState();
   getLocal();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "candle calculator",
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'EG')
      ],
      locale: _locale ,
      localizationsDelegates: [
        SetLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate

      ],
      localeResolutionCallback: (locale, supportedlocales) {
        for (var suppotedlocale in supportedlocales) {
          if (locale!.languageCode == suppotedlocale.languageCode &&
              locale.countryCode == suppotedlocale.countryCode) {
            return suppotedlocale;
          }
        }

        return supportedlocales.first;
      },
      home: CandleCalc(),

    );
  }
}


