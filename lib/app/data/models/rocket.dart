// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Rocket {
  final String id;
  final String name;
  final String type;
  final String contry;
  final int year;
  final double mass;
  Rocket({
    required this.id,
    required this.name,
    required this.type,
    required this.contry,
    required this.year,
    required this.mass,
  });

  Rocket copyWith({
    String? name,
    String? type,
    String? contry,
    int? year,
    double? mass,
  }) {
    return Rocket(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      contry: contry ?? this.contry,
      year: year ?? this.year,
      mass: mass ?? this.mass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'contry': contry,
      'year': year,
      'mass': mass,
    };
  }

  factory Rocket.fromMap(Map<String, dynamic> map) {
    return Rocket(
      id: map['id'] ?? Uuid().v4(),
      name: map['name'] as String,
      type: map['type'] as String,
      contry: map['contry'] as String,
      year: map['year'] as int,
      mass: map['mass'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rocket.fromJson(String source) =>
      Rocket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rocket(id: $id, name: $name, type: $type, contry: $contry, year: $year, mass: $mass)';
  }
}
