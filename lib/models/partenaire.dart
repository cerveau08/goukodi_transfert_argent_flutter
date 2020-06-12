import 'package:goukodi_transfert_flutter/models/user.dart';

class Partenaire {
  String ninea;
  String registreCommercial;
  String nomComplet;
  String telephone;
  String adresse;
  User userComptePartenaire;

  Partenaire({this.ninea, this.registreCommercial, this.nomComplet, this.telephone, this.adresse, this.userComptePartenaire});
}