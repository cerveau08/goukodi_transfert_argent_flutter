import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goukodi_transfert_flutter/helpers/interceptor.dart';
import 'package:goukodi_transfert_flutter/models/user.dart';
import 'package:goukodi_transfert_flutter/pages/Accueil.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_interceptor/http_with_interceptor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String username;
  var image;
  String role;
  User currentUser;

  @override
   void initState() {
    // TODO: implement initState
    super.initState();
    this.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red,),
            onPressed: () {
              Navigator.pop(context);
            }
          )
        ],
        backgroundColor: Colors.white,
        elevation: 50.0,
        leading: Icon(Icons.menu, color: Colors.black),
      ),
      body:  Column(
        
        children: <Widget>[
          
          Container(
            
            margin: EdgeInsets.all(20),
              child:Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset("assets/logoGOUKODY.png"),
                    ),
                  ),
                ],
              )
            
          ),
          (role != null)?
          Accueil(role): Text('Chargement' ),
        ],
      ),
    );
  }

  void  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profil = prefs.getString('role');
    String url = "http://10.0.2.2:8000/api/users/".toString();

    print(profil);

    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);
    var user = json.decode(res.body);
    setState(() {
      //this.image=user['image'];
     // this.username=user["prenom"] + " "+ user["nom"];
      this.role = prefs.getString('role');

    });
  }
}