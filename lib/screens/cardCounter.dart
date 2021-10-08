import 'package:flutter/material.dart';
import 'package:surichatapp/screens/constants.dart';

class CardCounter extends StatefulWidget {
  @override
  _CardCounterState createState() => _CardCounterState();
}

class _CardCounterState extends State<CardCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuiidOutlineButtine(
          icon: Icons.remove,
          press: () {
            if(numOfItems > 1)
              {
                setState(() {
                  numOfItems--;
                });
              }
          }
        ),

        Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2,"0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        BuiidOutlineButtine(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems++;
            });
          }
        )
      ],
    );
  }

SizedBox BuiidOutlineButtine({IconData icon, Function press})
{
  return SizedBox(
    width: 40,
    height: 32,
    child: OutlineButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),

      onPressed: press,
      child: Icon(icon),
    ),
  );
}

}
