import 'package:flutter/material.dart';
import 'package:trainaing1/services/localizationmethods.dart';


import '../screens/cost_calculator.dart';

class Result extends StatefulWidget {
  String wax;
  String oil;
  String unitWax;
  String unitOil;
  int totalCandel;
  Result(
      this.wax,
      this.oil,
      this.totalCandel,
      this.unitWax,
      this.unitOil
      );
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    Widget designResult(title, result, unit){
      return Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.width*.02),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width*.002,),
              //Expanded(
              //child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(result+unit,
                      style: TextStyle(
                        color: Color(0xff0E59C4),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ), textAlign: TextAlign.center,
                    ),
                  ),SizedBox(width: MediaQuery.of(context).size.width*.05,)
                ],
              ),


              //),
            ],
          ),
        ),
      );
    }
    return
      //Expanded(
      //flex: 7,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: MediaQuery.of(context).size.height/30,),
          Center(
            child: Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.02),
              width: MediaQuery.of(context).size.width *.78,
              height: (MediaQuery.of(context).size.height-
                  AppBar().preferredSize.height-
                  MediaQuery.of(context).padding.top
              )*0.4,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  designResult("${gettranslated(context, "wax you need :")}", widget.wax,widget.unitWax),
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                  designResult("${gettranslated(context, "oil you need :")}", widget.oil, widget.unitOil),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xff0E59C4),
                      child: Text("${gettranslated(context, "Cost Calculate")}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CostCalculator(
                                widget.wax,
                                widget.oil,
                                widget.totalCandel,
                                widget.unitOil,
                                widget.unitWax,
                              )),
                        );
                      }

                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}