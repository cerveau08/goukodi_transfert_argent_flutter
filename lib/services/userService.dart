

import 'dart:convert';

import 'package:goukodi_transfert_flutter/helpers/interceptor.dart';
import 'package:goukodi_transfert_flutter/models/user.dart';
import 'package:http_interceptor/http_interceptor.dart';

class UserService{
  final  headers = {
  "Accept": "application/json",
  "Content-Type": "application/json"

  };

  createUser(user) async{
    String url = "http://10.0.2.2:8000/api/users";

      return  await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .post(url,body:user,headers: headers);
  }
  getUsers() async{
    String url = "http://10.0.2.2:8000/api/users";

  var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);
    var usera = json.decode(res.body);

var user = usera["hydra:member"];
    List<User> users =[];
    for(var u in user){
      User mesuser = new User(u["email"], u["password"], u['username'], u["profil"][0],u["isActive"],u["id"]);
      users.add(mesuser);
    }
    return users;

  }
  bloquer(id,body) async{
    String url = "http://10.0.2.2:8000/api/users/"+id.toString();

    var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .put(url,body:json.encode(body),headers: headers);
    print(res.body);
  }
  }

