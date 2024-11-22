class Pet {
  final int? id;
  final String name;
  final String type;
  final double height;
  final double weight;

  Pet({
    this.id,
    required this.name,
    required this.type,
    required this.height,
    required this.weight
  });

  factory Pet.fromDb(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'height': height,
      'weight': weight,
    };
  }
}