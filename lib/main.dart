import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'profile.dart';
import 'calendar.dart';
import 'quizzes.dart';
import 'flashcards.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  var folders = await Hive.openBox("FlashCards");
  folders.put(0, ['Folder name', '15/04/24', ['UwU', 'a funny phrase']]);
  folders.put(1, ['Silly goofy', '15/04/24', ['OwO', 'a funnier phrase']]);
  //folders.delete(1);
  //folders.delete(0);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Time',
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Colors.black,
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 28, 28)
      ),
      home: const Scaffold(
        body: BottomAppBar()
      )
    );
  }
}

class FireSide extends StatefulWidget {
  const FireSide({super.key, required this.title});
  final String title;

  @override
  State<FireSide> createState() => _FireSideState();
}

class _FireSideState extends State<FireSide> {
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child: Text(
          '**WIP**',
          style: TextStyle(
            color: Colors.white
          )
        )
      )
    );
  }
}

class BottomAppBar extends StatefulWidget {
  const BottomAppBar({super.key});

  @override
  State createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBar> {
  int _selectedPage = 0;
  TextStyle optionStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    FlashCards(title: 'FlashCards'),
    Quizzes(title: 'Quizzes'),
    FireSide(title: 'FireSide'),
    Calendar(title: 'Calendar'),
    Profile(title: 'Profile')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle_outlined),
            label: 'FlashCards'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quizzes'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fireplace_outlined),
            label: 'FireSide'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal_outlined),
            label: 'Calendar'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile'
          ),
        ],
        currentIndex: _selectedPage,
        unselectedItemColor: Colors.red,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}