import 'package:fire_time/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key, required this.title});
  final String title;

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

folderList() {
  var folderCollection = [];
  for (int i = 0; i <= folders.length - 1; i++) {
    folderCollection.add(folders.get(i));
    folderCollection[i].add(i); 
  }
  return folderCollection;
}

folderClean(folderCollection) {
  var updatedFolderCollection = [];
  for (int i = 0; i <= folderCollection.length - 1; i++) {
    var tempFolder = [];
    tempFolder.add(folderCollection[i][0]);
    tempFolder.add(folderCollection[i][1]);
    tempFolder.add(folderCollection[i][2]);
    updatedFolderCollection.add(tempFolder);
  }
  return updatedFolderCollection;
}

folderRemove(folderCollection, exclusion) {
  var updatedFolderCollection = [];
  for (int i = 0; i <= folderCollection.length - 1; i++) {
    if (folderCollection[i][folderCollection.length - 1] != exclusion) {
      updatedFolderCollection.add(folderCollection[i]);
    }
  }
  return updatedFolderCollection;
}

class _FlashCardsState extends State<FlashCards> {
  var folders = Hive.box("FlashCards");
  var folderCollection = folderList();
  @override
  Widget build(BuildContext context) {
    if (folders.length == 0) {
      return const Scaffold(
        body: Center(
          child: Text("No folders created")
        )
      );
    } else {
      return ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Text(
                    folderCollection[index][folderCollection[index].length - 1].toString(),
                    style: const TextStyle(
                      color: Colors.white
                    )
                  ),
                  title: Text(
                    folderCollection[index][0],
                    style: const TextStyle(
                      color: Colors.white
                    )
                  ),
                  subtitle: Text(
                    folderCollection[index][1],
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
                                onPressed: () => (
                                  folderCollection = folderRemove(folderCollection, index),
                                  folderCollection = folderClean(folderCollection),
                                  updateFoldersDatabase(folders, folderCollection),
                                ),
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
                    )
                  ]
                )
              ]
            )
          );
        }
      );
    }
  }
}

class FlashCardFolder extends StatefulWidget {
  const FlashCardFolder({super.key, required this.title});
  final String title;

  @override
  State<FlashCardFolder> createState() => _FlashCardFolderState();
}

class _FlashCardFolderState extends State<FlashCardFolder> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      )
    );
  }
}
