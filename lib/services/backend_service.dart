import 'dart:convert' as convert;
import 'package:canamat8/config.dart';
import 'package:canamat8/models/product_model.dart';
import 'package:http/http.dart' as http;

class BackendService {

  Future<ProductModel> getProduct(productId) async {

    ProductModel product = ProductModel();

    String endPoint = Config.API_ENDPOINT + "/products/get-by-url?pid=" + productId.toString();

    print("Accessing backend at: " + endPoint);

    http.Response response = await http.get(
        endPoint,
        headers: <String, String>{'Authorization': 'Bearer ' + Config.ACCESS_TOKEN}
    );

    if(response.statusCode >= 200) {
      product = ProductModel.fromJSON( convert.json.decode(response.body)['data']);
    }

    return product;
  }
}