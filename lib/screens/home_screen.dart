import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:surichatapp/screens/cardItem.dart';
import 'package:surichatapp/screens/constants.dart';
import 'package:surichatapp/screens/product.dart';
import 'package:surichatapp/screens/showEcommerceItemswithFirestore.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return screenState();
  }
}

class screenState extends State<HomeScreen> {
  List<String> categories = ["Home","Pent", "Shirt", "Jeans","T-shirt","Coat"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Text(
                "jents and ladies",
                style: Theme.of(context).textTheme.headline5
                    .copyWith(
                  color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),

                    itemBuilder: (context, index) => ItemCard(product: products[index],)),
              ),
            )
          ],
        ),
      )
    );
  }


  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (_) => ShowEcommerceItemsWithFirestore(itemName: index.toString(),)));

        debugPrint(index.toString());
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            debugPrint("search");
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            color: kTextColor,
          ),
          onPressed: () {
            debugPrint("cart");
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}


