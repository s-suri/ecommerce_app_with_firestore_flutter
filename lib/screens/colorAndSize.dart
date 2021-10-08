import 'package:flutter/material.dart';
import 'package:surichatapp/screens/Product.dart';
import 'package:surichatapp/screens/constants.dart';
import 'package:surichatapp/screens/home_screen.dart';


class ColorAndSize extends StatelessWidget
{
  final Product product;

  const ColorAndSize({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Color"),
            Row(
              children: [
                ColorDot(
                  color: Color(0xFF356c95),

                ),

                ColorDot(
                  color: Color(0xFFF8c078),
                ),
                ColorDot(
                  color: Color(0xFFA29B9B),
                ),
              ],
            )
          ],
          )
        ),

        Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: kTextColor
                ),
                children: [
                  TextSpan(text: "Size\n"),
                  TextSpan(
                    text: "${product.size} cm",
                    style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                  )
                ]
              ),
          )
        )
      ],
    );
  }
}


class ColorDot extends StatelessWidget{
  final Color color;
  final bool isSelected;
  const ColorDot({Key key, this.color, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPaddin / 4,
        right: kDefaultPaddin / 2,
      ),

      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        )
      ),

      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
        ),
      ),
    );
  }

}
