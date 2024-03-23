class Repository {
  Future<String> fetchData2() async {
    await Future.delayed(const Duration(seconds: 2)); // 실제 API 요청을 가정한 2초 딜레이
    return "Hello from API";
  }
  // fetchData2() {
  //   return "Hello from API2";
  // }
}
