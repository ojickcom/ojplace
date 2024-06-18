import 'package:flutter/material.dart';
import 'package:ojplace/blog/blog_edit.dart';
import 'package:ojplace/blog/blog_list.dart';
import 'package:ojplace/constants/gaps.dart';

class BlogWright extends StatefulWidget {
  const BlogWright({super.key});

  @override
  State<BlogWright> createState() => _BlogWrightState();
}

class _BlogWrightState extends State<BlogWright> {
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

    String blogStatusRadio = "대기";
    String blogContentType = "애견샵";
    final TextEditingController blogTitleController = TextEditingController();
    final TextEditingController blogContentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
      body: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 170,
                    child: RadioListTile(
                      title: const Text('신규'),
                      value: "신규",
                      groupValue: blogStatusRadio,
                      onChanged: (value) =>
                          setState(() => blogStatusRadio = value as String),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: RadioListTile(
                      title: const Text('대기'),
                      value: "대기",
                      groupValue: blogStatusRadio,
                      onChanged: (value) =>
                          setState(() => blogStatusRadio = value as String),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                      title: const Text('사용완료'),
                      value: "사용완료",
                      groupValue: blogStatusRadio,
                      onChanged: (value) =>
                          setState(() => blogStatusRadio = value as String),
                    ),
                  ),
                  ElevatedButton(
                    // style: ButtonStyle(minimumSize: Size(120, 70)),
                    onPressed: () {},
                    child: const Text("완료"),
                    // style: ,
                  ),
                ],
              ),
              // Gaps.v8,
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 170,
                    child: RadioListTile(
                      title: const Text('애견샵'),
                      value: "애견샵",
                      groupValue: blogContentType,
                      onChanged: (value) =>
                          setState(() => blogContentType = value as String),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: RadioListTile(
                      title: const Text('휴대폰'),
                      value: "휴대폰",
                      groupValue: blogContentType,
                      onChanged: (value) =>
                          setState(() => blogContentType = value as String),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                      title: const Text('운동'),
                      value: "운동",
                      groupValue: blogContentType,
                      onChanged: (value) =>
                          setState(() => blogContentType = value as String),
                    ),
                  ),
                ],
              ),
              Gaps.v14,
              TextField(
                controller: blogTitleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: '제목',
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
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: '블로그 컨텐츠',
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
              Gaps.v14,
            ],
          ),
        ),
      ),
    );
  }
}
