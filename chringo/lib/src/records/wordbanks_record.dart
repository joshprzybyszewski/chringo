import 'package:cloud_firestore/cloud_firestore.dart';

class WordbanksRecord {
  final List<String> words;
  final DocumentReference reference;

  WordbanksRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['words'] != null),
        words = List<String>.from(map['words']);

  WordbanksRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$words>";
}