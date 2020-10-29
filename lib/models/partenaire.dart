import 'package:goukodi_transfert_flutter/models/user.dart';

class Partenaire{
  String ninea;
  String registreCommercial;
  String adresse;
  String nomComplet;
  String telephone;
  User userComptePartenaire;

  Partenaire({this.ninea,this.registreCommercial, this.adresse, this.nomComplet, this.telephone,this.userComptePartenaire});

  Map<String , dynamic> toJson()=>
      {
        'partenaire': {
          'registreCommercial': registreCommercial,
          'ninea': ninea,
          'nomComplet': nomComplet,
          'adresse': adresse,
          'telephone': telephone,
          'userComptePartenaire': {
            "username":userComptePartenaire.username,
            "password":userComptePartenaire.password,
            "email":userComptePartenaire.email,
          }
        }
      };
}