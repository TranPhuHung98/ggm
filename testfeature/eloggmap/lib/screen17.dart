import 'dart:ui';

import 'package:eloggmap/main.dart';
import 'package:eloggmap/payment_add_method.dart';
// import 'package:dreesu/screen18_setting.dart';
// import 'package:dreesu/screen20_premium.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Screen17 extends StatefulWidget {
  List<Placemark> placemark;
  Screen17({this.placemark});
  @override
  _Screen17State createState() => _Screen17State();
}

class _Screen17State extends State<Screen17> {
  var _color = Colors.amber;
  var _lightColor = Colors.amber[300];
  double _sizeTextTimeFrames = 12;
  List<Placemark> _placemark;

  var _size = ['2', '4', '6', '8'];
  var _defaultSize = '8';

  bool _timeFrameSwitch = false;
  bool _colorSwitch = false;

  var _countrySize = [
    'USA',
    'UK',
    'AS',
    'RUS',
  ];
  var _defaultCountrySize = 'USA';

  var _distance = 5.0;
  var _timeFrame = 5.0;

  Widget _vehicle(String time, String image) => Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 40,
          ),
          Text(
            time,
            style: TextStyle(color: _color),
          )
        ],
      );

  Widget _blurNameColour(String name) => Opacity(
        opacity: 0.3,
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w300, color: _color),
        ),
      );

  Widget _squareColor(Color color) => Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[300])),
        height: 40,
        width: 40,
      );

  Widget _category(String name, String image) => Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 12, color: _color),
          ),
        ],
      );

  Future<List<Placemark>> getPlacemark(double lat, double long) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, long);
    return placemark;
  }

  @override
  void initState() {
    super.initState();
    if (widget.placemark != null) {
      _placemark = widget.placemark;
    } else {
      getPlacemark(-33.805464, 151.287351)
          .then((onValue) => setState(() => _placemark = onValue));
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            // child: Image.asset('images/screen17.jpg'),
            child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                )),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('images/screen17.jpg'))),
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>PaymentAddMethod())),
                              child: Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: Colors.grey[700].withOpacity(0.6),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Filter by category',
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                        Container(
                          padding: EdgeInsets.only(top: 25, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Opacity(
                                opacity: 0.3,
                                child:
                                    _category('Wedding', 'images/screen17_1.png'),
                              ),
                              _category('Cocktail', 'images/screen17_2.png'),
                              Opacity(
                                  opacity: 0.3,
                                  child: _category(
                                      'Formal', 'images/screen17_3.png')),
                              Opacity(
                                  opacity: 0.3,
                                  child: _category(
                                      'Casual', 'images/screen17_4.png')),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.white, width: 0.15),
                            bottom:
                                BorderSide(color: Colors.white, width: 0.15))),
                    padding: EdgeInsets.only(top: 30, left: 20),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                color: Colors.grey[700].withOpacity(0.6),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Size',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: _lightColor, width: 0.8)),
                            child: Container(
                              margin: EdgeInsets.only(left: 30, right: 15),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  colorIcon: Colors.black,
                                  icon: Icons.chevron_right,
                                  isDense: true,
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      _defaultCountrySize = newValueSelected;
                                    });
                                  },
                                  items: _countrySize
                                      .map((String dropDownListItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownListItem,
                                      child: Text(
                                        dropDownListItem,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  value: _defaultCountrySize,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 49,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: _lightColor, width: 0.8)),
                            child: Container(
                              margin: EdgeInsets.only(left: 40, right: 15),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  colorIcon: Colors.amber,
                                  isDense: true,
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      _defaultSize = newValueSelected;
                                    });
                                  },
                                  items: _size.map((String dropDownListItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownListItem,
                                      child: Text(dropDownListItem,
                                          style: TextStyle(color: _color)),
                                    );
                                  }).toList(),
                                  value: _defaultSize,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 30, left: 25, right: 25),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 0.15),
                          bottom:
                              BorderSide(color: Colors.white, width: 0.15))),
                  // color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                color: Colors.grey[700].withOpacity(0.6),
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 25, right: 25),
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 0.15),
                          bottom:
                              BorderSide(color: Colors.white, width: 0.15))),
                  // color: Colors.black.withOpacity(0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Colour',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Container(
                              height: 31,
                              width: 51,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  border: Border.all(
                                      color: _colorSwitch
                                          ? Colors.amber
                                          : Colors.grey),
                                  color: _colorSwitch
                                      ? Colors.amber
                                      : Colors.grey),
                              child: CupertinoSwitch(
                                activeColor: Colors.amber,
                                value: _colorSwitch,
                                onChanged: (bool value) {
                                  setState(() {
                                    _colorSwitch = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(bottom: 20, right: 5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Light',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, color: _color),
                            ),
                            _blurNameColour('Neutral'),
                            _blurNameColour('Bright'),
                            _blurNameColour('Dark'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _squareColor(Colors.white),
                            _squareColor(Colors.pink[100]),
                            _squareColor(Colors.blue[100]),
                            _squareColor(Colors.green[100]),
                            _squareColor(Colors.yellow[100]),
                            _squareColor(Colors.indigo[100]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                color: Colors.grey[700].withOpacity(0.6),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 0.15),
                          bottom:
                              BorderSide(color: Colors.white, width: 0.15))),
                  padding: EdgeInsets.only(top: 30, left: 25, right: 25),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Maximum Distance',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text(
                              '${_distance == 100.0 ? _distance.toString().substring(0, 3) : _distance < 10.0 ? _distance.toString().substring(0, 1) : _distance.toString().substring(0, 2)}km',
                              style: TextStyle(fontSize: 18, color: _color))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Slider(
                          activeColor: _color,
                          inactiveColor: Colors.grey[600],
                          min: 1.0,
                          max: 25.0,
                          onChanged: (double value) {
                            setState(() {
                              _distance = value;
                            });
                          },
                          value: _distance,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _vehicle('56min', 'images/screen17_walk.png'),
                          _vehicle('9min', 'images/screen17_car.png'),
                          _vehicle('17min', 'images/screen17_bus.png'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp(placemark: _placemark,))),
                child: Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: Colors.grey[700].withOpacity(0.6),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.white, width: 0.15),
                            bottom:
                                BorderSide(color: Colors.white, width: 0.15))),
                    padding: EdgeInsets.only(top: 30, left: 25, right: 15),
                    height: 92,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Location',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('My Current Location',
                                    style:
                                        TextStyle(fontSize: 14, color: _color)),
                                Text(
                                    '${_placemark[0].locality}, ${_placemark[0].country}',
                                    style:
                                        TextStyle(fontSize: 11, color: _color))
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: _color,
                              size: 40,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    color: Colors.grey[700].withOpacity(0.6),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.white, width: 0.15),
                              bottom: BorderSide(
                                  color: Colors.white, width: 0.15))),
                      padding: EdgeInsets.only(top: 30, left: 25, right: 15),
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Time frames',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: _timeFrameSwitch
                                          ? Colors.white
                                          : Colors.grey[700].withOpacity(0.6))),
                              SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10, top: 20),
                            child: Text(
                              '24h',
                              style: TextStyle(
                                  color: _timeFrameSwitch
                                      ? _color
                                      : _color.withOpacity(0.3),
                                  fontSize: 18),
                            ),
                          ),
                          Slider(
                            activeColor: _timeFrameSwitch
                                ? _color
                                : _color.withOpacity(0.3),
                            inactiveColor: _timeFrameSwitch
                                ? Colors.grey[600]
                                : Colors.grey[600].withOpacity(0.3),
                            min: 1.0,
                            max: 25.0,
                            onChanged: (double value) {
                              setState(() {
                                _timeFrame = value;
                              });
                            },
                            value: _timeFrame,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _timeFrameSwitch
                      ? SizedBox()
                      : Container(
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[700].withOpacity(0.3),
                        ),
                  Positioned(
                    top: 5,
                    right: 20,
                    child: Container(
                      height: 31,
                      width: 51,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                              color: _timeFrameSwitch
                                  ? Colors.amber
                                  : Colors.grey),
                          color: _timeFrameSwitch ? Colors.amber : Colors.grey),
                      child: CupertinoSwitch(
                        activeColor: Colors.amber,
                        value: _timeFrameSwitch,
                        onChanged: (bool value) {
                          setState(() {
                            _timeFrameSwitch = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Show only ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: _sizeTextTimeFrames),
                        ),
                        Text('Urgent Swap ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _sizeTextTimeFrames)),
                        Text('items.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: _sizeTextTimeFrames)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Available for ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: _sizeTextTimeFrames)),
                        Text('Premiun members.',
                            style: TextStyle(
                                color: _color, fontSize: _sizeTextTimeFrames)),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                color: Colors.grey[700].withOpacity(0.6),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.white, width: 0.15),
                            bottom:
                                BorderSide(color: Colors.white, width: 0.15))),
                    padding: EdgeInsets.only(top: 30, left: 25, right: 15),
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Heleana',
                                style: TextStyle(color: _color, fontSize: 18)),
                            Row(
                              children: <Widget>[
                                Text('4.6',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                Icon(
                                  Icons.star,
                                  color: _color,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                            FlatButton(
                              onPressed: () {},
                              // => Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //         builder: (_) => SettingScreen())),
                              child: Text('  Setting',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: _color),
                  child: FlatButton(
                    onPressed: () {},
                    // onPressed: () => Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (_) => PremiumScreen())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text('Get Dreesu Premium'),
                        Icon(
                          Icons.chevron_right,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
          GestureDetector(
            // onTap: () => Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => MyHomePage())),
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text('dreesu', style: TextStyle(color: Colors.white)),
                    Text('Done', style: TextStyle(fontSize: 18, color: _color))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
