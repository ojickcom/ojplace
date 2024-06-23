import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/util/format_list.dart';

class ResetKeywordList1st extends ConsumerWidget {
  const ResetKeywordList1st({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser1([]);
                  },
                  child: const Text('zegalang@na'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser2([]);
                    print("mk성공");
                  },
                  child: const Text('ojick@oj'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser3([]);
                    print("mk성공");
                  },
                  child: const Text('zegalang@da'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser4([]);
                    print("mk성공");
                  },
                  child: const Text('yulpung@na'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser5([]);
                    print("mk성공");
                  },
                  child: const Text('ojick01@oj'),
                ),
              ],
            ),
          ),
          Gaps.v28,
          Center(
            child: Row(
              children: [
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser6([]);
                    print("mk성공");
                  },
                  child: const Text('dream01'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser7([]);
                    print("mk성공");
                  },
                  child: const Text('dream02'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser8([]);
                    print("mk성공");
                  },
                  child: const Text('dream03'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser9([]);
                    print("mk성공");
                  },
                  child: const Text('dream04'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkBrowser10([]);
                    print("mk성공");
                  },
                  child: const Text('dream05'),
                ),
                Gaps.h10,
              ],
            ),
          ),
          Gaps.v28,
          const Text("자완유지"),
          Gaps.v12,
          Center(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser1([]);
                  },
                  child: const Text('zegalang@na'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser2([]);
                    print("mk성공");
                  },
                  child: const Text('ojick@oj'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser3([]);
                    print("mk성공");
                  },
                  child: const Text('zegalang@da'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser4([]);
                    print("mk성공");
                  },
                  child: const Text('yulpung@na'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser5([]);
                    print("mk성공");
                  },
                  child: const Text('ojick01@oj'),
                ),
              ],
            ),
          ),
          Gaps.v28,
          Center(
            child: Row(
              children: [
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser6([]);
                    print("mk성공");
                  },
                  child: const Text('dream01'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser7([]);
                    print("mk성공");
                  },
                  child: const Text('dream02'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser8([]);
                    print("mk성공");
                  },
                  child: const Text('dream03'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser9([]);
                    print("mk성공");
                  },
                  child: const Text('dream04'),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    final mkWebBrowser =
                        ref.read(mkWebBrowserProvider.notifier);
                    mkWebBrowser.mkStayBrowser10([]);
                    print("mk성공");
                  },
                  child: const Text('dream05'),
                ),
                Gaps.h10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
