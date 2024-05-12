import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sybd/app/data/models/rocket.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final db = Db("mongodb://localhost:27017/sybd/");
  final rocketsList = <Rocket>[].obs;

  var nameController = TextEditingController();
  var typeController = TextEditingController();
  var contryController = TextEditingController();
  var yearController = TextEditingController();
  var massController = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    await db.open().then((value) {
      print("MongoDb connected");
    }).catchError((e) {
      print(e);
    });
    await getRockets();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getRockets() async {
    var collection = db.collection('rockets');
    var result = await collection.find().toList();
    rocketsList.assignAll(result.map((e) => Rocket.fromMap(e)).toList());
  }

  Future<void> addRocket() async {
    final Rocket rocket = Rocket(
      id: Uuid().v4(),
      name: nameController.text,
      type: typeController.text,
      contry: contryController.text,
      year: int.parse(yearController.text),
      mass: double.parse(massController.text),
    );
    var collection = db.collection('rockets');
    await collection.insertOne(rocket.toMap());
    getRockets();

    disposeControllers();
  }

  Future<void> deleteRocket(String id) async {
    var collection = db.collection('rockets');
    await collection.deleteOne(where.eq('id', id));
    getRockets();
  }

  Future<void> updateRocket(Rocket rocket) async {
    var collection = db.collection('rockets');
    await collection.updateOne(
        where.eq('id', rocket.id),
        modify.set('name', rocket.name)
          ..set('type', rocket.type)
          ..set('contry', rocket.contry)
          ..set('year', rocket.year)
          ..set('mass', rocket.mass));
    getRockets();
  }

  void disposeControllers() {
    nameController.dispose();
    typeController.dispose();
    contryController.dispose();
    yearController.dispose();
    massController.dispose();
  }
}
