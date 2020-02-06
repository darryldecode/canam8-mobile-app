import 'package:canamat8/animations/route_transition_scale.dart';
import 'package:canamat8/models/product_model.dart';
import 'package:canamat8/screens/product_screen.dart';
import 'package:canamat8/services/backend_service.dart';
import 'package:canamat8/services/bluetooth_handler.dart';
import 'package:canamat8/utils/helpers.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @protected
  void initState() {
    super.initState();

    BluetoothHandler bluetoothHandler = BluetoothHandler();
    bluetoothHandler.connectAndListen((String data){
      String event = data.split("|")[0].split("_")[1];
      String uniqueUrl = data.split("|")[1].split("_")[1];
      print("Event: " + event);
      print("Content: " + uniqueUrl);

      if(event == 'rfid') {
        BackendService().getProduct(Uri.encodeFull(uniqueUrl)).then((ProductModel product) {

          // turn on LED
          Map<String,num> rgb = Helpers.hexToRGB(product.categories[0].color);
          bluetoothHandler.switchLedOn(rgb['r'], rgb['g'], rgb['b']);

          // show product
          Navigator.push(context,RouteTransitionScale(page: ProductScreen(product: product,)));
        });
      } else if(event == 'rfid-detach') {
        Navigator.pop(context);
      }
    });

//    ServerHandler serverHandler = ServerHandler();
//
//    serverHandler.startServerAndListen((int productId){
//
//      // get product details from backend server.
//      BackendService().getProduct(productId).then((ProductModel product) {
//
//        // turn on LED
//        Map<String,num> rgb = Helpers.hexToRGB(product.categories[0].color);
//        serverHandler.switchLedOn(rgb['r'], rgb['g'], rgb['b']);
//
//        // show product
//        Navigator.push(context,RouteTransitionScale(page: ProductScreen(product: product,)));
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}