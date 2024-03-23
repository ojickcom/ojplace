import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ojplace/client_list/client_model.dart';

abstract class ClientRepository {
  Future<void> addClient(ClientModel client);
  Future<List<ClientModel>> viewClients();
}

class FirebaseClientRepository extends ClientRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addClient(ClientModel client) async {
    await firestore.collection("clients").doc().set(
      {"clients_name": client.clientsName, "keyword": client.targetKeywords},
    );
  }

  @override
  Future<List<ClientModel>> viewClients() async {
    QuerySnapshot querySnapshot = await firestore.collection("clients").get();
    List<ClientModel> clients = [];

    for (var doc in querySnapshot.docs) {
      final String id = doc.id;
      clients
          .add(ClientModel.fromJson(doc.data()! as Map<String, dynamic>, id));
    }
    return clients;
  }
}
