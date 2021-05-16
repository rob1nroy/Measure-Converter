//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main()=> runApp(MyApp());
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
String _startMeasure;
String _convertedMeasure;
final Map<String, int> _measuresMap = {
  'meters' : 0,
  'kilometers' : 1,
  'miles' : 5,
};
final dynamic _formulas = {
  '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
  '1':[1000,1,0,0,3280.84,0.621371,0,0],
  '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
  '3':[0,0,1000,1,0,0,2.20462,35.274],
  '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
  '5':[1609.34, 1.60934,0,0,5280,1,0,0],
  '6':[0,0,453.592,0.453592,0,0,1,16],
  '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
};
String _resultMessage;
class _MyAppState extends State<MyApp> {
  //@override
  double _numberForm;
  void initstate(){
    double _numberForm =0;
    super.initState();
  }
  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    double result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    }
    else {
      _resultMessage = '${_numberForm.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });

  }

  final List<String> _measures=[
    'meters',
    'kilometers',
    'miles',
  ];
  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text('Measure Converter'),
      ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Spacer(),
              TextField(
                style: inputStyle,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Value',
                ),
                onChanged: (text){
                  var rv= double.tryParse(text);
                  if(rv!=null){
                    setState(() {
                      _numberForm = rv;
                    });
                  }
                },
              ),
              Spacer(),
              Text('From',style: labelStyle,),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                  items: _measures.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),);
                  }).toList(),
                onChanged: (value){
                    setState(() {
                      _startMeasure = value;
                    });
                },
                value: _startMeasure,
              ),
              Spacer(),
              Text('To',style: labelStyle,),

              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                items: _measures.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),);
                }).toList(),
                onChanged: (value){
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
                value: _convertedMeasure,
              ),
              Spacer(flex: 2,),
             ElevatedButton(onPressed: () {
               if (_startMeasure.isEmpty || _convertedMeasure.isEmpty ||
                   _numberForm == 0)
                 return;
               else
                 convert(_numberForm, _startMeasure, _convertedMeasure);
             },
                child: Text('Convert',style: TextStyle(color: Colors.white,fontSize: 24,),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                ),
             ),
              Spacer(flex: 2,),
              Text((_numberForm == null) ? '':_resultMessage.toString(),
              style: labelStyle,
              ),
              Spacer(flex: 15,),
            ],
          ),
        ),
    ),);
  }
}
