import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
        title: const Center(child: Text("Debt-Manager")),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => {}, child: Text(""))),
              Expanded(child: ElevatedButton(onPressed: () => {}, child: Text("")))
            ],
          )

        ],
      ),
    );
  }
}
