import 'package:hive/hive.dart';

var flashcards = Hive.box("FlashCards");
var settings = Hive.box("User Settings");
var statistics = Hive.box("User Statistics");