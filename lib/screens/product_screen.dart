import 'package:canamat8/animations/route_transition_scale.dart';
import 'package:canamat8/models/product_model.dart';
import 'package:canamat8/services/server_handler.dart';
import 'package:canamat8/widgets/product_screen_attributes_overlay_widget.dart';
import 'package:canamat8/widgets/product_screen_attributes_widget.dart';
import 'package:canamat8/widgets/product_screen_description.dart';
import 'package:canamat8/widgets/product_screen_details_widget.dart';
import 'package:canamat8/widgets/product_screen_effects_widget.dart';
import 'package:canamat8/widgets/product_screen_prices_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {

  final ProductModel product;

  ProductScreen({@required this.product});

  @override
  _ProductScreenState createState() {
    return _ProductScreenState();
  }
}

class _ProductScreenState extends State<ProductScreen> {

  bool _visible = false;

  @protected
  void initState() {
    super.initState();

    new Future.delayed(const Duration(milliseconds: 1500), ()=> {
      setState((){
        _visible = true;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedOpacity(
          opacity:_visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 1000),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 10,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: ProductDetailsWidget(product: widget.product,),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: ProductPricesWidget(prices: widget.product.prices,),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: ProductAttributesWidget(attributes: widget.product.attributes,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            ServerHandler().switchLedOff();
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.done, color: Colors.white, size: 25,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15, right: 15, bottom: 15, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: ProductEffectsWidget(effects: widget.product.effects,),
                          ),
                          Expanded(
                            flex: 6,
                            child: ProductDescriptionWidget(description: widget.product.description,),
                          )
                        ],
                      ),
                    ),
                    ProductAttributeOverlayWidget(attributes: widget.product.attributes,),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(context, RouteTransitionScale(page: DescriptionHero(description: widget.product.description,)));
                          },
                          child: Icon(Icons.add, color: Colors.white, size: 25,),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionHero extends StatelessWidget {

  final String description;

  DescriptionHero({this.description});

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Description', style: TextStyle(fontSize: vw * 0.03, fontWeight: FontWeight.bold, color: Colors.green[700]),),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(description,style: TextStyle(fontSize: vw * 0.017, fontWeight: FontWeight.normal),),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: FlatButton(
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.white, size: 25,),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}