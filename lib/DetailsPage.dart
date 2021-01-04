import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPage createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage>{

  var img = ImagePicker();
  File sel;
  String text = "No image selected";
  String url;
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _mail = TextEditingController();
  String dateTime = DateTime.now().toString();
  String d = DateTime.now().day.toString();
  String m = DateTime.now().month.toString();
  String y = DateTime.now().year.toString();
  @override
  Widget build(BuildContext context) {
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
                 return GestureDetector(
                   child: Card(
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
                             child: Text("mail: " + doc['mail'],style: TextStyle(fontSize: 20),),
                           ),
                           Container(
                             child: Text("date: " + doc['date'],style: TextStyle(fontSize: 20),),
                           ),
                         ],
                       ),
                     ),
                   ),
                   onTap: (){
                     showAlert(context, doc.id,doc['img']);
                   },
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

  Future _delete(id,imgUrl) async{
    await Firestore.instance.collection('Details').doc(id).delete().whenComplete(() {
      FirebaseStorage.instance.refFromURL(imgUrl).delete();
    });
  }
  showAlert(BuildContext context,id,imgUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('MENU'),
          content: Text("UPDATE or DELETE?"),
          actions: <Widget>[
            FlatButton(
              child: Text("UPDATE"),
              onPressed: () {
                _openPopup(context,id);
              },
            ),

            FlatButton(
              child: Text("DELETE"),
              onPressed: () {
                _delete(id, imgUrl);
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _openPopup(context,id) {
    Alert(
        context: context,
        title: "UPDATE DETAILS",
        content: Column(
          children: <Widget>[
            TextField(
              controller: _name,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _phone,
              decoration: InputDecoration(
                icon: Icon(Icons.phone_android_outlined),
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: _mail,
              decoration: InputDecoration(
                icon: Icon(Icons.directions),
                labelText: 'Email ID',
              ),
            ),
            RaisedButton.icon(
              onPressed: () async {
                var pickedFile = await img.getImage(
                    source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    sel = File(pickedFile.path);
                    text = sel.path;
                  }
                });
              },
              icon: Icon(Icons.image),
              label: Text("Pick Image"),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              String date = '$d-$m-$y';
              String filePath = DateTime.now().millisecondsSinceEpoch.toString();
              Reference storageReference =
              FirebaseStorage.instance.ref().child('/images').child(filePath);
              storageReference.putFile(sel).whenComplete(() async {
                url = await storageReference.getDownloadURL();
                await Firestore.instance.collection('Details').doc(id).update({
                  'img': url,
                  'name': _name.text,
                  'phone': _phone.text,
                  'address':_mail.text,
                  'date': date,
                });
              });
              Navigator.of(context).pop();
            },
            child: Text(
              "UPDATE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  }