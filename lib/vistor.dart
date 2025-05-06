

class Visitor {
  final int id;
  final String name;
  final String visitDate;
  final String purpose;

  Visitor({
    required this.id,
    required this.name,
    required this.visitDate,
    required this.purpose,
  });

  // Add a fromMap method to convert a map into a Visitor object
  factory Visitor.fromMap(Map<String, dynamic> map) {
    return Visitor(
      id: map['id'] as int,
      name: map['name'] as String,
      visitDate: map['visitDate'] as String,
      purpose: map['purpose'] as String,
    );
  }
}