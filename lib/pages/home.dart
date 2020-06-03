import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goukodi_transfert_flutter/helpers/interceptor.dart';
import 'package:goukodi_transfert_flutter/models/user.dart';
import 'package:goukodi_transfert_flutter/pages/Accueil.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_interceptor/http_with_interceptor.dart';

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
      body:  Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)
            ),
            child: Container(
              color: Colors.white,
              child:Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:20),
                    alignment: Alignment.center,
                    child: Center(
                      child:CircleAvatar(
                        radius: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:(currentUser!= null)? Image.memory(base64.decode(currentUser.imageProfil),height: 125,width: 125,fit: BoxFit.cover,) : null
                        )
                      ),
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Container(
                        child: Text(
                          (currentUser==null)? "Salut" : currentUser.username ,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      )
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child:Container(
                        child: Text(
                          (currentUser==null)? "@" : "@"+currentUser.roles ,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      )
                    )
                  ),
                  RaisedButton(
                    child: Text('Deconnection'),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  )
                ],
              )
            )
          ),
          (role != null)?
          Accueil(role): Text('Chargement')
        ],
      ),
    );
  }

  void  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("id");
    var role = prefs.getString('role');
    String url = "http://10.0.2.2:8000/api/users/"+id.toString();

    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);
    var user = json.decode(res.body);
    setState(() {
      //this.image=user['image'];
      currentUser=new User(user["email"], user["password"], user['username'], user["roles"][0],user["imageProfil"],user["isActive"],user["id"]);
     // this.username=user["prenom"] + " "+ user["nom"];
      this.role=prefs.getString('role');

    });
    print(currentUser.roles);
  }
}