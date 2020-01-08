import 'dart:convert' as convert;
import 'package:canamat8/config.dart';
import 'package:canamat8/models/product_model.dart';
import 'package:http/http.dart' as http;

class BackendService {

  Future<ProductModel> getProduct(int productId) async {

    ProductModel product = ProductModel();

    http.Response response = await http.get(
        Config.API_ENDPOINT + productId.toString(),
        headers: <String, String>{'Authorization': 'Bearer ' + Config.ACCESS_TOKEN}
    );

    if(response.statusCode >= 200) {
      product = ProductModel.fromJSON( convert.json.decode(response.body)['data']);
    }

    return product;
  }
}