import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Trip Cost Calculator",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FuelForm());
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = "";
  final double _formDistance = 5.0;
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  String _currency = "Dollars";
  // The textfield updates it values nd the controller can notify any listners
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Hello!"), backgroundColor: Colors.blueAccent),
        body: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: _formDistance, bottom: _formDistance),
                    child: TextField(
                      controller: distanceController,
                      decoration: InputDecoration(
                          hintText: "e.g. 124",
                          labelText: "Distance",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _formDistance, bottom: _formDistance),
                    child: TextField(
                      controller: avgController,
                      decoration: InputDecoration(
                          hintText: "e.g. 17",
                          labelText: "Distance per Unit",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,

                      /** Controller automatically deals with text changes
                    *  onChanged: (String string) {
                      setState(() {
                        name = string;
                      });
                    }
                    */
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _formDistance, bottom: _formDistance),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                              hintText: "e.g. 1.65",
                              labelText: "Price",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          keyboardType: TextInputType.number,
                        )),
                        Container(width: _formDistance * 5),
                        Expanded(
                            child: DropdownButton<String>(
                                items: _currencies.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                value: _currency,
                                onChanged: (value) {
                                  _onDropDownChanged(value!);
                                })),
                      ],
                    )),
                Row(children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = _calculate();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                        backgroundColor: Theme.of(context).primaryColorDark,
                        elevation: 5.0),
                    child: const Text(
                      "Submit",
                      //make the text 50% bigger
                      textScaleFactor: 1.5,
                    ),
                  )),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _reset();
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          backgroundColor: const Color.fromARGB(112, 100, 255, 219),
                          elevation: 5.0),
                      child: const Text(
                        "Reset",
                        //make the text 50% bigger
                        textScaleFactor: 1.5,
                      ),
                    ),
                  )
                ]),
                Text(result),
              ],
            )));
  }

  _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result =
        "The total cost of your trip is ${_totalCost.toStringAsFixed(2)}   $_currency";
    return _result;
  }

  void _reset() {
    distanceController.text = "";
    avgController.text = "";
    priceController.text = "";
    setState(() {
      result = "";
    });
  }
}
//next 0.5
