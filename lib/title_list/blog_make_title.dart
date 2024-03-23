import 'package:flutter/material.dart';
import 'package:ojplace/constants/gaps.dart';

class BlogMakeTitle extends StatelessWidget {
  const BlogMakeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("블로그 타이틀 만들기"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 1024,
                child: Column(
                  children: [
                    const Text(
                      "강아지분양 키워드",
                      style: TextStyle(fontSize: 39),
                    ),
                    const Text(
                      "키워드 약 30개. 검색어 2단어 + 상호",
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("검색어, 엑셀업로드"),
                        ),
                        Gaps.h20,
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("상호 만들기"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
