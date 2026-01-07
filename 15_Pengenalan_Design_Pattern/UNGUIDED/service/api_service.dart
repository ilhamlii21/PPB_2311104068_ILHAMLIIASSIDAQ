import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/mahasiswa_model.dart';

class ApiService {
  static const String baseUrl =
      'https://693bc1bcb762a4f15c3e2913.mockapi.io/ilham';

  // =========================
  // GET ALL DATA
  // =========================
  Future<List<Mahasiswa>> fetchMahasiswa() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => Mahasiswa.fromJson(item))
          .toList();
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }
  }

  // =========================
  // ADD DATA
  // =========================
  Future<Mahasiswa> addMahasiswa(
    String name,
    String nim,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'nim': nim,
      }),
    );

    if (response.statusCode == 201) {
      return Mahasiswa.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(
        'Failed to add data: ${response.statusCode}',
      );
    }
  }

  // =========================
  // UPDATE DATA
  // =========================
  Future<Mahasiswa> updateMahasiswa(
    String id,
    String name,
    String nim,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'nim': nim,
      }),
    );

    if (response.statusCode == 200) {
      return Mahasiswa.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(
        'Failed to update data: ${response.statusCode}',
      );
    }
  }

  // =========================
  // DELETE DATA
  // =========================
  Future<void> deleteMahasiswa(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete data: ${response.statusCode}',
      );
    }
  }
}
