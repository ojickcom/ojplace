import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/authentification/authentication_repo.dart';
import 'package:ojplace/authentification/log_in.dart';
import 'package:ojplace/blog_list/blog_list_place.dart';
import 'package:ojplace/blog_list/blog_list_start.dart';
import 'package:ojplace/blog_list/blog_list_stay.dart';
import 'package:ojplace/blog_list/blog_editing.dart';
import 'package:ojplace/blog_list/blog_add.dart';
import 'package:ojplace/blog_list/blog_list_all.dart';
import 'package:ojplace/client_list/add_clinent.dart';
import 'package:ojplace/client_list/client_list_view.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInStateProvider);

    return MaterialApp(
      home: DefaultTabController(
        length: 9,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            // title: const Text("고객 리스트"),
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
                  text: "포스팅 리스트4",
                ),
                Tab(
                  text: "포스팅 쓰기",
                ),
                Tab(
                  text: "포스팅 현황",
                ),
                Tab(
                  text: "클라이언트 리스트 ",
                ),
                Tab(
                  text: "클라이언트 추가",
                ),
                Tab(
                  text: "로그인",
                ),
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                isLoggedIn.when(
                  data: (data) => data ? postingList1() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? postingList2() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? postingExm() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? blogEdit() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? wrightingPost() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? postingList() : login(),
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
                login(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget postingList1() {
  return const BlogClick01();
}

Widget blogEdit() {
  return const BlogEditing();
}

Widget postingList2() {
  return const BlogStay();
}

Widget postingExm() {
  return const BlogListPlace();
}

Widget postingList() {
  return const BlogList();
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

Widget login() {
  return const LogIn();
}
// }
