import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

final repoProvider = FutureProvider<List<ClientModel>>((ref) async {
  final response = await firestore.collection("clients").get();
  final List<ClientModel> clients = response.docs.map((doc) {
    final Map<String, dynamic> data = doc.data();
    final String id = doc.id;
    return ClientModel.fromJson(data, id);
  }).toList();
  return clients;
});

void addClient(String clientName, String targetKeywords) async {
  try {
    await FirebaseFirestore.instance.collection("clients").add({
      "clients_name": clientName,
      "keyword": targetKeywords,
    });
  } catch (e) {
    print("Error : $e");
    rethrow;
  }
}

// class ClientRepository {
//   Future<void> updateClient(
//       String clientId, String updatedClientName, String updatedKeyword) async {
//     try {
//       await firestore.collection("clients").doc(clientId).update({
//         "clients_name": updatedClientName,
//         "keyword": updatedKeyword,
//       });
//     } catch (e) {}
//   }
// }
