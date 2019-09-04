import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'dart:async';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {
  DateTime _data = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selecionarData(BuildContext context) async{
    final DateTime escolhido = await showDatePicker(
        context: context,
        initialDate: _data,
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2050)
    );

    if(escolhido != null && escolhido != _data){
      print('data selecionada: ${_data.toString()}');
      setState(() {
        _data = escolhido;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Feriados nascionais"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(

            child: Column(
              children: <Widget>[
                new Text('data selecionada: ${_data.toString()}' ),
                new RaisedButton(
                    child: Text('selecione uma data'),
                    onPressed: (){
                      _selecionarData(context);
                    })
              ],
            )
          ),
        ],
      ),

    );
  }
}
