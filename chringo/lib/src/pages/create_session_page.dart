import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateSessionPage extends StatefulWidget {
  @override
  _CreateSessionPageState createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  String _wordbankChoice;

  final mockWordbankNames = <String>['Mock WB 1', 'Mock WB 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE SESSION'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // TODO figure out how to pass the dropdown choices out
                children: <Widget>[
                  _DropdownWithLabel('Choose bingo rules:',
                      <String>['Standard', 'Blackout'], () {}),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('wordbanks')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return _DropdownWithLabel(
                            'Choose wordbank:',
                            snapshot.data.documents
                                .map((doc) => doc.documentID)
                                .toList(), (newValue) {
                          setState(() => _wordbankChoice = newValue);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      print(_wordbankChoice);
                    },
                    child: Text("CREATE"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownWithLabel extends StatefulWidget {
  final String label;
  final List<String> dropdownItems;
  final Function onSelectionChanged;
  _DropdownWithLabel(this.label, this.dropdownItems, this.onSelectionChanged);
  @override
  State<StatefulWidget> createState() =>
      _DropdownWithLabelState(label, dropdownItems, onSelectionChanged);
}

class _DropdownWithLabelState extends State {
  final String label;
  final List<String> dropdownItems;
  final Function onSelectionChanged;
  String selectedItem;
  _DropdownWithLabelState(
      this.label, this.dropdownItems, this.onSelectionChanged) {
    selectedItem = dropdownItems.first;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label),
        Container(
          width: 150,
          child: DropdownButton<String>(
              isExpanded: true,
              value: selectedItem,
              onChanged: (newValue) {
                setState(() {
                  selectedItem = newValue;
                  onSelectionChanged(newValue);
                });
              },
              items: dropdownItems.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        )
      ],
    );
  }
}
