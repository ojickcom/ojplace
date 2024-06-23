import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_model.dart';
import 'package:ojplace/client_list/client_repo.dart';

class ClientViewModel extends StateNotifier<AsyncValue<List<ClientModel>>> {
  final ClientRepository repository;

  ClientViewModel(this.repository) : super(const AsyncValue.loading()) {
    fetchClients();
  }

  Future<void> fetchClients() async {
    try {
      final clients = await repository.fetchClients();
      state = AsyncValue.data(clients);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addClient1(
      String clientsName, String memo, int basePrice, String grade) async {
    try {
      await repository.addClient(
        clientsName,
        memo,
        basePrice,
        grade,
      );
      fetchClients(); // 새로운 클라이언트를 추가한 후 목록을 다시 불러옵니다.
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateClient(ClientModel client) async {
    try {
      await repository.updateClient(client);
      fetchClients(); // 클라이언트를 업데이트한 후 목록을 다시 불러옵니다.
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteClient(ClientModel client) async {
    try {
      await repository.deleteClient(client);
      fetchClients(); // 클라이언트를 업데이트한 후 목록을 다시 불러옵니다.
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final clientViewModelProvider =
    StateNotifierProvider<ClientViewModel, AsyncValue<List<ClientModel>>>(
        (ref) {
  final repository = ref.watch(clientRepositoryProvider);
  return ClientViewModel(repository);
});
