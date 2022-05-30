import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:porter_app/src/repo/authentication.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late String userName;
  late String password;

  void _submitData(String username, String userPassword) async {
    final repo = ref.watch(authenticationMethods);

    final porter = Porter(username, userPassword);
    print('$userName $password');

    repo.when(data: (data) {
      data.login(porter, context);
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              TextField(
                obscureText: false,
                decoration: const InputDecoration(hintText: 'User name'),
                onChanged: (value) {
                  setState(() {
                    userName = value;
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
                  onTap: () => _submitData(userName, password),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)),
                  ))
            ],
          ),
        )
        // ignore: avoid_unnecessary_containers
        );
  }
}
