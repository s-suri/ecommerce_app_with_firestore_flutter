import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surichatapp/screens/cardCounter.dart';
import 'package:surichatapp/screens/constants.dart';


class DetailsScreen extends StatelessWidget {
  final String id, title, imageurl, price, color, description;

  DetailsScreen({this.id, this.title, this.imageurl,this.price, this.color, this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.3
                    ),

                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )
                    ),

                    child: Column(
                      children: [
                        SizedBox(
                          height: kDefaultPaddin / 2,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
                          child: Text(
                            description, style: TextStyle(height: 1.5),
                          ),
                        ),

                        SizedBox(height: kDefaultPaddin / 2,),

                        CardCounter(),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              padding: EdgeInsets.all(8),
                              height: 50,
                                width: 59,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.blue,
                                )
                              ),

                              child: IconButton(
                                icon: SvgPicture.asset("assets/icons/add_to_cart.svg",
                               //   color: Color(int.parse(color))
                                ),
                                onPressed: (){
                                  debugPrint("add to cart");
                                },
                              ),
                            ),

                            SizedBox(width: 15,),

                            Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: (){
                                      debugPrint("Buy now");
                                    },

                                    child: Text(
                                      "Buy now".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                )
                            ),

                          ],
                         )
                      ],
                    ),
                  ),


                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Awesome Item",
                          style: TextStyle(
                            color: Colors.white
                          ),

                        ),

                        Text(title, style:  Theme.of(context)
                          .textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Price\n", style: TextStyle(
                                      color: Colors.white
                                    )),

                                    TextSpan(
                                      text: "\$${price}",style: Theme.of(context)
                                        .textTheme.headline4.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.bold,
                                    )
                                    )
                                  ]
                                ),
                              ),
                            ),

                            SizedBox(width: kDefaultPaddin,),
                            Expanded(child: Hero(
                              tag: "${id}",
                              child: Image.network(
                                imageurl,
                                width:  100,
                                height: 200,
                              ),
                              )
                            )
                          ],

                        )


                      ],
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: ()=> Navigator.pop(context),
      ),

      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),

        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/cart.svg"),

        )
      ],
    );
  }

}
