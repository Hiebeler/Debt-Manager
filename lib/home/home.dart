import 'package:debtmanager/home/add_debt.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
        title: const Center(child: Text("Home")),
      ),
      body: Container(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const AddDebt()))
              }),
    );
  }
}
