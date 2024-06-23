import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/jawan_list/mvvm/util/keyword_selection_widget.dart';

class PopupAndModify extends ChangeNotifier {
  final ModifyTitleNotifier viewModel;
  PopupAndModify(this.viewModel);

  Future<void> modifyTitle(BuildContext context, String blogTitle, String id,
      String keywordGroupRadio, String blogType, String keywordStatus) async {
    await viewModel.modifyBlogTitle(
        blogTitle, id, keywordGroupRadio, blogType, keywordStatus, context);
    notifyListeners();
  }

  Future<void> deleteBlogTitle(String id) async {
    await viewModel.deleteBlogTitle(id); // 블로그 타이틀을 삭제합니다.
  }

  void showEditDialog(context, String blogTitle, String id, String blogType) {
    final titleController = TextEditingController(text: blogTitle);
    String keywordClickTypeRadio = "첫페이지";
    String keywordGroupRadio = "자완초입";
    String keywordStatusRadio = "Mnprice";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('키워드 상세 수정'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: '블로그 타이틀 수정',
                      ),
                    ),
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    await viewModel.deleteBlogTitle(id);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('삭제'),
                ),
                TextButton(
                  onPressed: () async {
                    final editedTitle = titleController.text;
                    final String blogGroup = keywordGroupRadio;
                    final String blogType = keywordClickTypeRadio;
                    final String keywordStatus = keywordStatusRadio;

                    await viewModel.modifyBlogTitle(editedTitle, id, blogGroup,
                        blogType, keywordStatus, context);
                    Navigator.pop(context);
                  },
                  child: const Text('수정'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

final popupAndModifyProvider = ChangeNotifierProvider<PopupAndModify>(
  (ref) => PopupAndModify(
    ref.read(modifyTitleNotifierProvider),
  ), // ModifyTitleNotifier 주입
);
