import 'dart:math';

import 'package:canamat8/models/attribute_model.dart';
import 'package:canamat8/models/category_model.dart';
import 'package:canamat8/models/effect_model.dart';
import 'package:canamat8/models/grower_model.dart';
import 'package:canamat8/models/image_model.dart';
import 'package:canamat8/models/price_model.dart';

class ProductModel {

  String name;
  String description;
  String uniqueUrl;
  ImageModel primaryPhoto = new ImageModel();
  GrowerModel grower = new GrowerModel();
  List<CategoryModel> categories = [];
  List<EffectModel> effects = [];
  List<AttributeModel> attributes = [];
  List<PriceModel> prices = [];
  List<ImageModel> gallery = [];

  ProductModel({
    this.name,
    this.description,
    this.uniqueUrl,
    this.primaryPhoto,
    this.categories,
    this.grower,
    this.effects,
    this.attributes,
    this.prices,
    this.gallery,
  });

  factory ProductModel.fromEmpty() {

    return ProductModel(
      name: '',
      description: '',
      uniqueUrl: '',
      categories: [],
      effects: [],
      attributes: [],
      prices: [],
      gallery: [],
    );
  }

  factory ProductModel.fromJSON(Map<String, dynamic> json) {

    ProductModel product = ProductModel(
      name: json['name'],
      description: json['description'],
      uniqueUrl: json['unique_url'],
      categories: [],
      effects: [],
      attributes: [],
      prices: [],
      gallery: [],
    );

    product.primaryPhoto = ImageModel(
      name: json['primary_photo']['name'],
      fullUrl: json['primary_photo']['full_url'],
      extension: json['primary_photo']['extension'],
    );

    product.grower = GrowerModel(
      name: json['grower']['name'],
      address: json['grower']['address'],
    );

    Iterable categories = json['categories'];
    categories.forEach((data) => {
      product.categories.add(CategoryModel(
        name: data['name'],
        color: data['color'],
        icon: ImageModel(
          name: data['icon']['name'],
          fullUrl: data['icon']['full_url'],
          extension: data['icon']['extension'],
        )
      ))
    });

    Iterable effects = json['effects'];
    effects.forEach((data) => {
      product.effects.add(EffectModel(
        name: data['name'],
        value: data['value'],
        group: data['group'],
      ))
    });

    Iterable attributes = json['attributes'];
    attributes.forEach((data) => {
      product.attributes.add(AttributeModel(
        name: data['name'],
        value: data['value'],
        group: data['group'],
      ))
    });

    Iterable prices = json['prices'];
    prices.forEach((data) => {
      product.prices.add(PriceModel(
        label: data['label'],
        price: double.parse(data['price']),
      ))
    });

    Iterable gallery = json['gallery'];
    gallery.forEach((data) => {
      product.gallery.add(ImageModel(
        name: data['name'],
        fullUrl: data['full_url'],
        extension: data['extension'],
      ))
    });

    return product;
  }
}