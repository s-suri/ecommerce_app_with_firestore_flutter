import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surichatapp/screens/constants.dart';
import 'package:surichatapp/screens/detailsScreen.dart';
import 'package:surichatapp/screens/product.dart';

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({Key key, this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (_) => DetailsScreen(
                  id: product.id,title: product.title,imageurl: product.image,
                  price: product.price,color: product.color,description: product.description,)
            )
        );

            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            decoration: BoxDecoration(
              color: Color(int.parse(product.color)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Hero(
              tag: "${product.id}",
              child: Image.network(product.image),
            ),
            )
          ),


          Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Text("\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }
}



















class EcommerceItems extends StatelessWidget {
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> userMap;

  final String itemName;
  EcommerceItems({this.itemName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("E-commerce with cloud",style: TextStyle(
          fontSize: 25,
        ),
        ),
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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




                            itemBuilder: (context, index) {
                              Map<String, dynamic> map = snapshot.data.docs[index]
                                  .data() as Map<String, dynamic>;

                              return Container(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreen(
                                                    id:map['id'],title: map['title'],
                                                    imageurl: map['imageurl'],color:map['color'],
                                                    price: map['price'],description: map['description'])
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
                                            child: Image.network(map['imageurl']),
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
