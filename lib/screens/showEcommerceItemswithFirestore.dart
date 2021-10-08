import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surichatapp/screens/constants.dart';
import 'package:surichatapp/story/data.dart';
import 'package:surichatapp/story/storyScreen.dart';
import 'package:uuid/uuid.dart';
import 'detailsScreen.dart';

class ShowEcommerceItemsWithFirestore extends StatelessWidget
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> userMap;
  final String itemName;
  ShowEcommerceItemsWithFirestore({this.itemName});
  File imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    debugPrint("start debug");
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('EcommerceItems')
        .doc(itemName)
        .collection('item')
        .doc(fileName)
        .set({
      "imageurl": 'https://firebasestorage.googleapis.com/v0/b/icfautech.appspot.com/o/images%20(49).jpeg?alt=media&token=9915c100-0f69-44c2-9042-a15aa00bd2f1',
      "id": "1",
      "title": "surender kumar",
      "color": "0xFF3D82AE",
      "price":"30",
      "description": "this is a best ecommerce site",
      "time": FieldValue.serverTimestamp(),
    });

    debugPrint("run debug");

    var ref = FirebaseStorage.instance.ref().child('Ecommerce').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile).catchError((error) async {
      await _firestore
          .collection('EcommerceItems')
          .doc(itemName)
          .collection('item')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('EcommerceItems')
          .doc(itemName)
          .collection('item')
          .doc(fileName)
          .update({"imageurl": imageUrl});

      print(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp",style: TextStyle(
          fontSize: 25,
        ),
        ),

        actions: [
          IconButton(onPressed: ()=> getImage(), icon: Icon(Icons.upload)),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
              constraints: BoxConstraints(
                  maxHeight: 130
              ),
              decoration: BoxDecoration(
              ),
              child: StoryScreen(stories: stories),
            ),

            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('EcommerceItems')
                    .doc(itemName)
                    .collection('item')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                        child: GridView.builder(
                            itemCount: snapshot.data.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: kDefaultPaddin,
                              crossAxisSpacing: kDefaultPaddin,
                              childAspectRatio: 0.75,
                            ),

//                            itemBuilder: (context, index) => ItemCard(product: products[index],
//                              press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(product: products[index],)
//                                  ,)
//                                ,)
//                              ,)




                            itemBuilder: (context, index) {
                              Map<String, dynamic> map = snapshot.data.docs[index]
                                  .data() as Map<String, dynamic>;

                              return Container(
                                child: GestureDetector(
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(id:map['id'],title: map['title'],imageurl: map['imageurl'],
                                                color:map['color'],price: map['price'],description: map['description'])
                                      )
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(kDefaultPaddin),
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(map['color'])),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Hero(
                                            tag: "${map['id']}",
                                            child: Image.network('https://firebasestorage.googleapis.com/v0/b/icfautech.appspot.com/o/images%20(49).jpeg?alt=media&token=9915c100-0f69-44c2-9042-a15aa00bd2f1'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
                                        child: Text(
                                          // products is out demo list
                                          map['title'],
                                          style: TextStyle(color: kTextLightColor),
                                        ),
                                      ),
                                      Text(
                                        "\$${map['price']}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              );

                            }
                        ),
                      ),
                    );

                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

