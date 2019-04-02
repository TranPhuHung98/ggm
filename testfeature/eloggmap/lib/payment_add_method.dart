// import 'package:e/payment_add_card/payment_add_card.dart';
import 'package:eloggmap/payment_add_card.dart';
import 'package:flutter/material.dart';

class PaymentAddMethod extends StatefulWidget {
  @override
  _PaymentAddMethodState createState() => _PaymentAddMethodState();
}

class _PaymentAddMethodState extends State<PaymentAddMethod> {
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
              'Add Payment Method',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>PaymentAddCard())),
                      child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: EdgeInsets.only(left: 16, right: 15),
              margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/paymentandmethod1.png'),
                  Container(
                    padding: EdgeInsets.only(left: 28),
                    child: Text(
                      'Credit or Debit Card',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 15),
            child: Row(
              children: <Widget>[
                Container(
                    height: 23.01,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(4)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 5,
                          left: 10,
                            child: Image.asset('images/paymentandmethod2.png')),
                        Positioned(
                          top: 7,
                          left: 12,
                            child: Image.asset('images/paymentandmethod3.png'))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child:
                      Text('PayPal', style: TextStyle(color: Colors.white54)),
                )
              ],
            ),
            color: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
