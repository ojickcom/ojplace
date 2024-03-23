import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/blog_list/mvvm/blog_view_model.dart';
import 'package:ojplace/constants/color_scheme.dart';
import 'package:ojplace/constants/gaps.dart';

class BlogAdd extends ConsumerStatefulWidget {
  const BlogAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogAdd> createState() => _BlogAddState();
}

class _BlogAddState extends ConsumerState<BlogAdd> {
  String selectedValue = "글감";
  final TextEditingController blogTitleController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();
  final TextEditingController blogOrderController = TextEditingController();
  final TextEditingController blogIdController = TextEditingController();
  final TextEditingController blogGroupController = TextEditingController();
  final TextEditingController blogTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blogViewModel = ref.watch(blogViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("블로그 글쓰기"),
      ),
      body: Center(
        child: SizedBox(
          width: 1024,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              title: const Text('자완초입'),
                              value: "자완초입",
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              title: const Text('자완유지용'),
                              value: "자완유지용",
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              title: const Text('플레이스용'),
                              value: "플레이스용",
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RadioListTile(
                              title: const Text('준비용'),
                              value: "준비용",
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myColorScheme.primary),
                            onPressed: () async {
                              // final blogViewModel = ref.read(blogViewModelProvider);
                              final String blogTitle = blogTitleController.text;
                              final String blogContent =
                                  blogContentController.text;
                              final String blogGroup = selectedValue;
                              final String blogOrderString =
                                  blogOrderController.text;
                              final int blogOrder =
                                  int.tryParse(blogOrderString) ?? 0;
                              final String blogId = blogIdController.text;
                              final String blogType = blogTypeController.text;

                              if (blogTitleController.text.isEmpty ||
                                  blogContentController.text.isEmpty) {
                                return;
                              }
                              try {
                                await ref
                                    .read(blogViewModelProvider.notifier)
                                    .addBlog(
                                      blogTitle,
                                      blogContent,
                                      blogGroup,
                                      blogOrder,
                                      blogId,
                                      blogType,
                                    );
                              } catch (e) {
                                print("Erro $e");
                              }
                            },
                            icon: const Icon(
                              Icons.accessibility_rounded,
                              size: 18,
                            ),
                            label: const Text("입력"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: blogTitleController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '포스팅 제목',
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
                TextField(
                  controller: blogContentController,
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    labelText: '블로그 내용',
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
                TextField(
                  controller: blogOrderController,
                  // keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '블로그 정렬 순서',
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
                TextField(
                  controller: blogIdController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '블로그 아이디',
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
                TextField(
                  controller: blogTypeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '블로그 타입',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
