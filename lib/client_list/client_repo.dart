import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_model.dart';

class ClientRepository {
  final FirebaseFirestore firestore;

  ClientRepository(this.firestore);

  Future<List<ClientModel>> fetchClients() async {
    final db = await firestore.collection("clients").get();
    final List<ClientModel> clients = db.docs.map((doc) {
      final Map<String, dynamic> data = doc.data();
      final String id = doc.id;
      return ClientModel.fromJson(data, id);
    }).toList();
    return clients;
  }

  Future<void> addClient(
      String clientsName, String memo, int basePrice, String grade) async {
    try {
      await firestore.collection("clients").add({
        "clientsName": clientsName,
        "memo": memo,
        "basePrice": basePrice,
        "grade": grade,
      });
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateClient(ClientModel client) async {
    await firestore
        .collection('clients')
        .doc(client.id)
        .update(client.toJson());
  }

  Future<void> deleteClient(ClientModel client) async {
    await firestore.collection('clients').doc(client.id).delete();
  }
}

// FirebaseFirestore 인스턴스를 Provider로 제공
final firebaseProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// ClientRepository를 Provider로 제공
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  final firestore = ref.watch(firebaseProvider);
  return ClientRepository(firestore);
});

// 클라이언트 목록을 제공하는 FutureProvider
final clientsProvider = FutureProvider<List<ClientModel>>((ref) async {
  final clientRepository = ref.watch(clientRepositoryProvider);
  return await clientRepository.fetchClients();
});

final deleteClientProvider =
    FutureProvider.family<void, dynamic>((ref, id) async {
  final clientRepository = ref.watch(clientRepositoryProvider);
  await clientRepository.deleteClient(id);
});

final addClientProvider =
    FutureProvider.family<void, Map<String, String>>((ref, clientData) async {
  final clientRepository = ref.watch(clientRepositoryProvider);
  await clientRepository.addClient(
      clientData['clientsName']!,
      clientData['memo']!,
      int.parse(clientData['basePrice']!),
      clientData['grade']!);
});
final updateClientProvider =
    FutureProvider.family<void, ClientModel>((ref, client) async {
  final clientRepository = ref.watch(clientRepositoryProvider);
  await clientRepository.updateClient(client);
});
