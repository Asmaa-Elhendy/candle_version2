import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainaing1/models/candle_models.dart';
import 'package:trainaing1/services/local.dart';
import 'package:trainaing1/services/localizationmethods.dart';

import 'result.dart';

class InputData extends StatefulWidget {
  const InputData({Key? key}) : super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  String result_fo = '0';
  String result_wax = '0';
  String unitWax = 'g';
  String unitOil = 'g';
  double fragranceOil = 0;
  double totalWeight = 0;
  int totalCandles = 1;

  bool foValidate = false;
  bool twValidate = false;
  bool tcValidate = false;

  final TextEditingController _fragranceOilController = TextEditingController();
  final TextEditingController _totalWeightController = TextEditingController();
  final TextEditingController _totalCandlesController = TextEditingController();

  @override
  void dispose() {
    _fragranceOilController.dispose();
    _totalWeightController.dispose();
    _totalCandlesController.dispose();

    super.dispose();
  }
  Widget formDesign(title, controller,bool validate){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Text(title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22
          ),
        ),

        Container(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*.001),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.white),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0.5),
              //errorText: validate? 'Please enter a Username' : null,
            ),
            controller:controller,
            keyboardType: TextInputType.number,

            onChanged: (_){
              setState(() {
                calculateResults();
              });
            },

          ),
        ),


      ],
    );
    // return ListTile(
    //   leading:  Text(title,
    //     style: TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 22
    //     ),
    //   ),
    //
    //   title: Container(
    //     width: MediaQuery.of(context).size.width*.2,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: Colors.white,
    //     ),
    //     child: TextField(
    //       textAlign: TextAlign.center,
    //       decoration: InputDecoration(
    //         border:  OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10),
    //           borderSide: BorderSide(
    //               color: Colors.white),
    //         ),
    //         contentPadding: EdgeInsets.symmetric(vertical: 0.5),
    //         //errorText: validate? 'Please enter a Username' : null,
    //       ),
    //       controller:controller,
    //       keyboardType: TextInputType.number,
    //
    //       onChanged: (_){
    //         setState(() {
    //           calculateResults();
    //         });
    //       },
    //
    //     ),
    //   ),
    // );
  }

  @override
  void initState(){
    result_fo = '0';
    result_wax = '0';
    unitWax = 'g';
    unitOil = 'g';
    _fragranceOilController.addListener(updateFO);
    _totalWeightController.addListener(updateTW);
    _totalCandlesController.addListener(updateTC);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.01,left: MediaQuery.of(context).size.height*.1,right: MediaQuery.of(context).size.height*.1),
        ),
        Container(
          padding: const  EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width *.78,
          height: (MediaQuery.of(context).size.height-
              AppBar().preferredSize.height-
              MediaQuery.of(context).padding.top
          )*0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: Colors.white
            ),
            color: Colors.white.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              formDesign("${gettranslated(context, "Total Weight")} g:", _totalWeightController,foValidate),
              formDesign("${gettranslated(context, "Fragrance Oil (%):")}", _fragranceOilController,twValidate),
              formDesign("${gettranslated(context, "Total Candles:")}", _totalCandlesController,tcValidate),

            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*.014,),
        Result(result_wax,result_fo,totalCandles,unitWax,unitOil),
        RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            color: Color(0xff0E59C4),
            child: Text("${gettranslated(context,  "save")}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            ),
          onPressed: () async{
            Candle candle = Candle(fragranceOil: fragranceOil*100, totalWeight: totalWeight, result_fo: result_fo,unitOil: unitOil, result_wax: result_wax,unitWax: unitWax, totalcandles: totalCandles);
            await SaveInShared.saveInShared(json.encode(Candle.toJson(candle)));
            //await SaveInShared.deleteMyList();
            print('in save');

          },

        ),
      ],
    );
  }
  void updateFO(){
    setState(() {
      if(_fragranceOilController.text !=''){
        fragranceOil = double.parse(_fragranceOilController.text);
        fragranceOil /= 100;
      }else{
        fragranceOil = 0;
      }
    });
  }
  void updateTW(){
    setState(() {
      if(_totalWeightController.text != ''){
        totalWeight = double.parse(_totalWeightController.text);
      }else{
        totalWeight = 0;
      }
    });
  }
  void updateTC(){
    setState(() {
      if(_totalCandlesController.text != ''){
        totalCandles = int.parse(_totalCandlesController.text);
      }else{
        totalCandles = 1;
      }
    });
  }
  void calculateResults(){
    double fo;
    double wax;

    wax =((totalWeight / (1 + fragranceOil))) ;

    fo = (totalWeight - wax);

    wax = wax * totalCandles;
    fo = fo* totalCandles;
    if(wax >= 1000){
      wax /=1000;
      setState(() {
        unitWax = "Kg";
      });
    }else{
      setState(() {
        unitWax =  "g";
      });
    }
    if(fo >=1000){
      fo /= 1000;
      setState(() {
        unitOil =  "Kg";
      });
    }else{
      setState(() {
        unitOil = "g";
      });
    }

    setState(() {


      result_wax =  (wax.toStringAsFixed(2).toString());
      result_fo =  (fo.toStringAsFixed(2).toString());//* totalCandles;
    });
    print( result_fo);
    print( result_wax);
  }
}
// TextButton(
// child: Text('${gettranslated(context, "save")}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
//
// onPressed: () async {
// Candle candle = Candle(fragranceOil: fragranceOil*100, totalWeight: totalWeight, result_fo: result_fo, result_wax: result_wax);
// await SaveInShared.saveInShared(json.encode(Candle.toJson(candle)));
// // await SaveInShared.deleteMyList();
// print('in save');
//
// },
// ),