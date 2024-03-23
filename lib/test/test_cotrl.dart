import 'package:ojplace/test/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataController {
  final Repository repository; //final이 붙은 변수는 초기화를 해야 한다.
  String aaa = "1";
  // DataController() : repository = Repository();
  DataController(this.repository); //생성자. 인스턴스를 생성했다.

  String data = "";

  Future<void> fetchData2() async {
    //단순한 함수이다.
    data = await repository.fetchData2();
  }
}
// Controller와 Repository를 Riverpod 프로바이더를 통해 사용할 수 있게 합니다.

final repositoryProvider = Provider<Repository>((ref1) {
  return Repository();
});
// => Repository());

final controllerProvider = Provider<DataController>((ref) {
  // final repository = ref.read(repositoryProvider);
  return DataController(ref.read(repositoryProvider));
});
// final controllerProvider = Provider<DataController>((ref) => DataController(ref.read(repositoryProvider)));
