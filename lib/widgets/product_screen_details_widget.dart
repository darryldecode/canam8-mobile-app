import 'package:canamat8/models/category_model.dart';
import 'package:canamat8/models/image_model.dart';
import 'package:canamat8/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {

  final ProductModel product;

  ProductDetailsWidget({this.product});

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageHero(imageSrc: product.primaryPhoto.fullUrl,tag: product.primaryPhoto.fullUrl,)));
                      },
                      child: Image(image: NetworkImage(product.primaryPhoto.fullUrl),fit: BoxFit.cover)
                  )
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(product.name, style: TextStyle(fontSize: vw * 0.025, fontWeight: FontWeight.bold, color: Colors.green),),
                        Text('By: ${(product.grower!=null) ? product.grower.name : 'Loading..'}', style: TextStyle(fontSize: vw * 0.012),),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: _buildCategories(product.categories, vw),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildGalleryItem(product.gallery, context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildGalleryItem(List galleries, BuildContext context) {

    List<Widget> list = [];

    for(ImageModel image in galleries) {
      list.add(Hero(
        tag: image.fullUrl,
        child: Container(
          height: 200,
          width: 100,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageHero(imageSrc: image.fullUrl,tag: image.fullUrl,)));
            },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image(image: NetworkImage(image.fullUrl),fit: BoxFit.fitWidth,width: 100,),
              )
          ),
        ),
      ));
    }

    return list;
  }

  List<Widget> _buildCategories(List categories, double vw) {

    List<Widget> list = [];

    for(CategoryModel c in categories) {
      list.add(Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            Image(image: NetworkImage(c.icon.fullUrl,),fit: BoxFit.fitWidth,height: 50, width: 50,),
            Text(c.name, style: TextStyle(fontSize: vw * 0.012, fontWeight: FontWeight.w600),)
          ],
        ),
      ));
    }

    return list;
  }
}

class ImageHero extends StatelessWidget {

  final String imageSrc;
  final String tag;

  ImageHero({this.imageSrc, this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: tag,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
                child: Image.network(imageSrc)
            ),
          ),
        )
      ),
    );
  }
}