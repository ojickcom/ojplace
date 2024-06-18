import 'package:flutter/material.dart';
import 'package:ojplace/blog/blog_add.dart';
import 'package:ojplace/blog/blog_edit.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/keyword_add.dart';

class BlogList extends StatelessWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context) {
    void goBlogList() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BlogList(),
        ),
      );
    }

    void goBlogWright() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BlogWright(),
        ),
      );
    }

    void goBlogEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BlogEdit(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              GestureDetector(
                onTap: goBlogList,
                child: const Text("블로그 리스트"),
              ),
              Gaps.h36,
              GestureDetector(
                onTap: goBlogWright,
                child: const Text("글쓰기"),
              ),
              Gaps.h36,
              GestureDetector(
                onTap: goBlogEdit,
                child: const Text("글편집"),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: const Center(
        child: Text("블로그 바디"),
      ),
    );
  }
}
