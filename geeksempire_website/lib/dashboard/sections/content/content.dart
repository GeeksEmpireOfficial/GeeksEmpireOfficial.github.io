import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/sections/content/provider/content_data_structure.dart';

class Item extends StatefulWidget {

  ContentDataStructure contentDataStructure;

  Item({Key? key, required this.contentDataStructure}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}
class _ItemState extends State<Item> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(137, 137, 137, 79),
        child: Container(
          color: Colors.greenAccent,
          height: 131,
        )
    );
  }

}