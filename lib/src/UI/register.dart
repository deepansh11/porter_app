import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:porter_app/src/repo/authentication.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  late String password;
  late String name;

  void _submitData(String username, String userPassword) async {
    final repo = ref.watch(authenticationMethods);

    final porter = Porter(username, userPassword);
    print('$name $password');

    repo.when(data: (data) {
      data.register(porter, context);
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (e, s) {
      print('$e $s');
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register Page')),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              TextField(
                obscureText: false,
                decoration: const InputDecoration(hintText: 'User name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              InkWell(
                  onTap: () => _submitData(name, password),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)),
                  ))
            ],
          ),
        ));
  }
}
