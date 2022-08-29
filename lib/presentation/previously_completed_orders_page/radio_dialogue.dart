import 'package:flutter/material.dart';

class RadioDialogue extends StatefulWidget {
  const RadioDialogue({Key? key}) : super(key: key);

  @override
  State<RadioDialogue> createState() => _RadioDialogueState();
}

class _RadioDialogueState extends State<RadioDialogue> {
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<int>(
              value: 1,
              groupValue: selected,
              onChanged: (v) {
                setState(() {
                  selected = v ?? 1;
                });
              },
              title: const Text('hello world'),
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: selected,
              onChanged: (v) {
                setState(() {
                  selected = v ?? 1;
                });
              },
              title: const Text('hello world'),
            ),
            RadioListTile<int>(
              value: 3,
              groupValue: selected,
              onChanged: (v) {
                setState(() {
                  selected = v ?? 1;
                });
              },
              title: const Text('hello world'),
            )
          ],
        ),
      ),
    );
  }
}
