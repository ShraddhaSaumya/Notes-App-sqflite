//import 'package:Notes_app/inherited_widget.dart';
import 'package:Notes_app/noteprovider.dart';
import 'package:flutter/material.dart';

enum Mode { Adding, Editing }

class Notes extends StatefulWidget {
  final Mode noteMode;
  final Map<String,dynamic> note;

  Notes(this.noteMode,this.note);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _textController=TextEditingController();
  //List<Map<String,String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if(widget.noteMode==Mode.Editing){
      _titleController.text=widget.note['title'];
      _textController.text=widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteMode == Mode.Adding ? "Add Note" : "Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Note Title",
                      focusColor: Colors.lightBlueAccent)
                    ),
                Container(
                  height: 10,
                ),
                TextField(
                  controller: _textController,
                  maxLines: 10,
                    decoration: InputDecoration(
                        hintText: "Note Text",
                        focusColor: Colors.lightBlueAccent)),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _NoteButton("Save", Colors.greenAccent.shade400, ()async {
                        final title = _titleController.text;
                        final text = _textController.text;
                        if(widget?.noteMode==Mode.Adding){
                          await NoteProvider.insertNote({
                            "title":title,
                            "text":text
                          });
                          setState((){});
                        }else if(widget?.noteMode==Mode.Editing){
                          await NoteProvider.updateNote({
                              'id':widget.note['id'],
                              'title':title,
                              'text':text,
                            });
                          }
                          Navigator.pop(context);
                        }),
                        _NoteButton("Discard", Colors.blueGrey, () {
                          Navigator.pop(context);
                        }),
                        widget.noteMode == Mode.Editing
                          ? _NoteButton("Delete", Colors.red.shade600, () async {
                              await NoteProvider.deleteNote(widget.note['id']);
                              Navigator.pop(context);
                            })
                            : Container(),
                      ]),
                ),
              ]),
        ),
    );
  }
}

class _NoteButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onpressed;

  _NoteButton(this._text, this._color, this._onpressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onpressed,
      child: Text(this._text),
      color: this._color,
      splashColor: Colors.lime,
      minWidth: 100,
      height: 40,
      textColor: Colors.white,
    );
  }
}
