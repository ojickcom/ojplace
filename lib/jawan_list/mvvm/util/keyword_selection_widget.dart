import 'package:flutter/material.dart';
import 'package:ojplace/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KeywordSelectionWidget extends StatefulWidget {
  final Function(String) onClickTypeChanged;
  final Function(String) onGroupChanged;
  final Function(String) onClientNameChanged;
  final String initialClickType;
  final String initialGroup;
  final String initialClientName;

  const KeywordSelectionWidget({
    super.key,
    required this.onClickTypeChanged,
    required this.onGroupChanged,
    required this.onClientNameChanged,
    required this.initialClickType,
    required this.initialGroup,
    required this.initialClientName,
  });

  @override
  State<KeywordSelectionWidget> createState() => _KeywordSelectionWidgetState();
}

class _KeywordSelectionWidgetState extends State<KeywordSelectionWidget> {
  late String keywordClickTypeRadio;
  late String keywordGroupRadio;
  late String clientNameOption;

  final List<Map<String, dynamic>> clickTypeOptions = [
    {
      "label": "첫페이지",
      "value": "첫페이지",
      "color": const Color.fromARGB(255, 161, 8, 221)
    },
    {
      "label": "밀어내기",
      "value": "밀어내기",
      "color": const Color.fromARGB(255, 2, 98, 177)
    },
    {
      "label": "지정웹문서",
      "value": "지정웹문서",
      "color": const Color.fromARGB(255, 16, 141, 80)
    },
    {
      "label": "첫범위안클릭",
      "value": "첫범위안클릭",
      "color": const Color.fromARGB(255, 165, 100, 3)
    },
    {
      "label": "플레이스",
      "value": "플레이스",
      "color": const Color.fromARGB(255, 16, 141, 80)
    },
  ];

  final List<Map<String, dynamic>> groupOptions = [
    {"label": "자완초입", "value": "자완초입"},
    {"label": "자완유지", "value": "자완유지용"},
    {"label": "플레이스", "value": "플레이스용"},
    {"label": "신규", "value": "신규"},
    {"label": "대기", "value": "대기"},
    {"label": "오직", "value": "오직"},
  ];

  Future<List<Map<String, dynamic>>> fetchClientNames() async {
    List<Map<String, dynamic>> clientNames = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('clients').get();

      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          String clientName = doc['clientsName'];
          clientNames.add({
            'label': clientName,
            'value': clientName,
          });
        }
      }
    } catch (e) {
      print('Error fetching client names: $e');
    }

    return clientNames;
  }

  @override
  void initState() {
    super.initState();
    keywordClickTypeRadio = widget.initialClickType;
    keywordGroupRadio = widget.initialGroup;
    clientNameOption = widget.initialClientName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchClientNames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No clients found');
        } else {
          List<Map<String, dynamic>> clientName = snapshot.data!;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                const SizedBox(
                  width: 80,
                  child: Text(
                    "•클릭위치:",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: Sizes.size18,
                    ),
                  ),
                ),
                ...clickTypeOptions.map((option) => SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: Text(option['label'],
                            style: TextStyle(color: option['color'])),
                        value: option['value'],
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                          widget.onClickTypeChanged(value as String);
                        },
                      ),
                    ))
              ]),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "•그룹:",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: Sizes.size18,
                      ),
                    ),
                  ),
                  ...groupOptions.map((option) => SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: Text(option['label']),
                          value: option['value'],
                          groupValue: keywordGroupRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordGroupRadio = value as String;
                            });
                            widget.onGroupChanged(value as String);
                          },
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "•거래처:",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: Sizes.size18,
                      ),
                    ),
                  ),
                  ...clientName.map((option) => SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: Text(option['label']),
                          value: option['value'],
                          groupValue: clientNameOption,
                          onChanged: (value) {
                            setState(() {
                              clientNameOption = value as String;
                            });
                            widget.onClientNameChanged(value as String);
                          },
                        ),
                      ))
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
