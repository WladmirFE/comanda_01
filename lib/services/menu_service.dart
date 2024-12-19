import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menu');

  // Adiciona um novo prato e retorna o ID
  Future<String> addDish(String name, double price, String tags) async {
    try {
      var docRef = await _menuCollection.add({
        'name': name,
        'price': price,
        'tags': tags.split(',').map((e) => e.trim()).toList(),
        'createdAt': Timestamp.now(),
      });

      return docRef.id; // Retorna o ID do prato recém-criado
    } catch (e) {
      throw Exception('Erro ao adicionar o prato: $e');
    }
  }

  // Atualiza um prato existente
  Future<void> updateDish(String id,
      {required String name,
      required double price,
      required String tags}) async {
    try {
      await _menuCollection.doc(id).update({
        'name': name,
        'price': price,
        'tags': tags.split(',').map((e) => e.trim()).toList(),
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar o prato: $e');
    }
  }

  // Remove um prato existente
  Future<void> removeDish(String id) async {
    try {
      await _menuCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao remover o prato: $e');
    }
  }

  // Função que retorna um Stream de pratos com base na pesquisa
  Stream<List<Map<String, dynamic>>> searchDishesStream(String query) {
    final searchQuery = query.toLowerCase();

    // Se o termo de pesquisa estiver vazio, retorna todos os pratos
    if (searchQuery.isEmpty) {
      return _menuCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Adiciona o ID do prato aos dados
          return data;
        }).toList();
      });
    } else {
      return _menuCollection.snapshots().map((snapshot) {
        return snapshot.docs.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String name = data['name'].toLowerCase();
          List<dynamic> tags = data['tags'];

          // Verifica se o nome ou qualquer tag contém o termo de pesquisa
          return name.contains(searchQuery) ||
              tags.any((tag) => tag.toLowerCase().contains(searchQuery));
        }).map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Adiciona o ID do prato aos dados
          return data;
        }).toList();
      });
    }
  }
}
