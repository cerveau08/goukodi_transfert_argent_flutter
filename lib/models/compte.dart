import 'package:goukodi_transfert_flutter/models/depot.dart';
import 'package:goukodi_transfert_flutter/models/partenaire.dart';
import 'package:goukodi_transfert_flutter/models/user.dart';

class Compte{

  Partenaire partenaire;
  User userComptePartenaire;
  int id;
  int solde;
  int numero;
  String iri;


  Depot depot;
  Compte({this.id,this.solde,this.numero,this.partenaire,this.depot,this.iri});

  Map<String , dynamic> toJson()=>
      {
        'partenaire': {
          'registreCommercial':partenaire.registreCommercial,
          'ninea':partenaire.ninea,
          'nomComplet': partenaire.nomComplet,
          'adresse': partenaire.adresse,
          'telephone': partenaire.telephone,
          'userComptePartenaire':[ {
            "username":userComptePartenaire.username,
            "password":userComptePartenaire.password,
            "email":userComptePartenaire.email,
          }]
        },
        'depots':[{
          "montant":depot.montant
        }
        ]
      };
}