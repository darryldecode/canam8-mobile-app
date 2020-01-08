import 'package:canamat8/utils/helpers.dart';
import 'package:flutter/material.dart';

class ProductDescriptionWidget extends StatefulWidget {

  final String description;

  ProductDescriptionWidget({this.description});

  @override
  State<StatefulWidget> createState() {
    return _ProductDescriptionWidget();
  }
}

class _ProductDescriptionWidget extends State<ProductDescriptionWidget> {

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
              child: Text('Description', style: TextStyle(fontSize: vw * 0.025, fontWeight: FontWeight.bold),)
          ),
          Text(Helpers.substringEllipsis(widget.description, 250),style: TextStyle(fontSize: vw * 0.017, fontWeight: FontWeight.normal),),
        ],
      ),
    );
  }
}