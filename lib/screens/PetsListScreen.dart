import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/PetProvider.dart';
import '../models/Pet.dart';

class PetsListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetsListScreen> {
  TextEditingController nameSearchController = TextEditingController();
  TextEditingController typeSearchController = TextEditingController();

  List<Pet>? get filteredPets => null;

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Список тварин"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameSearchController,
                    decoration: const InputDecoration(labelText: "Пошук по імені"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: typeSearchController,
                    decoration: const InputDecoration(labelText: "Пошук по типу"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameSearchController.text;
                    final type = typeSearchController.text;

                    List<Pet> filteredPets = [];

                    if (name.isEmpty || type.isEmpty) {
                      filteredPets = petProvider.pets;
                    } else {
                      if (name.isNotEmpty) {
                        final petsByName = await petProvider.getPetByName(name);
                        filteredPets.addAll(petsByName);
                      }

                      if (type.isNotEmpty) {
                        final petsByType = await petProvider.getPetsByType(type);
                        filteredPets.addAll(petsByType);
                      }
                    }

                    filteredPets = filteredPets.toSet().toList();
                    setState(() {
                      petProvider.setFilteredPets(filteredPets);
                    });
                  },
                  child: const Text("Пошук"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: petProvider.filteredPets.length,
                itemBuilder: (context, index) {
                  final pet = petProvider.filteredPets[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(pet.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('Тип: ${pet.type}, Зріст: ${pet.height}, Вага: ${pet.weight}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
                        onPressed: () async {
                          await petProvider.deletePet(pet.name);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}