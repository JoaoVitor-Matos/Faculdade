import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  Future<List<Map>> _usuarios = Future.value([]);

  @override
  void initState() {
    super.initState();
    _usuarios = _listarUsuarios();
  }

  _recuperarBancoDados() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "banco.db");

    var retorno = await openDatabase(localBD, version: 1);

    if (!await _tableExists(retorno, "usuarios")) {
      String sql = "CREATE TABLE usuarios( "
          " id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome VARCHAR, idade INTEGER)";
      await retorno.execute(sql);
    }

    print("Aberto ${retorno.isOpen.toString()}");
    return retorno;
  }

  _cadastrarUsuario(String nome, int idade) async {
    if (nome.trim().isNotEmpty && idade > 0) {
      Database bd = await _recuperarBancoDados();
      Map<String, dynamic> dadosUsuarios = {"nome": nome, "idade": idade};
      int id = await bd.insert("usuarios", dadosUsuarios);
      print("Salvo: $id ");
      setState(() {
        _usuarios = _listarUsuarios();
      });
    }
  }

  Future<bool> _tableExists(Database db, String tableName) async {
    List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return tables.isNotEmpty;
  }

  Future<List<Map>> _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";
    List<Map> usuarios = await bd.rawQuery(sql);
    return usuarios;
  }

  _listarUmUsuarios(int id) async {
    Database bd = await _recuperarBancoDados();
    List<Map> usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);
    setState(() {
      _usuarios = Future.value(usuarios);
    });
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete("usuarios", where: "id = ?", whereArgs: [id]);
    print("item excluido " + retorno.toString());
    setState(() {
      _usuarios = _listarUsuarios();
    });
  }

  _atualizarUsuario(int id, String nome, int idade) async {
    if (nome.trim().isNotEmpty || idade > 0) {
      Database bd = await _recuperarBancoDados();
      Map<String, dynamic> dadosUsuarios = {};
      if (nome.trim().isNotEmpty) {
        dadosUsuarios["nome"] = nome;
      }
      if (idade > 0) {
        dadosUsuarios["idade"] = idade;
      }
      int retorno = await bd
          .update("usuarios", dadosUsuarios, where: "id = ?", whereArgs: [id]);
      print("Itens atualizados: " + retorno.toString());
      setState(() {
        _usuarios = _listarUsuarios();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de elementos',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Banco de dados",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Digite um nome',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder()),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                        labelText: 'Digite uma idade',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder()),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        labelText:
                            'Id do usuário ( Só para buscar, excluir e atualizar)',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder()),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _cadastrarUsuario(
                          _nameController.text.trim(),
                          int.tryParse(_ageController.text) ?? 0);
                    },
                    child: const Text(
                      'Cadastrar usuário',
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _usuarios = _listarUsuarios();
                      });
                    },
                    child: const Text(
                      'Listar usuários',
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _listarUmUsuarios(
                            int.tryParse(_idController.text) ?? 0);
                      });
                    },
                    child: const Text(
                      'Listar um usuário',
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _excluirUsuario(
                            int.tryParse(_idController.text) ?? 0);
                      });
                    },
                    child: const Text(
                      'Excluir um usuário',
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _atualizarUsuario(
                            int.tryParse(_idController.text) ?? 0,
                            _nameController.text.trim(),
                            int.tryParse(_ageController.text) ?? 0);
                      });
                    },
                    child: const Text(
                      'Atualizar um usuário',
                    ),
                  ),
                ),
                FutureBuilder<List<Map>>(
                  future: _usuarios,
                  builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          children: snapshot.data?.map((usuario) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                Text("Nome: ${usuario['nome']}", style: TextStyle(fontSize: 20)),
                                Text("Idade: ${usuario['idade']}", style: TextStyle(fontSize: 20)),
                                Text("Id: ${usuario['id']}", style: TextStyle(fontSize: 20)),
                              ],
                            );
                          })?.toList() ?? [],
                        );
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
