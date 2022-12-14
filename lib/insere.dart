// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'ctcdata.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'lista.dart';

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
    // adiciona aluno à api
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
                        // executa função de inserir aluno
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
        ),);
  }
}
