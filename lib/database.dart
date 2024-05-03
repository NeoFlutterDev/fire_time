import 'package:hive/hive.dart';

var folders = Hive.box("FlashCards");
var settings = Hive.box("User Settings");
var statistics = Hive.box("User Statistics");

// structure of FlashCards: {FolderName: [folderName, lastEdited, [[frontOfCard1, backOfCard1], [frontOfCard2, backOfCard2], etc]}