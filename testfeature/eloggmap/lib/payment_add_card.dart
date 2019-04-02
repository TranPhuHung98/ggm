import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class PaymentAddCard extends StatefulWidget {
  @override
  _PaymentAddCardState createState() => _PaymentAddCardState();
}

class _PaymentAddCardState extends State<PaymentAddCard> {
  var _color = Colors.white;
  String _cardNumber = '';
  Country _country;
  String _mmdd = '';
  String _cvv = '';
  var _countrySize = [
    'Australia',
    'Vietnam',
    'Singapore',
    'Korea',
    'China',
  ];
  var _defaultCountrySize = 'Australia';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Add Card',
          style: TextStyle(color: _color, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: _color,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 85,
              right: 20,
              left: 20,
              child: Divider(
                color: Colors.grey,
              )),
          Positioned(
              top: 145,
              left: 20,
              right: MediaQuery.of(context).size.width / 2 + 25,
              child: Divider(
                color: Colors.grey,
              )),
          Positioned(
              top: 145,
              right: 20,
              left: MediaQuery.of(context).size.width / 2 + 25,
              child: Divider(
                color: Colors.grey,
              )),
          Positioned(
            right: 20,
            left: 20,
            top: 230,
            child: Divider(color: Colors.grey),
          ),
          Positioned(
            top: 130,
            right: MediaQuery.of(context).size.width / 2 + 25,
            child: Container(
              height: 18,
              width: 18,
              child: Center(
                  child: Text(
                '?',
                style: TextStyle(color: _color, fontSize: 15),
              )),
              decoration: BoxDecoration(
                  border: Border.all(color: _color),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            top: 130,
            right: 20,
            child: Container(
              height: 18,
              width: 18,
              child: Center(
                  child: Text(
                '?',
                style: TextStyle(color: _color, fontSize: 15),
              )),
              decoration: BoxDecoration(
                  border: Border.all(color: _color),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Card Number',
                  style: TextStyle(
                      color: _color, fontSize: 10, fontWeight: FontWeight.w300),
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  cursorColor: _color,
                  cursorWidth: 1,
                  style: TextStyle(color: _color, fontSize: 18),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    fillColor: Colors.amber,
                    icon: Image.asset(_cardNumber == '34'
                        ? 'images/amexcard.png'
                        : _cardNumber == '43'
                            ? 'images/visacard.png'
                            : _cardNumber == '243'
                                ? 'images/mastercard.png'
                                : 'images/paymentandmethod1.png'),
                  ),
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      _cardNumber = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 57,
            right: 20,
            child: Icon(
              Icons.photo_camera,
              color: Colors.grey,
              size: 35,
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            right: MediaQuery.of(context).size.width / 2 + 25,
            child: TextField(
              // keyboardType: TextInputType.numberWithOptions(),
              maxLength: 5,
              cursorColor: Colors.white,
              cursorWidth: 1,
              style: TextStyle(color: _color, fontSize: 18),
              decoration: InputDecoration(
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                hintText: 'MM/DD',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                fillColor: Colors.amber,
              ),

              onChanged: (value) {
                print(value);
                _mmdd = value;
              },
            ),
          ),
          Positioned(
            top: 120,
            right: 20,
            left: MediaQuery.of(context).size.width / 2 + 25,
            child: TextField(
              cursorWidth: 1,
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(color: _color, fontSize: 18),
              cursorColor: Colors.white,
              maxLength: 3,
              decoration: InputDecoration(
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                hintText: 'CVV',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                fillColor: Colors.amber,
              ),
              onChanged: (value) {
                print(value);
                _cvv = value;
              },
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Country',
                  style: TextStyle(
                      color: _color, fontSize: 10, fontWeight: FontWeight.w300),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CountryPicker(
                    onChanged: (Country country) {
                      setState(() {
                        _country = country;
                      });
                    },
                    selectedCountry: _country,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 150,
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
