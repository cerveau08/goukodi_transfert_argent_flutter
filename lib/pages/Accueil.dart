import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goukodi_transfert_flutter/pages/CreateComptePartenaire.dart';
import 'package:goukodi_transfert_flutter/pages/createUser.dart';
import 'package:goukodi_transfert_flutter/pages/listUser.dart';

class Accueil extends StatefulWidget {
  final role;
  Accueil(this.role);
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  List<Items> myList=[];
  final Items item1 = new Items(
      title: "Creation de users",
      event: "",
      img: "assets/adduser.png",
      route : CreateUser())
  ;

  final Items item2 = new Items(
      title: "Gestion users",
      event: "",
      img: "assets/modiuser.png",
      route : listUsers()
  );
  final Items item3 = new Items(
      title: "Creer Compte ",
      event: "",
      img: "assets/partner.png",
      route: CreateComptePartenaire()
  );
  final Items item4 = new Items(
    title: "Faire Dépot",
    event: "",
    img: "assets/depot.png",
  );
  final  Items item5 = new Items(
    title: "Affectation Comptes",
    event: "",
    img: "assets/modiuser.png",
  );
  final Items item6 = new Items(
    title: "Transaction",
    event: "",
    img: "assets/depot.png",
  );
  getItems(){
    if(this.widget.role=="ROLE_ADMIN_SYSTEM" || this.widget.role=="ROLE_ADMIN"){
      myList = [item1, item2, item3, item4];
    }if(this.widget.role=="ROLE_CAISSIER"){
      myList = [item4];
    }if(this.widget.role=="ROLE_PARTENAIRE" || this.widget.role=="ROLE_ADMIN_PARTENAIRE"){
      myList = [item5,item6];
    }if(this.widget.role=="ROLE_CAISSIER_PARTENAIRE"){
      myList = [item6];
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    var color = 0xff453658;

    return Flexible(
      child:
      (myList!=[])?
      GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children:
          myList.map((data) {
            return new GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => data.route ),
                  );
                },
                child:
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent, borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black12),
                    
                  ),
                  
                  height: 120,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        data.img,
                        width: 70,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            )),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        data.event,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 11,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ));
          }).toList())
            :null );
     }
  }


class Items {
  String title;
  String event;
  String img;
  var route ;
  Items({this.title, this.event, this.img,this.route});
}