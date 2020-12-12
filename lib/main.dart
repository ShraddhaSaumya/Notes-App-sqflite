import 'package:flutter/material.dart';
import 'package:Notes_app/Notess/NoteList.dart';
import 'inherited_widget.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        //theme:ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Notes",
        home: NoteList(), 
      ),
    );
  }
}