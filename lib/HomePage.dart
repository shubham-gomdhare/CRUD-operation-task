
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DetailsPage.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var img = ImagePicker();
  File sel;
  String text = "No image selected";
  String url;
  bool _validateName = false;
  bool _validatePhone = false;
  bool _validateAddress = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Operation"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextField(
                    controller: _name,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: 'NAME',
                        errorText: _validateName ? 'Value Can\'t Be Empty' : null,
                        contentPadding: EdgeInsets.only(
                            top: 0, right: 0, left: 10, bottom: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: 'PHONE',
                        errorText: _validatePhone ? 'Value Can\'t Be Empty' : null,
                        contentPadding: EdgeInsets.only(
                            top: 0, right: 0, left: 10, bottom: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextField(
                    controller: _address,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: 'ADDRESS',
                        errorText: _validateAddress ? 'Value Can\'t Be Empty' : null,
                        contentPadding: EdgeInsets.only(
                            top: 0, right: 0, left: 10, bottom: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: RaisedButton.icon(
                    onPressed: () async {
                      //img = ImagePicker.pickImage(source: ImageSource.gallery);
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text("$text"),
                SizedBox(
                  height: 40,
                ),
                RaisedButton.icon(
                  onPressed: () {
                    uploadImageToFirebase(sel,_name.text,_phone.text,_address.text);
                    print(url);
                    text = "No image selected";
                  },
                  icon: Icon(Icons.cloud_done_rounded),
                  label: Text("SUBMIT"),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage()),
          );
        },
        tooltip: 'COLLECTION LIST',
        child: Icon(Icons.cloud),
      ),
    );
  }

  Future uploadImageToFirebase(file,String name, String phone, String address) async {
    _name.text.isEmpty ? _validateName = true : _validateName = false;
    _phone.text.isEmpty ? _validatePhone = true : _validatePhone = false;
    _address.text.isEmpty ? _validateAddress = true : _validateAddress = false;
      String filePath = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref().child('/images').child(filePath);
      storageReference.putFile(file).whenComplete(() async {
        url = await storageReference.getDownloadURL();
        await Firestore.instance.collection('Details').add({
          'img': url,
          'name': name,
          'phone': phone,
          'address':address,
        });
      });
      _name.clear();
      _phone.clear();
      _address.clear();
      sel = null;
      url= null;
  }
}
