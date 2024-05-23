import 'package:flutter/material.dart';
import 'package:hive/hive.dart';  
import 'package:intl/intl.dart';

checkEmptyFolder() {
  var folders = Hive.box('Folders');
  var flashcards = Hive.box('FlashCards');
  if (folders.isEmpty) {
    DateTime now = DateTime.now();
    folders.add(['New Folder', (DateFormat('yyyy-MM-dd').format(now.toLocal())), 0]);
    flashcards.add(['Front', 'Back']);
  }
}

checkEmptyFlashCard(index) {
  var flashcards = Hive.box('FlashCards');
  if (flashcards.getAt(index) == []) {
    flashcards.putAt(index, ['Front', 'Back']);
  }
}

createSides(index) {
  List<int> side = [];
  var flashcards = Hive.box('FlashCards');
  for (int i = 0; i < (flashcards.getAt(index)).length; i++) {
    side.add(0);
  }
  return side;
}

updateFlashCards(index, values) {
  var flashcards = Hive.box('FlashCards'); 
  List<String> templist = [];
  for (int i = 0; i < flashcards.getAt(index); i++) {
    templist.add(flashcards.getAt(index)[i]);
  }
  templist.addAll([values[0], values[1]]);
  return templist;
}

createFlashCardsList(index) {
  var flashcards = Hive.box('FlashCards'); 
  List<String> templist = [];
  for (int i = 0; i < flashcards.getAt(index); i++) {
    templist.add(flashcards.getAt(index)[i]);
  }
  return templist;
}

class FlashCards extends StatefulWidget {
  const FlashCards({super.key, required this.title});
  final String title;

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  var folders = Hive.box('Folders');
  var flashcards = Hive.box('FlashCards');
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
                        onPressed:() => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blue
                          )
                        )
                      ),
                      TextButton(
                        onPressed:() => [
                          folders.add([myController.text, (DateFormat('yyyy-MM-dd').format(now.toLocal()))]),
                          flashcards.add(['Front', 'Back']),
                          setState(() {iteration++;}),
                          Navigator.pop(context)
                        ],
                        child: const Text(
                          'Create',
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
                                          flashcards.deleteAt(index),
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
  const FlashCardFolder({super.key, required this.flashcardsLocation, required this.title});
  final String title;
  final int flashcardsLocation;

  @override
  State<FlashCardFolder> createState() => _FlashCardFolderState();
}

class _FlashCardFolderState extends State<FlashCardFolder> {
  var flashcards = Hive.box('FlashCards');
  var folders = Hive.box('Folders');
  final flashcardFront = TextEditingController();
  final flashcardBack = TextEditingController();
  DateTime now = DateTime.now();
  int iteration = 0;
  List<int> side = [];
  List<dynamic> flashcardslist = [];
  
  @override

  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => (
                      Navigator.pop(context)
                    ),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.blue
                  ),
                  Expanded(
                    child: 
                    ElevatedButton(
                      onPressed:() => (
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Flashcard creation',
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                            content: 
                            Column (
                              children: [
                                TextField(
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                  controller: flashcardFront,
                                  maxLength: 50,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter flashcard front here',
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  )
                                ),
                                TextField(
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                  controller: flashcardBack,
                                  maxLength: 200,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter flashcard back here',
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  )
                                ),
                              ],
                            ), 
                            actions: [
                              TextButton(
                                onPressed:() => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.blue
                                  )
                                )
                              ),
                              TextButton(
                                onPressed:() => [
                                  folders.putAt(widget.flashcardsLocation, [folders.getAt(widget.flashcardsLocation)[0], (DateFormat('yyyy-MM-dd').format(now.toLocal()))]),
                                  flashcardslist = updateFlashCards(widget.flashcardsLocation, [flashcardFront.text, flashcardBack.text]),
                                  side = createSides(widget.flashcardsLocation),
                                  Navigator.pop(context),
                                  setState(() {iteration++;}),
                                ],
                                child: const Text(
                                  'Create',
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
                        'Make new flashcard',
                        style: TextStyle(
                          color: Colors.blue
                        )
                      )
                    )
                  )
                ]
              ),
              Expanded(
                child: 
                ListView.builder(
                  itemCount: flashcards.getAt(widget.flashcardsLocation).length ~/ 2,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: const Color.fromARGB(255, 0, 0, 0).withAlpha(30),
                        onTap: () {
                          side[index] = side[index] ^ 1;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 200,
                          child: 
                          Center(
                            child: Text(((flashcards.getAt(index * 2 + side[index]).toString())))
                          )
                        ),
                      ),
                    );
                  }
                )
              )
            ],
          )
        )
      );
    } on Exception {
      side = createSides(widget.flashcardsLocation);
      flashcardslist = createFlashCardsList(widget.flashcardsLocation);
      setState(() {});
      rethrow;
    }
  } 
}
