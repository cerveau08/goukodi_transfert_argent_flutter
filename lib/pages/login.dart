import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goukodi_transfert_flutter/pages/home.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token;
  String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'GOUKODI',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: (error == null)?
              Text( 
                "Connectez-vous",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                ),
              ):
              Text(error,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username'
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Se Connecter'),
                onPressed: () {
                  login(
                    usernameController.text, 
                    passwordController.text
                  );
                },
              ),
            )
          ],
        )
      ),
    );
  }
  
  void login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(usernameController.text);
    print(passwordController.text);
    String url = "http://10.0.2.2:8000/api/login_check";
    var body = {
      "username": username,
      "password": password
    };
    var reponse = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: json.encode(body)
    );
    if(reponse.statusCode>=200 && reponse.statusCode < 400){
      this.token = json.decode(reponse.body)['token'];
      prefs.setString('token', this.token);

      // decodage token
      final String token = this.token;
      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);

      var tok = json.decode(decoded);
      prefs.setString('role', tok["roles"][0]);
      var profil = prefs.getString('role');
      print(profil);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home()
        )
      );
      print(profil);

    }else{
      error = json.decode(reponse.body)['message'];
      print(error);
      if(error=="Invalid credentials."){
      setState(() {
        error="Identifiants Incorrects";
      });
      }else{
        setState(() {
          error=error;
        });
      }
    }
  }
}