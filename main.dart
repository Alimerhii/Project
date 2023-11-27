import 'dart:ui';

import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan repayment system',
      theme:ThemeData(primaryColor: Colors.black),
      home: CalculatorScreen(),
    );
  }
}
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}
class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController monthsController = TextEditingController();
  double monthlyPayment = 0.0;
  int months = 0;
  bool isCalculateByMonths = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Colors.black.withOpacity(0.9),
        centerTitle: true,
        title: Text('Loan Repayment System'),
        leading: Icon(Icons.money),
      ),
      body: Container(
        decoration: BoxDecoration( backgroundBlendMode: BlendMode.srcOver, // Change this blend mode as needed
            gradient:LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black45])),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCalculateByMonths = true;
                      });
                    },
                    child: Text('Calculate by Payment'),style:ElevatedButton.styleFrom(primary:Colors.black45,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),elevation: 20,side: BorderSide(color: Colors.black38,width: 3)
                  )),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCalculateByMonths = false;
                      });
                    },
                      child: Text('Calculate by Months'),style:ElevatedButton.styleFrom(primary:Colors.black45,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),elevation: 20,side: BorderSide(color: Colors.black38,width: 3)
                  )),
                ],
              ),
              SizedBox(height: 16.0),
              if (isCalculateByMonths)
                _buildCalculateByMonths()
              else
                _buildCalculateByPayment(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCalculateByMonths() {
    return Column(
      children: [
        TextField(
          style: TextStyle(color: Colors.green),
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Loan amount',labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(Icons.monetization_on_outlined,),
              suffixIconColor:Colors.green,border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)) )),
        SizedBox(height: 16.0),
        TextField(
            style: TextStyle(color: Colors.deepOrange),
          controller: monthsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Number of Months',labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(Icons.calendar_month,),
    suffixIconColor:Colors.deepOrange,border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)) )),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            calculatePayment();
          },
    child: Text('Calculate!'),style:ElevatedButton.styleFrom(primary:Colors.black45,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),elevation: 20,side: BorderSide(color: Colors.black38,width: 3)
    )),
        SizedBox(height: 16.0),
        Text('Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',style: TextStyle(fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 40)),
      ],
    );
  }
  Widget _buildCalculateByPayment() {
    return Column(
      children: [
        TextField(
          style: TextStyle(color: Colors.green),
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Loan amount',labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(Icons.monetization_on_outlined,),
              suffixIconColor:Colors.green,border: OutlineInputBorder(),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)) )),

        SizedBox(height: 16.0),
        TextField(
            style: TextStyle(color: Colors.green),
          controller: valueController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Payment Amount',labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(Icons.monetization_on_outlined,),
    suffixIconColor:Colors.green,border: OutlineInputBorder(),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)) )),

        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            calculateMonths();
          },
    child: Text('Calculate!'),style:ElevatedButton.styleFrom(primary:Colors.black45,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),elevation: 20,side: BorderSide(color: Colors.black38,width: 3)
    )),

        SizedBox(height: 16.0),
        Text('Number of Months: $months',style: TextStyle(fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 40),),
      ],
    );
  }
  void calculatePayment() {
    double price = double.tryParse(priceController.text) ?? 0.0;
    int months = int.tryParse(monthsController.text) ?? 0;
    if (price > 0 && months > 0) {
      setState(() {
        monthlyPayment = price / months;
      });
    } else {
      _showInvalidInputAlert();
    }
  }
  void calculateMonths() {
    double price = double.tryParse(priceController.text) ?? 0.0;
    double value = double.tryParse(valueController.text) ?? 0.0;
    if (price > 0 && value > 0) {
      setState(() {
        months = (price / value).ceil();
      });
    } else {
      _showInvalidInputAlert();
    }
  }
  void _showInvalidInputAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter valid values for cloan amount and months or payment amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}