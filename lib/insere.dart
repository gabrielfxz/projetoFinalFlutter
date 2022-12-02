// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'ctcdata.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'lista.dart';

// criar uma lista para puxar os dados da api
// Future<List<ctcData>> fetchData() async {
//   var response = await http.get(
//       Uri.parse("https://www.slmm.com.br/CTC/insere.php"),
//       headers: {"Accept": "application/json"});

//   if (response.statusCode == 200) {
//     // print(response.body);
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => new ctcData.fromJson(data)).toList();
//   } else {
//     throw Exception('Erro inesperado....');
//   }
// }

/*Future<http.Response> createAlbum(String nome, String data) {
  return http.post(
    Uri.parse('www.slmm.com.br/CTC/insere.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nome': nome,
      'data': data,
    }),
  );
}*/

class Insere extends StatefulWidget {
  const Insere({Key? key}) : super(key: key);

  @override
  State<Insere> createState() => _InsereState();
}

class _InsereState extends State<Insere> {
  var formKey = GlobalKey<FormState>();
  var nome = TextEditingController();
  var data = TextEditingController();

  insert() async {
    var res = http.post(
      Uri.parse("https://www.slmm.com.br/CTC/insere.php"), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        
      },
      body: jsonEncode(<String, String>{
      'nome': nome.text,
      'data': data.text,
    }),
    );

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inserir Aluno"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "you should add value";
                        }
                        return null;
                      },
                      controller: nome,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person),
                          hintText: 'Informe o nome'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "you should add value";
                        }
                        return null;
                      },
                      controller: data,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.calendar_month_rounded),
                          hintText: 'Informe a data'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text("insert products"),
                      onPressed: () {
                        insert();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Lista()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
            // Respond to button press
          },
          child: Icon(Icons.add),
        ));
  }
}
