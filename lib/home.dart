import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/authentification/authentication_repo.dart';
import 'package:ojplace/authentification/log_in.dart';
import 'package:ojplace/blog/blog_list.dart';
import 'package:ojplace/jawan_list/keyword_list_place.dart';
import 'package:ojplace/jawan_list/keyword_list_start.dart';
import 'package:ojplace/jawan_list/keyword_list_yuji.dart';
import 'package:ojplace/jawan_list/keyword_daegi.dart';
import 'package:ojplace/jawan_list/keyword_add.dart';
import 'package:ojplace/jawan_list/keyword_list_all.dart';
import 'package:ojplace/client_list/add_clinent.dart';
import 'package:ojplace/client_list/client_list_view.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mk_list_1st.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInStateProvider);

    void goToLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogIn(),
        ),
      );
    }

    void goBlog() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BlogList(),
        ),
      );
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 9,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const SizedBox(
                  width: 500,
                  child: Center(
                    child: Text(
                      "//",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: goToLogin,
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
                Gaps.h28,
                GestureDetector(
                    onTap: goBlog,
                    child: const Text(
                      "블로그",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.grey,
            toolbarHeight: 20,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "자완 클릭(초입)",
                ),
                Tab(
                  text: "자완 유지용",
                ),
                Tab(
                  text: "플레이스 클릭",
                ),
                Tab(
                  text: "자완 대기",
                ),
                Tab(
                  text: "키워드 입력",
                ),
                Tab(
                  text: "키워드 현황",
                ),
                Tab(
                  text: "클라이언트 리스트 ",
                ),
                Tab(
                  text: "클라이언트 추가",
                ),
                Tab(
                  text: "초기화",
                ),
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                isLoggedIn.when(
                  data: (data) => data ? jawanStart() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? jawanYuji() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? placeKeyword() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? jawanDaegi() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? wrightingPost() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? keywordAll() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? clientList() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? _buildAddClientForm() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? mk1st() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                login(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget jawanStart() {
  return const JawanStart();
}

Widget jawanYuji() {
  return const JawanYuji();
}

Widget placeKeyword() {
  return const PlaceKeyword();
}

Widget keywordAll() {
  return const KeywordAll();
}

Widget jawanDaegi() {
  return const JawanDaegi();
}

Widget wrightingPost() {
  return const BlogAdd();
}

Widget clientList() {
  return const ClientListView();
}

Widget _buildClientList() {
  return const ClientListView();
}

Widget _buildAddClientForm() {
  // 클라이언트 추가 폼 구현
  return AddClient();
}

Widget mk1st() {
  // 클라이언트 추가 폼 구현
  return const MkList1st();
}

Widget login() {
  return const LogIn();
}
// }
