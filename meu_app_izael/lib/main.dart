import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escalação por agenda"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      child: Text("Add"),
                      textColor: Colors.white,
                      onPressed: null,

                    ),
                    RaisedButton(
                      color: Colors.lightBlue,
                      child: Text("Add"),
                      textColor: Colors.white,
                      onPressed: null,
                    ),
                  ],
                ),
              ),
              Container(
                child: new FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () => {},
                ),
              )
            ]
        ),
      ),
      drawer: Drawer(),
    );
  }
}
