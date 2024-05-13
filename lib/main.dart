
import 'package:exercice1/ControlPanelPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


void main() {
if (kIsWeb) {
  // Change default factory on the web
  databaseFactory = databaseFactoryFfiWeb;
}
  runApp(const ControlPanelPage());
}

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  bool _email = false;
  bool _phone = false;
  final int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Digite um valor: ',
                      ),
                      maxLength: 30,
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento: ',
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.datetime,
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail: ',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Senha: ',
                          suffixIcon: Icon(Icons.visibility_off)),
                      maxLength: 20,
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Text('Gênero: '),
                  Text('Masculino '),
                  Radio(
                    value: null,
                    groupValue: null,
                    onChanged: null,
                  ),
                  Text('Feminino '),
                  Radio(
                    value: null,
                    groupValue: null,
                    onChanged: null,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const Text('Notificações', textAlign: TextAlign.center),
                  Container(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('E-mail'),
                          value: _email,
                          onChanged: (bool value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                        SwitchListTile(
                          title: const Text('Celular'),
                          value: _phone,
                          onChanged: (bool value) {
                            setState(() {
                              _phone = value;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  const Text('FontSize', textAlign: TextAlign.center),
                  Expanded(
                    child: Slider(
                      value: 50,
                      min: 0,
                      max: 100,
                      label: 'FontSize',
                      onChanged: (double value) {
                        return;
                      },
                    ),
                  )
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Register',
                        ),
                      ),
                    ),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}