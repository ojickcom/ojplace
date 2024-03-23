import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/blog_list/mvvm/blog_util.dart';
import 'package:ojplace/blog_list/mvvm/blog_view_model.dart';
import 'package:ojplace/constants/gaps.dart';

class BlogList extends ConsumerStatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogList> createState() => _BlogPostingListState();
}

class _BlogPostingListState extends ConsumerState<BlogList> {
  @override
  void initState() {
    super.initState();
    // Fetch data on initial load (optional, depending on your needs)
    ref.read(blogViewModelProvider.notifier).blogList();
  }

  @override
  Widget build(BuildContext context) {
    final blogs = ref.watch(blogListProvider);

    final popupAndModify = ref.watch(popupAndModifyProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("블로그 포스팅 현황"),
        ),
        body: Center(
          child: SizedBox(
            width: 1200,
            child: blogs.when(
              data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final filteredData = data.toList();
                    final blog = filteredData[index];
                    return Column(children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              popupAndModify.showEditDialog(
                                context,
                                blog.blogTitle,
                                blog.id,
                                blog.blogType ?? "null",
                              );
                            },
                            child: SizedBox(
                                width: 200,
                                child: Text(
                                  "제목:${blog.blogTitle}",
                                  overflow: TextOverflow.ellipsis,
                                  // style: const TextStyle(),
                                )),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: blog.blogTitle));
                            },
                            child: const Text("복사"),
                          ),
                          Gaps.h14,
                          SizedBox(
                            width: 310,
                            child: Text(
                              blog.blogContent,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: blog.blogContent));
                              },
                              child: const Text("복사")),
                          Gaps.h14,
                          SizedBox(
                              width: 120, child: Text("그룹:${blog.blogGroup}")),
                          Gaps.h14,
                          // SizedBox(
                          //     width: 150,
                          //     child: Text(
                          //       "아이디: ${blog.blogId}",
                          //       overflow: TextOverflow.ellipsis,
                          //     )),
                          Gaps.h14,
                          SizedBox(
                              width: 50, child: Text("칸트: ${blog.blogOrder}")),
                          Gaps.h14,
                          const SizedBox(width: 50, child: Text("클릭: ")),
                          Gaps.h14,

                          ElevatedButton(
                              onPressed: () async {
                                String id = blog.id;
                                await ref
                                    .read(blogViewModelProvider.notifier)
                                    .deleteBlog(
                                  id,
                                  context,
                                  () {
                                    ref.refresh(blogListProvider); // 새로 고침 콜백
                                  },
                                );
                              },
                              child: const Text("삭제")),
                        ],
                      ),
                    ]);
                  }),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text("Error: $error"),
            ),
          ),
        ));
  }
}
