import 'package:eloggmap/screen17.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MaterialApp(home: Screen17()));

class MyApp extends StatefulWidget {
  List<Placemark> placemark;
  MyApp({this.placemark});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  Geolocator geolocator = Geolocator();
  var _color = Colors.amber;
  var _distance = 5.0;
  List<Placemark> placemark;
  String _location = '';
  TextEditingController _textEditingController;

  Position userLocation;
  bool isLoading = false;

  @override
  Future initState() {
    super.initState();
    _getLocation().then((position) async {
      userLocation = position;
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa' +
          userLocation.latitude.toString() +
          " and " +
          userLocation.longitude.toString());
    });
    // getPlacemark().then((onValue) {
    //   print('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee!!!');
    // });
  }

  Future<List<Placemark>> getPlacemark(String loca, Position pos) async {
    pos == null
        ? placemark = await Geolocator().placemarkFromAddress(loca)
        : placemark = await Geolocator()
            .placemarkFromCoordinates(pos.latitude, pos.longitude);
    return placemark;
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Change Location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25),
            height: MediaQuery.of(context).size.height - 80,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: widget.placemark == null
                      ? LatLng(-33.805464, 151.287351)
                      : LatLng(widget.placemark[0].position.latitude,
                          widget.placemark[0].position.longitude),
                  zoom: 13),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
          Positioned(
            bottom: 70,
            right: 10,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                icon: Icon(
                  Icons.place,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  _getLocation().then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    getPlacemark("", value).then((onValue) {
                      setState(() {
                        placemark = onValue;
                        print('okkkkkkkkkkkkkkk');
                      });
                    });
                    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa111:' +
                        userLocation.latitude.toString() +
                        " and " +
                        userLocation.longitude.toString());
                    mapController.moveCamera(CameraUpdate.newLatLng(
                        LatLng(value.latitude, value.longitude)));
                  });
                },
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.width - 20,
              // width: MediaQuery.of(context).size.width - 20,
              height: _distance * 40,
              width: _distance * 40,
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.15),
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(200)),
            ),
          ),
          Center(
            child: Container(
              // padding: EdgeInsets.only(bottom: 10),
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 50, right: 20, top: 12),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    print(value);
                    _location = value;
                  },
                  onSubmitted: (_location) {
                    setState(() {
                      isLoading = true;
                    });
                    print('aaaaaa' + _location);
                    getPlacemark(_location, null).then((value) {
                      setState(() {
                        isLoading = false;
                        placemark = value;
                      });
                      print(value[0].country);
                      print(value[0].administrativeArea);
                      // print(placemark[0].subAdministrativeArea);
                      print(value[0].locality);

                      print(value[0].thoroughfare);
                      print(value[0].position.toString());
                      mapController.moveCamera(CameraUpdate.newLatLng(LatLng(
                          value[0].position.latitude,
                          value[0].position.longitude)));
                    });
                  },
                  cursorColor: _color,
                  decoration: InputDecoration.collapsed(
                      hintText: "Search by city, neighbourhood or ZIP Code",
                      hintStyle: TextStyle(fontSize: 15)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: 250,
                        child: Slider(
                          activeColor: _color,
                          inactiveColor: Colors.grey[600],
                          min: 1.0,
                          max: 20.0,
                          onChanged: (double value) {
                            setState(() {
                              _distance = value;
                            });
                            // print(_distance);
                          },
                          value: _distance,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          '${_distance == 100.0 ? _distance.toString().substring(0, 3) : _distance < 10.0 ? _distance.toString().substring(0, 1) : _distance.toString().substring(0, 2)}km',
                          style: TextStyle(color: _color, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      print(placemark[0].country);
                      print(placemark[0].administrativeArea);
                      print(placemark[0].locality);
                      print(placemark[0].thoroughfare);
                      print(placemark[0].position);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Screen17(
                                    placemark: placemark,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 42.2,
                              width: 42.2,
                              decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                  child: Image.asset('images/check_icon.png')))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 20,
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Center(
            child: isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
