import 'package:exercice1/main.dart';
import 'package:flutter/material.dart';

import 'ListItensPage.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        routes: {
          "/list": (context) => ListItensPage(""),
        },
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
            body: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/fundo2.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'E-mail',
                              border: OutlineInputBorder()),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10), // <-- Set height
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Password',
                              border: OutlineInputBorder()),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Builder(
                        builder: (context) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () {
                                  _login(context);
                                },
                                child: const Text(
                                  'Enter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                          child: CheckboxListTile(
                        title: const Text('Remember me',
                            style: TextStyle(color: Colors.white)),
                        value: true,
                        onChanged: (value) => {},
                      )),
                      const SizedBox(height: 10),
                      Builder(
                        builder: (context) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'New Here? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => const CreateUserPage())));
                              },
                              child: const Text(
                                'Create an account',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
        
  
  }

  void _login(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = "Pedro";
    if (email == 'eu@gmail.com' && password == '1234') {
      setState(() {
        Navigator.of(context).pushNamed("/list", arguments: name);
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Dados inválidos"),
              content: const Text("Usuário e/ou está incorreta(o)"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Fechar")),
              ],
            );
          });
    }
  }
}