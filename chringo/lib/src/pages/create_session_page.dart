import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateSessionPage extends StatelessWidget {
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
                children: <Widget>[
                  _DropdownWithLabel(
                      'Choose bingo rules:', <String>['Standard', 'Blackout']),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('wordbanks')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(
                            "Number of documents: ${snapshot.data.documents.length}, ${snapshot.data.documents.first.documentID}");
                        return _DropdownWithLabel(
                            'Choose wordbank:',
                            mockWordbankNames);
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
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
  _DropdownWithLabel(this.label, this.dropdownItems);
  @override
  State<StatefulWidget> createState() =>
      _DropdownWithLabelState(label, dropdownItems);
}

class _DropdownWithLabelState extends State {
  final String label;
  final List<String> dropdownItems;
  String selectedItem;
  _DropdownWithLabelState(this.label, this.dropdownItems) {
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
              value: selectedItem,
              onChanged: (newValue) {
                setState(() => selectedItem = newValue);
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
