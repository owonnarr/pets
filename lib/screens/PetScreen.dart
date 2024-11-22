import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Pet.dart';
import '../providers/PetProvider.dart';
import 'PetsListScreen.dart';

class PetScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  PetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Домашні тварини")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Ім\'я'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ім\'я не може бути порожнім';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Тип'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Тип не може бути порожнім';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: const InputDecoration(labelText: 'Зріст'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Зріст не може бути порожнім';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Вага'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Вага не може бути порожньою';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final pet = Pet(
                          name: nameController.text,
                          type: typeController.text,
                          height: double.parse(heightController.text),
                          weight: double.parse(weightController.text),
                        );

                        await petProvider.addPet(pet);

                        nameController.clear();
                        typeController.clear();
                        heightController.clear();
                        weightController.clear();
                      }
                    },
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(0),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_circle, color: Colors.green),
                        SizedBox(width: 4),
                        Text("Додати"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetsListScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(0),
                      backgroundColor: WidgetStateProperty.all(Colors.white10),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pets, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("Список тварин"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}