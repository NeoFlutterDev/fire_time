import 'package:flutter/material.dart';
import 'package:hive/hive.dart';  
import 'package:intl/intl.dart';

checkEmptyFolder() {
  var folders = Hive.box('FlashCards');
  if (folders.isEmpty) {
    DateTime now = DateTime.now();
    folders.add(['New Folder', (DateFormat('yyyy-MM-dd').format(now.toLocal())), ['Empty flashcard', 'Empty']]);
  }
}

checkEmptyFlashCard(index) {
  var folders = Hive.box('FlashCards');
  if (folders.getAt(index).isEmpty) {
    folders.clear();
    DateTime now = DateTime.now();
    folders.add(['New Folder', (DateFormat('yyyy-MM-dd').format(now.toLocal())), ['Empty flashcard', 'Empty']]);
  }
}

class FlashCards extends StatefulWidget {
  const FlashCards({super.key, required this.title});
  final String title;

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  var box = Hive.openBox("FlashCards");
  var folders = Hive.box("FlashCards");
  int iteration = 0;
  final myController = TextEditingController();
  DateTime now = DateTime.now();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget> [
            ElevatedButton(
              onPressed:() => (
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      'Folder creation',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    content: 
                      TextField(
                        style: const TextStyle(
                          color: Colors.white
                        ),
                        controller: myController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          hintText: 'Enter folder name here',
                          hintStyle: TextStyle(
                            color: Colors.white
                          )
                        )
                      ),
                    actions: [
                      TextButton(
                        onPressed:() => [
                          folders.add([myController.text, (DateFormat('yyyy-MM-dd').format(now.toLocal())), []]),
                          myController.dispose(),
                          setState(() {iteration++;}),
                          Navigator.pop(context)
                        ],
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.blue
                          )
                        )
                      ),
                      TextButton(
                        onPressed:() => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blue
                          )
                        )
                      )
                    ],
                  )
                )
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
              child: const Text(
                'Make new folder',
                style: TextStyle(
                  color: Colors.blue
                )
              )
            ),
            Expanded(
              child: 
              ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  return Card(
                  color: Colors.black,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            (folders.getAt(index))[0],
                            style: const TextStyle(
                              color: Colors.white
                            )
                          ),
                          subtitle: Text(
                            (folders.getAt(index))[1].toString(),
                            style: const TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () => (
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: const Text(
                                      'Delete Folder',
                                      style: TextStyle(
                                        color: Colors.white
                                      )
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this folder? This data cannot be recovered if you do so.',
                                      style: TextStyle(
                                        color: Colors.white
                                      )
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.blue
                                          )
                                        ),
                                        onPressed:() => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        onPressed: () => {
                                          folders.deleteAt(index),
                                          checkEmptyFolder(),
                                          setState(() {iteration++;}),
                                          Navigator.pop(context)
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.blue
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ),
                            child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.blue
                                )
                              )
                            ),
                            TextButton(
                              onPressed:() => {
                                checkEmptyFolder(),
                                checkEmptyFlashCard(index),
                                Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => FlashCardFolder(
                                    title: 'FlashCardFolder',
                                    flashcardsLocation: index
                                    )
                                  )
                                ),
                              },
                              child: const Text(
                                'Open',
                                style: TextStyle(
                                  color: Colors.blue
                                )
                              )
                            )
                          ]
                        )
                      ]
                    )
                  );
                }
              )
            )
          ]
        )
      )
    );
  }
}

class FlashCardFolder extends StatefulWidget {
  final String title;
  final int flashcardsLocation;
  const FlashCardFolder({super.key, required this.flashcardsLocation, required this.title});

  @override
  State<FlashCardFolder> createState() => _FlashCardFolderState();
}

class _FlashCardFolderState extends State<FlashCardFolder> {
  var folders = Hive.box("FlashCards");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ListView.builder(
              itemCount: folders.get(widget.flashcardsLocation).length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.black,
                  child: Text(folders.get(widget.flashcardsLocation)[0].toString())
                );
              },
            )
          ],
        )
      )
    );
  } 
}
