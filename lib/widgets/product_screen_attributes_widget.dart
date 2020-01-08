import 'package:canamat8/events/more_attribute_event.dart';
import 'package:canamat8/models/attribute_model.dart';
import 'package:flutter/material.dart';
import 'package:rxbus/rxbus.dart';

class ProductAttributesWidget extends StatelessWidget {

  final List<AttributeModel> attributes;

  ProductAttributesWidget({this.attributes});

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    // we will only display 3 attributes based on our UX
    AttributeModel attribute1 = (!attributes.isEmpty) ? attributes[0] : AttributeModel();
    AttributeModel attribute2 = (!attributes.isEmpty) ? attributes[1] : AttributeModel();
    AttributeModel attribute3 = (!attributes.isEmpty) ? attributes[2] : AttributeModel();

    return Container(
      decoration: BoxDecoration(
          color: Colors.lightGreen[900],
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.yellow[800],
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: FlatButton(
              color: Colors.transparent,
              onPressed: (){
                print('more attribute clicked');
                RxBus.post(MoreAttributeEvent());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 25,),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${attribute1.value}%',style: TextStyle(fontSize: vw * 0.025, fontWeight: FontWeight.bold, color: Colors.yellow[800]),),
                Text('${attribute1.name}%',style: TextStyle(fontSize: vw * 0.015, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${attribute2.value}%',style: TextStyle(fontSize: vw * 0.025, fontWeight: FontWeight.bold, color: Colors.yellow[800]),),
                Text('${attribute2.name}%',style: TextStyle(fontSize: vw * 0.015, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${attribute3.value}%',style: TextStyle(fontSize: vw * 0.025, fontWeight: FontWeight.bold, color: Colors.yellow[800]),),
                Text('${attribute3.name}%',style: TextStyle(fontSize: vw * 0.015, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            ),
          )
        ],
      ),
    );
  }
}