import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_editing.dart';
import 'package:ojplace/client_list/client_model.dart';
import 'package:ojplace/client_list/repository.dart';

class ClientViewModel extends ChangeNotifier {}

class NavigationToEditScreen {
  void navigateToEditScreen(BuildContext context, ClientModel client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientEditScreen(client: client),
      ),
    );
  }
}

final navigationToEditProvider = Provider<NavigationToEditScreen>((ref) {
  return NavigationToEditScreen();
});

class UpdateClientScreen {
  void updateClient(String clientId, String updatedClientName,
      String updatedKeywords, WidgetRef ref, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("clients")
          .doc(clientId)
          .update({
        "clients_name": updatedClientName,
        "keyword": updatedKeywords,
      });
      Navigator.pop(context);
      ref.refresh(repoProvider);
    } catch (e) {
      print("Error updating client: $e");
    }
  }
}

final updateClientProvider = Provider<UpdateClientScreen>((ref) {
  return UpdateClientScreen();
});

class DeleteClientScreen {
  void deleteClient(var clientId, BuildContext context, WidgetRef ref) async {
    try {
      await FirebaseFirestore.instance
          .collection("clients")
          .doc(clientId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('클라이언트가 성공적으로 삭제되었습니다.'),
        ),
      );
      ref.refresh(repoProvider);
    } catch (e) {
      print("Error deleting client: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('클라이언트 삭제에 실패했습니다.'),
        ),
      );
    }
  }
}

final deleteProvider = Provider<DeleteClientScreen>((ref) {
  return DeleteClientScreen();
});
