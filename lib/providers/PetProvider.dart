import 'package:flutter/material.dart';
import '../db/PetsDatabase.dart';
import '../models/Pet.dart';

class PetProvider with ChangeNotifier {
  final PetsDatabase db = PetsDatabase.instance;
  final List<Pet> _pets = [];
  List<Pet> _filteredPets = [];

  List<Pet> get pets => _pets;
  List<Pet> get filteredPets => _filteredPets;

  Future<void> addPet(Pet pet) async {
    await db.addPet(pet);
    _pets.add(pet);
    _filteredPets.add(pet);
    notifyListeners();
  }

  Future<void> deletePet(String name) async {
    await db.deletePet(name);
    _pets.removeWhere((pet) => pet.name == name);
    _filteredPets.removeWhere((pet) => pet.name == name);
    notifyListeners();
  }

  Future<List<Pet>> getPetByName(String name) async {
    return await db.getPetByName(name);
  }

  Future<List<Pet>> getPetsByType(String type) async {
    return await db.getPetsByType(type);
  }

  void setFilteredPets(List<Pet> pets) {
    _filteredPets = pets;
    notifyListeners();
  }
}