import 'dart:io';
import 'package:Notes_app/Notess/notes.dart';
import 'package:Notes_app/noteprovider.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

enum choice { list, grid }
choice choose = choice.grid;

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes List"),
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              setState(() {
                choose = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<choice>>[
              PopupMenuItem<choice>(
                value: choice.list,
                child: Text('List View'),
              ),
              PopupMenuItem<choice>(
                value: choice.grid,
                child: Text('Grid View'),
              ),
            ],
          ),
        ],
      ),
      drawerScrimColor: Colors.grey.shade200,
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Shraddha Saumya"),
              accountEmail: Text("shraddhasaumya@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/pic.jpg"),
              ),
            ),
            ListTile(
              title: Text("Home Page"),
              trailing: Icon(Icons.add_to_home_screen),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NoteList())),
            ),
            ListTile(
              title: Text("Add Note"),
              trailing: Icon(Icons.add_outlined),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Notes(Mode.Adding, null))),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 3,
              endIndent: 5,
              indent: 5,
            ),
            ListTile(
              title: Text("Exit"),
              trailing: Icon(Icons.clear),
              onTap: () => {exit(0)},
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final notes = snapshot.data;
              if (choose == choice.grid) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (Notes(Mode.Editing, notes[index]))));
                        setState(() {});
                      },
                      child: Card(
                        elevation: 9,
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 20, top: 25, bottom: 25),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _Title(notes[index]["title"]),
                                Container(
                                  height: 5,
                                ),
                                _Notes(notes[index]["text"]),
                              ]),
                        ),
                      ),
                    );
                  },
                  itemCount: notes.length,
                );
              } else if (choose == choice.list) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 3.5),
                 
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (Notes(Mode.Editing, notes[index]))));
                        setState(() {});
                      },
                      child: Card(
                        elevation: 9,
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 20, top: 25),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _Title(notes[index]["title"]),
                                Container(
                                  height: 5,
                                ),
                                _Notes(notes[index]["text"]),
                              ]),
                        ),
                      ),
                    );
                  },
                  itemCount: notes.length,
                );
              }
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (Notes(Mode.Adding, null))));
          setState(() {});
        },
        child: Icon(Icons.add_box),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String _title;
  _Title(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Notes extends StatelessWidget {
  final String _text;
  _Notes(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
        _text,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
        maxLines: choose == choice.grid ? 4 : 2,

        overflow: TextOverflow.ellipsis,
    );
  }
}
