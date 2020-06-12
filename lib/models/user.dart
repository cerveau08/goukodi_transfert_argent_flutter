import 'package:goukodi_transfert_flutter/models/profil.dart';

class User{

  String email;
  String password;
  String username;
  Profil profil;
  String roles;
  bool isActive;
  int id;
  var imageProfil;

  User(this.email,this.password,this.username,this.roles,this.isActive,this.id);
}