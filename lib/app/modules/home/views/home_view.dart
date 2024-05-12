import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sybd/app/data/models/rocket.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rockets'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.rocketsList.length,
          itemBuilder: (context, index) {
            final rocket = controller.rocketsList[index];
            return buildRocketCard(context, rocket);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddRocketDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildRocketCard(BuildContext context, Rocket rocket) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rocket.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Type: ${rocket.type}'),
            subtitle: Text('Country: ${rocket.contry}'),
          ),
          ListTile(
            title: Text('Year: ${rocket.year}'),
            subtitle: Text('Mass: ${rocket.mass} kg'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => showEditRocketDialog(context, rocket),
                child: const Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () => controller.deleteRocket(rocket.id),
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAddRocketDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Rocket'),
        content: buildRocketForm(),
        actions: buildDialogActions(context, isEdit: false),
      ),
    );
  }

  void showEditRocketDialog(BuildContext context, Rocket rocket) {
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Rocket'),
        content: buildRocketForm(rocket: rocket),
        actions: buildDialogActions(context, isEdit: true, rocket: rocket),
      ),
    );
  }

  Widget buildRocketForm({Rocket? rocket}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller.nameController,
          decoration: InputDecoration(labelText: 'Enter Name'),
        ),
        TextField(
          controller: controller.typeController,
          decoration: InputDecoration(labelText: 'Enter Type'),
        ),
        TextField(
          controller: controller.contryController,
          decoration: InputDecoration(labelText: 'Enter Country'),
        ),
        TextField(
          controller: controller.yearController,
          decoration: InputDecoration(labelText: 'Enter Year'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: controller.massController,
          decoration: InputDecoration(labelText: 'Enter Mass (kg)'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  List<Widget> buildDialogActions(BuildContext context,
      {required bool isEdit, Rocket? rocket}) {
    return [
      TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          isEdit
              ? controller.updateRocket(
                  Rocket(
                    id: rocket!.id,
                    name: controller.nameController.text,
                    type: controller.typeController.text,
                    contry: controller.contryController.text,
                    year: int.parse(controller.yearController.text),
                    mass: double.parse(controller.massController.text),
                  ),
                )
              : controller.addRocket();
          Get.back();
        },
        child: Text(isEdit ? 'Edit' : 'Add'),
      ),
    ];
  }
}
