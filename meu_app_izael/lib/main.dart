import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

var resBodyDate;

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _data = new DateTime.now();

  Future _selecionarData(BuildContext context) async{
    final DateTime escolhido = await showDatePicker(
        context: context,
        initialDate: _data,
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2050),
    );

    if(escolhido != null && escolhido != _data){

      setState(() {
        _data = escolhido;
        print(DateFormat('dd/MMMM/yyyy').format(_data));
      });

    }
  }

  Future<List> pegaDados() async {

    String apiUrl = "https://api.calendario.com.br/?json=true&ano=2019&ibge=3550308&token=aXphZWxtb3Jlbm9qckBnbWFpbC5jb20maGFzaD0xMjU1OTM0ODY";

    http.Response resposta = await http.get(apiUrl);


    resBodyDate = json.decode(resposta.body);

//    return resBodyDate;

    if(resposta.statusCode==200){
      //Tudo Saiu Bem
      return resBodyDate;
    } else {
      throw Exception("Falhou!");
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
      body: FutureBuilder<List>(
        future: pegaDados(),
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
              if (!estado.hasData) {
                return Center(
                  child: Text(
                    "Erro ao Carragar os Dados :(",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                  ),
                );
              } else{

                //verificar(_data.toString());

                return SingleChildScrollView(
                  padding: EdgeInsets.only(left: 70.0, top: 80.0, right: 0.0, bottom: 0.0),
                  child:  Column(
                    children: <Widget>[
                      Text('data selecionada: ${DateFormat('dd/MM/yyyy').format(_data)}'),
                      RaisedButton(
                        color: Colors.lightBlue,
                          child: Text('selecione uma data', style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            _selecionarData(context);

                          }),

                      Text(verificar(DateFormat('dd/MM/yyyy').format(_data)))
                    ],
                  ),
                );

              }
          }
        }
      ),
    );
  }
}

String verificar (String data){
  int i = 0;
  print(data);

  while( i < 27){
    if(resBodyDate[i]["date"] == data){
      print(resBodyDate[i]["date"]);
      return resBodyDate[i]["date"];
    }
    i++;
  }
  return "Hoje não é feriado";
}
