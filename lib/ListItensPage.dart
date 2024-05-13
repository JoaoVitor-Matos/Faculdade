import 'package:flutter/material.dart';
class ListItensPage extends StatefulWidget {
  String? name;

  ListItensPage(String this.name, {super.key});

  @override
  State<StatefulWidget> createState() => _ListItensState();
}

class _ListItensState extends State<ListItensPage> {
  List _itens = [];
  void _carregarItens() {
    _itens = [];
    for (var i = 0; i < 20; i++) {
      Map<String, dynamic> item = {};
      item["titulo"] = "Item  $i da lista";
      item["descricao"] = "Descrição $i da lista";
      _itens.add(item);
    }
  }

 

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)?.settings.arguments as String;
    _carregarItens();



    return MaterialApp(
        title: 'Lista de elementos',
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Bem vindo $name",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          drawer: const Drawer(),
          body: 
                  ListView.builder(
                    itemCount: _itens.length,
                    itemBuilder: (context, indice) {
                      return ListTile(
                        title: Text(_itens[indice]["titulo"]),
                        subtitle: Text(_itens[indice]["descricao"]),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Alerta"),
                                  content:
                                      Text("Você clicou no item $indice"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          print("Cliquei no sim");
                                        },
                                        child: const Text("Sim")),
                                    TextButton(
                                        onPressed: () {
                                          print("Cliquei no não");
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Não")),
                                  ],
                                );
                              });
                        },
                      );
                    },
                  ),
                
          ),
        );
  }
}