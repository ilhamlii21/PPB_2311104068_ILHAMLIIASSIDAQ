class Mahasiswa {
  final String id;
  final String name;
  final String nim;
  final DateTime? createdAt;

  Mahasiswa({
    required this.id,
    required this.name,
    required this.nim,
    this.createdAt,
  });
  
  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
      return Mahasiswa(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        nim: json['nim'] ?? '',
        createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
  
  Mahasiswa copyWith({String? id, String? name, String? nim,
  DateTime? createdAt,
})   {
  return Mahasiswa(
    id: id ?? this.id,
    name: name ?? this.name,
    nim: nim ?? this.nim,
    createdAt: createdAt ?? this.createdAt,
  );
    }
}