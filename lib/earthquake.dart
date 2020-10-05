import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Model{
  String tarih;
  String saat;
  String enlem;
  String boylam;
  String derinlik;
  String siddet;
  String yer;
  String tip;
  Model(
      this.derinlik,
      this.boylam,
      this.enlem,
      this.yer,
      this.tip,
      this.siddet,
      this.saat,
      this.tarih
      );

  Model.fromJson(Map<String, dynamic> json){
    tarih = json[' tarih'];
    saat = json['saat'];
    enlem = json['enlem'];
    boylam = json['boylam'];
    derinlik = json['derinlik'];
    siddet = json['siddet'];
    yer = json['yer'];
    tip = json['tip'];
  }
}

class eartquakw extends StatefulWidget {
  @override
  _eartquakwState createState() => _eartquakwState();
}

class _eartquakwState extends State<eartquakw> {
  List<Model> _list=List<Model>();

  Future<List<Model>> fetchNotes() async {

    var url = "https://deprem.odabas.xyz/api/pure_api.php";

    var response = await http.get(url);

    var notes = List<Model>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);


      for (var noteJson in notesJson) {
        notes.add(Model.fromJson(noteJson));




      }
    }
    return notes;
  }
  @override
  void initState() {
    fetchNotes().then((value) {

      setState(() {
        _list.addAll(value);
        print(_list.length);



      });
    });
    super.initState();
    //initial();

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey,
      body: ListView.builder(
          itemBuilder:(context,index){

return Card(
  color: Colors.black,

child: Padding(

  padding: const EdgeInsets.only( right: 10.0,),

child: Column(

children:<Widget> [
new Padding(padding: EdgeInsets.only(left: 10,right: 20),

child: Text("SAAT:"+_list[index].saat,

style: TextStyle(

  color: Colors.red,
  fontSize: 20,
  fontWeight: FontWeight.bold,

),


),




),



  Stack(

    children: <Widget>[
Text(

  "ŞİDDET:"+_list[index].siddet,
  style: TextStyle(
    color: Colors.yellow,
    fontWeight: FontWeight.bold,


  ),

),





    ],





  ),
  Stack(

    children: <Widget>[
      Text(

        "ŞİDDET:"+_list[index].yer,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,


        ),

      ),





    ],





  )




],


),






),







);




    },

      ),
    );
  }
}
