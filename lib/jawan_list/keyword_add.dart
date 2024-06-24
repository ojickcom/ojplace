import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/util/keyword_selection_widget.dart';

class KeywordAdd extends ConsumerStatefulWidget {
  const KeywordAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<KeywordAdd> createState() => _BlogAddState();
}

class _BlogAddState extends ConsumerState<KeywordAdd> {
  String keywordClickTypeRadio = "첫페이지";
  String keywordGroupRadio = "자완초입";

  String keywordStatusRadio = "신규";
  final TextEditingController keywordInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final blogViewModel = ref.watch(blogViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("새로운 자완 추가"),
      ),
      body: Center(
        child: SizedBox(
          width: 1024,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                KeywordSelectionWidget(
                  onClickTypeChanged: (value) {
                    setState(() {
                      keywordClickTypeRadio = value;
                    });
                  },
                  onGroupChanged: (value) {
                    setState(() {
                      keywordGroupRadio = value;
                    });
                  },
                  onClientNameChanged: (value) {
                    setState(() {
                      keywordStatusRadio = value;
                    });
                  },
                  initialClickType: keywordClickTypeRadio,
                  initialGroup: keywordGroupRadio,
                  initialClientName: keywordStatusRadio,
                ),
                Gaps.v20,
                TextField(
                  controller: keywordInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'New Keyword',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (blogTitle) {},
                ),
                Gaps.v20,
                ElevatedButton.icon(
                  onPressed: () async {
                    final String blogTitle = keywordInputController.text;
                    final String keywordClickType = keywordClickTypeRadio;
                    final String keywordGroup = keywordGroupRadio;
                    final String keywordStatus = keywordStatusRadio;
                    if (keywordInputController.text.isEmpty) {
                      return;
                    }
                    try {
                      await ref.read(blogViewModelProvider.notifier).addBlog(
                            blogTitle,
                            keywordGroup,
                            keywordClickType,
                            keywordStatus,
                            context,
                          );
                    } catch (e) {
                      print("Erro $e");
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.green,
                  ),
                  label: const Text("입력"),
                ),
                Gaps.v20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
