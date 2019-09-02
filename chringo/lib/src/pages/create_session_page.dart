import 'package:flutter/material.dart';

class CreateSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE SESSION'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _WordbankDropdownButton(),
            RaisedButton(
              onPressed: () {},
              child: Text("CREATE"),
            )
          ],
        ),
      ),
    );
  }
}

class _WordbankDropdownButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WordbankDropdownButtonState();
}

class _WordbankDropdownButtonState extends State {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() => dropdownValue = newValue);
      },
      items: <String>['One', 'Two'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}
