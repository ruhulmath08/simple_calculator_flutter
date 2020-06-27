import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
      ),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _form = GlobalKey<FormState>();

  var _currencies = ['Taka', 'Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateOfInterestController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding:
              EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextFormField(
                  controller: rateOfInterestController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Rate of Interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In Percentage',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: termController,
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter trem';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'Time in years',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      elevation: 8.0,
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_form.currentState.validate()) {
                            this.displayResult = _calculateTotalReturn();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RaisedButton(
                      elevation: 8.0,
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(this.displayResult, style: textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //state change for dropdown button select
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double rateOfInterest = double.parse(rateOfInterestController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable =
        principal + (principal * rateOfInterest * term) / 100;

    String result =
        'After $term years, your investment will be wort $totalAmountPayable $_currentItemSelected';

    return result;
  }

  void _reset() {
    principalController.text = '';
    rateOfInterestController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}

//for image
Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/money.png');
  Image image = Image(image: assetImage, width: 125.0, height: 125.0);

  return Container(
    child: image,
    margin: EdgeInsets.all(50.0),
  );
}
