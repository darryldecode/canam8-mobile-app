import 'package:canamat8/models/attribute_model.dart';
import 'package:flutter/material.dart';

class ProductAttributeOverlayGridWidget extends StatelessWidget {

  final List<AttributeModel> attributes;

  const ProductAttributeOverlayGridWidget({this.attributes});

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    print('generating..');

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(attributes.length, (index){
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200])
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('${attributes[index].value}%', style: TextStyle(fontSize: vw * 0.028, fontWeight: FontWeight.bold),),
                Text(attributes[index].name, style: TextStyle(fontSize: vw * 0.018, color: Colors.green),),
              ],
            ),
          ),
        );
      }),
    );
  }
}