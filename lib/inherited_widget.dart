import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget{

  final notes=[
    {
      "title" : "ABCD",
      "text" : "bdjhnjcsndkjncjndjsnjkncabjxhcnjzxmk",
    },
    {
      "title" : "BCDE",
      "text" : "ahksdn a dckncdjnajkdnjc nsm,kc",
    },
    {
      "title" : "FG",
      "text" : "sdnjncjknjkecdjnmcjkscdmkw",
    },
    {
      "title" : "HI",
      "text" : "dhkbcnkjanwkcnadmkwieidjjijiej",
    }
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>();
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes!=notes;
  }

}