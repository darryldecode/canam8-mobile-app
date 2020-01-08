import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:canamat8/config.dart';

class ServerHandler {

  static final ServerHandler _singleton = ServerHandler._internal();

  ServerHandler._internal();

  factory ServerHandler() {
    return _singleton;
  }

  void startServerAndListen(Function(int) function) async {

    var server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      Config.SERVER_PORT,
    );

    print('Listening on localhost: ${server.address.host}:${server.port}');

    await for (HttpRequest request in server) {

      final productId = request.uri.queryParameters['product_id'];

      if(productId != null) {
        function(int.parse(productId));
      }

      request.response.write('Command Received');

      await request.response.close();
    }
  }

  void switchLedOn(int R, int G, int B) async {

    String apiUrl = Config.LED_API;
    String token = Config.LED_API_TOKEN;
    String path = '/on';
    String param = '?token=' + token + '&r=' + R.toString() +  '&g=' + G.toString() + '&b=' + B.toString();

    final http.Response response = await http.get(apiUrl + path + param);

    if (response.statusCode == 200) {
      print('LED response ok');
    } else {
      print('LED response NOT OK');
    }
  }

  void switchLedOff() async {

    String apiUrl = Config.LED_API;
    String path = '/off';

    final http.Response response = await http.get(apiUrl + path);

    if (response.statusCode == 200) {
      print('LED response ok');
    } else {
      print('LED response NOT OK');
    }
  }
}