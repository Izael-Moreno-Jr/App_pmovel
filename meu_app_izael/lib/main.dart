import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DateTime _data = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future _selecionarData(BuildContext context) async{
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

  Future<Map> pegarDados() async {
    http.Response resposta = await http.get(
        "https://api.calendario.com.br/?json=true&ano=$_data&ibge=3550308&token=aXphZWxtb3Jlbm9qckBnbWFpbC5jb20maGFzaD0xMjU1OTM0ODY"
    );

    return json.decode(resposta.body);


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
      body: FutureBuilder<Map>(
        future: pegarDados(),
        builder: (context, estado){
          switch (estado.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
            return Center(
              child: Text(
                "Carragando...",
                style: TextStyle(color: Colors.blueAccent , fontSize: 25.0),
              ),
            );
            default:
              if (estado.hasData) {
                return Center(
                  child: Text(
                    "Erro ao Carragar os Dados :(",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                  ),
                );
              } else{
                return SingleChildScrollView(
                  child:  Column(
                    children: <Widget>[
                      new Text('data selecionada: ${_data.toString()}' ),
                      new RaisedButton(
                          child: Text('selecione uma data'),
                          onPressed: (){
                            _selecionarData(context);
                          }),
                      new Text('')
                    ],
                  )
                );
              }
          }
        }
      ),
    );
  }
}
