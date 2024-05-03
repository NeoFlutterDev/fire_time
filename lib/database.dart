import 'package:hive/hive.dart';

var folders = Hive.box("FlashCards");
var settings = Hive.box("User Settings");
var statistics = Hive.box("User Statistics");

// structure of FlashCards: {FolderName: [folderName, lastEdited, [[frontOfCard1, backOfCard1], [frontOfCard2, backOfCard2], etc]}

updateFoldersDatabase(box, newData) async {
  box.clear();
  var folders = Hive.box("FlashCards");
  for (int index = 0; index <= newData.length - 1; index++) {
    folders.put(index, newData[index]);
  }
}