

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DetailsItems.dart';

class DetailsPage extends StatefulWidget {

  @override
  _DetailsPage createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage>{
  @override
  Widget build(BuildContext context) {
    String url;
   return Scaffold(
     appBar: AppBar(
       title: Text("FIRESTORE DATA"),
     ),
     body: MaterialApp(
         debugShowCheckedModeBanner: false,
         home: StreamBuilder(
         stream: Firestore.instance.collection('Details').snapshots(),
         builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           return ListView(
             children:
               snapshot.data.documents.map((doc) {
                 return  Card(
                     color: Colors.yellow[200],
                     child: Container(
                       width: MediaQuery.of(context).size.width * 0.7,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisSize: MainAxisSize.max,
                         children: [
                           Container(
                            child: //Image.network(doc['img']),
                              FutureBuilder(
                              future: _getImage(context,doc['img']),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  return Padding(
                                    padding: EdgeInsets.all(20),
                                    child:  Container(
                                      child: snapshot.data,
                                    ),
                                  );
                                }
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Container(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Container();
                              },
                            ),
                           ),
                           Container(
                             child: Text("Name: " + doc['name'],style: TextStyle(fontSize: 20),),
                           ),
                           Container(
                             child: Text("Phone: " + doc['phone'],style: TextStyle(fontSize: 20),),
                           ),
                           Container(
                             child: Text("Address: " + doc['address'],style: TextStyle(fontSize: 20),),
                           ),
                         ],
                       ),
                     ),
                 );
               }).toList(),
           );
         },
       )
     ),
   );

  }

  Future<Image> _getImage(BuildContext context,String img) async{
    Image m;
    m = Image.network(img,fit: BoxFit.scaleDown,);
    return m;
  }

}