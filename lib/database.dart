import 'package:hive/hive.dart';

var folders = Hive.box("Folders");
var flashcards = Hive.box("FlashCards");
var settings = Hive.box("User Settings");
var statistics = Hive.box("User Statistics");

// structure of Folders: {auto-assigned index: [Name of folder, date, unique ID]}
// structure of Flashcards: {auto-assigned index: [[front1, back1], [front2, back2], etc]}