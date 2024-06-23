import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/authentification/authentication_repo.dart';
import 'package:ojplace/authentification/log_in.dart';
import 'package:ojplace/blog/blog_list.dart';
import 'package:ojplace/jawan_list/keyword_li_jw_yuji2nd.dart';
import 'package:ojplace/jawan_list/keyword_list_event.dart';
import 'package:ojplace/jawan_list/keyword_list_place.dart';
import 'package:ojplace/jawan_list/keyword_li_mkjw_1st.dart';
import 'package:ojplace/jawan_list/keyword_li_jw_yuji1st.dart';
import 'package:ojplace/jawan_list/keyword_li_mkjw_2nd.dart';
import 'package:ojplace/jawan_list/keyword_add.dart';
import 'package:ojplace/jawan_list/keyword_list_all.dart';
import 'package:ojplace/client_list/client_list.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/keyword_list_place_yuji.dart';
import 'package:ojplace/jawan_list/keyword_list_new_keyword.dart';
import 'package:ojplace/jawan_list/keyword_list_standby.dart';
import 'package:ojplace/jawan_list/mvvm/util/keyword_search.dart';
import 'package:ojplace/jawan_list/reset_keywordlist_1st.dart';

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

    void goKeywordList() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KeywordAll(),
        ),
      );
    }

    void goKeywordInput() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KeywordAdd(),
        ),
      );
    }

    void goClientList() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientListView(),
        ),
      );
    }

    void goSearch() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KeywordSearch(),
        ),
      );
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 10,
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
                  ),
                ),
                Gaps.h28,
                GestureDetector(
                  onTap: goBlog,
                  child: const Text(
                    "블로그",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Gaps.h28,
                GestureDetector(
                  onTap: goKeywordInput,
                  child: const Text(
                    "키워드 입력",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Gaps.h28,
                GestureDetector(
                  onTap: goKeywordList,
                  child: const Text(
                    "키워드현황",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Gaps.h28,
                GestureDetector(
                  onTap: goClientList,
                  child: const Text(
                    "클라이언트 현황",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Gaps.h28,
                ElevatedButton.icon(
                  onPressed: goSearch,
                  icon: const Icon(
                    Icons.search,
                    size: 10,
                  ),
                  label: const Text("search"),
                )
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.grey,
            toolbarHeight: 20,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "자완생성1",
                ),
                Tab(
                  text: "자완생성2(끝생략)",
                ),
                Tab(
                  text: "자완유지1",
                ),
                Tab(
                  text: "자완유지2(끝생략)",
                ),
                Tab(
                  text: "플레이스 진입",
                ),
                Tab(
                  text: "플레이스 유지",
                ),
                Tab(
                  text: "신규",
                ),
                Tab(
                  text: "대기",
                ),
                Tab(
                  text: "Mnprice",
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
                  data: (data) => data ? mkJawan1stButton() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? mkJawan2ndButton() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? jawanYuji1st() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? jawanYuji2nd() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? placeKeyword() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? placeYuji() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? const NewKeyword() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? standBy() : login(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                isLoggedIn.when(
                  data: (data) => data ? const EventNow() : login(),
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

Widget mkJawan1stButton() {
  return const MkJawan1st();
}

Widget mkJawan2ndButton() {
  return const MkJawan2nd();
}

Widget jawanYuji1st() {
  return const JawanYuji1st();
}

Widget jawanYuji2nd() {
  return const JawanYuji2nd();
}

Widget placeKeyword() {
  return const PlaceKeyword();
}

Widget placeYuji() {
  return const PlaceYuji();
}

Widget standBy() {
  return const StandbyKeyword();
}

Widget mk1st() {
  // 클라이언트 추가 폼 구현
  return const ResetKeywordList1st();
}

Widget login() {
  return const LogIn();
}
// }

