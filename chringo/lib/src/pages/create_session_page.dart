import 'package:cloud_firestore/cloud_firestore.dart';
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
            _DropdownWithLabel('Choose bingo rules:', <String>['Standard', 'Blackout']),
            _WordbankChoice(),
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

class _DropdownWithLabel extends StatefulWidget {
  final String label;
  final List<String> dropdownItems;
  _DropdownWithLabel(this.label, this.dropdownItems);
  @override
  State<StatefulWidget> createState() => _DropdownWithLabelState(label, dropdownItems);
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(label),
        SizedBox(width: 20,),
        DropdownButton<String>(
          value: selectedItem,
          onChanged: (newValue) {
            setState(() => selectedItem = newValue);
          },
          items: dropdownItems.map((value){
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList()
        )
      ],
    );
  }

}

class _WordbankChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WordbankChoiceState();
}

class _WordbankChoiceState extends State {
  String dropdownValue = '';
  String bingoType = 'Standard';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('wordbanks').snapshots(),
        builder: (context, snapshot) {
          print('NUMBER OF DOCUMENTS: ${snapshot.data.documents.length}');
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Choose wordbank:'),
              SizedBox(width: 20,),
              !snapshot.hasData
                  ? Text('No wordbanks...')
                  : DropdownButton<String>(
                      onChanged: (newValue) {
                        setState(() => dropdownValue = newValue);
                      },
                      items: snapshot.data.documents.map((snapshot) {
                        return DropdownMenuItem<String>(
                          child: Text(snapshot.documentID),
                        );
                      }).toList()),
            ],
          );
        });
  }
}
