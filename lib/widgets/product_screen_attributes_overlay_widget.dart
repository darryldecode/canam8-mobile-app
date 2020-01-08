import 'package:canamat8/events/more_attribute_event.dart';
import 'package:canamat8/models/attribute_model.dart';
import 'package:canamat8/widgets/product_screen_attributes_overlay_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxbus/rxbus.dart';

class ProductAttributeOverlayWidget extends StatefulWidget {

  final List<AttributeModel> attributes;

  const ProductAttributeOverlayWidget({@required this.attributes});

  @override
  State<StatefulWidget> createState() {
    return _ProductAttributeOverlayWidgetState();
  }
}

class _ProductAttributeOverlayWidgetState extends State<ProductAttributeOverlayWidget> with SingleTickerProviderStateMixin {

  bool _isVisible = false;
  double _hidePosition = -400;
  double _showPosition = 10;
  double _currentPosition = -400;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: _hidePosition, end: _showPosition).animate(_animationController);

    _animation.addListener(() {
      setState(() {
        _currentPosition = _animation.value;
      });
    });

    RxBus.register<MoreAttributeEvent>().listen((event) {
      if(!_isVisible) {
        _animationController.forward();
        setState(() {
          _isVisible = true;
        });
      } else {
        _animationController.reverse();
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double vh = MediaQuery.of(context).size.height;
    double vw = MediaQuery.of(context).size.width;

    return Positioned(
      right: _currentPosition,
      child: Container(
        height: vh * .90,
        width: vw * .40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)]
        ),
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ProductAttributeOverlayGridWidget(attributes: widget.attributes,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}