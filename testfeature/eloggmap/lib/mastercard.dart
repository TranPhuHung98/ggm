import 'package:flutter/material.dart';

class PaymentAndMethod extends StatefulWidget {
  @override
  _PaymentAndMethodState createState() => _PaymentAndMethodState();
}

class _PaymentAndMethodState extends State<PaymentAndMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 40.0),
            child: Text(
              'Mastercard',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.only(left: 16, right: 15, top: 15),
            margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 2.0),
            child: Container(
              child: Text(
                '**** **** ****5322',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            color: Colors.white.withOpacity(0.2),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Expiry date',
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w200,
                        fontSize: 12)),
                Text('05/2021', style: TextStyle(color: Colors.white54))
              ],
            ),
            color: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
