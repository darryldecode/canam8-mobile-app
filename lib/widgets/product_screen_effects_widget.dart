import 'package:canamat8/models/effect_model.dart';
import 'package:flutter/material.dart';

class ProductEffectsWidget extends StatefulWidget {

  final List<EffectModel> effects;

  ProductEffectsWidget({this.effects});

  @override
  _ProductEffectsWidgetState createState() {
    return _ProductEffectsWidgetState();
  }
}

class _ProductEffectsWidgetState extends State<ProductEffectsWidget> {

  bool _firstBuildDone = false;
  String _activeTab = '';
  List<EffectModel> _activeTabEffects = [];
  Map<String, List<EffectModel>> _groupedEffects;

  @override
  void initState() {
    super.initState();
    _groupEffects();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) => {

      // we need to check if the first build is done so we
      // will not trigger this everytime the widget is being built.
      // because the build method is triggered every change state, we will have
      // infinite execution on this code. We also need to check if the _groupedEffects
      // is not empty, because build method executes very early
      if(!_firstBuildDone && (_groupedEffects.isNotEmpty)) {
        setState(() {
          _activeTab = _groupedEffects.keys.toList()[0];
          _activeTabEffects = _groupedEffects.values.toList()[0];
          _firstBuildDone = true;
        })
      }
    });

    double vw = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)]
        ),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildTabsTitles(vw),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: _buildEffectBars(vw),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEffectBars(double vw) {

    List<Widget> list = [];

    for(EffectModel effect in _activeTabEffects) {

      list.add(Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                height: 25,
                width: 25,
                child: Center(child: Image(image: AssetImage('assets/images/arrow.png'),))
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(effect.name, style: TextStyle(fontSize: vw * 0.015, fontWeight: FontWeight.w600),),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: 15,
                  width: 300,
                  margin: EdgeInsets.only(right: 10),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: 15,
                  width: (double.parse(effect.value) * 300) / 100,
                  margin: EdgeInsets.only(right: 10),
                )
              ],
            ),
          )
        ],
      ));
    }

    return list;
  }

  List<Widget> _buildTabsTitles(double vw) {

    List<Widget> list = [];

    list.add(Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text('Effects', style: TextStyle(fontSize: vw * 0.018, fontWeight: FontWeight.bold),),
    ));

    _groupEffects();

    _groupedEffects.forEach((k,v) => {
      list.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _activeTab = k;
                _groupedEffects.forEach((k,v) => {
                  if(k == _activeTab) {
                    _activeTabEffects = v
                  }
                });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: (k == _activeTab) ? Colors.green[800] : Colors.grey[300]
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(k, style: TextStyle(fontSize: vw * 0.018, fontWeight: FontWeight.bold, color: (k == _activeTab) ? Colors.white : Colors.black54),),
            ),
          )
      )
    });

    return list;
  }

  void _groupEffects() {

    Map<String, List<EffectModel>> grouped = Map();

    widget.effects.forEach((EffectModel effect) => {
      grouped[effect.group] = []
    });

    grouped.forEach((k,v) => {
      widget.effects.forEach((EffectModel effect) => {
        if(k == effect.group) {
          v.add(effect)
        }
      })
    });

    _groupedEffects = grouped;
  }
}