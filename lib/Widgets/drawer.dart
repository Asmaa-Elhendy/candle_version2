import 'package:flutter/material.dart';
import 'package:trainaing1/models/languagemodel.dart';
import 'package:trainaing1/screens/contact.dart';
import 'package:trainaing1/screens/display.dart';
import 'package:trainaing1/services/localizationmethods.dart';

import '../main.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("${gettranslated(context, "Choose Your Direction")}"),
            backgroundColor: Color(0xff0E59C4),
            automaticallyImplyLeading: false,
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text("${gettranslated(context, "Your Templates")}"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Display();
                  }
              ));
            },
          ), ListTile(
            leading: Icon(Icons.account_balance_outlined),
            title: Text("${gettranslated(context, "Candles academy")}"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Contact();
                  }
              ));
            },
          ),

          Divider(),
          Expanded(
            child:  ListView(
              children: <Widget>[
                Theme(
                  // ignore: deprecated_member_use
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent,splashColor:Colors.purple[100] ),

                  child:      ExpansionTile(
                    leading: Icon(Icons.language),
                    title: Text('${gettranslated(context, "App Language")}'),
                    children: <Widget>[
                      ListTile(
                        leading: Text(Language.list[0].flag,),
                        title: Text('${gettranslated(context, 'English')}'),
                        onTap: (){
                          changelanguage(context,Language.list[0]);
                        },
                      ),
                      ListTile(
                        leading: Text(Language.list[1].flag),
                        title:  Text('${gettranslated(context, 'Arabic')}'),
                        onTap: (){
                          changelanguage(context,Language.list[1]);
                        },
                      ),
                    ],


                  ),
                )
              ],
            ),

          ),




        ],
      ),
    );
  }
}