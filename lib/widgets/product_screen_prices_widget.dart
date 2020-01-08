import 'package:canamat8/models/price_model.dart';
import 'package:flutter/material.dart';

class ProductPricesWidget extends StatelessWidget {

  final List<PriceModel> prices;

  ProductPricesWidget({this.prices});

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(right: 15),
              child: Image(image: AssetImage('assets/images/label_prices.png'),)
          ),
        ),
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for(PriceModel price in prices)
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 90,
                    height: 90,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(70)),
                          child: Center(child: Text(price.label, style: TextStyle(fontSize: vw * 0.03, fontWeight: FontWeight.bold),)),
                        ),
                        Positioned(
                          bottom: 5,
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(30)),
                            child: Center(child: Text('\$${price.price}', style: TextStyle(fontSize: vw * 0.015, fontWeight: FontWeight.bold),)),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}