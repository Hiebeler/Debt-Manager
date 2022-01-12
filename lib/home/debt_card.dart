import 'package:flutter/material.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 4,
      color: const Color.fromRGBO(34, 38, 41, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            const Center(
              child: Text("Person",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(121, 121, 121, 1))),
            ),
            const SizedBox(height: 7),
            Row(children: const [
              Expanded(
                child: Text("Value",
                    style: TextStyle(color: Colors.white70)),
              ),
              Expanded(
                child: Text("Description",
                    style: TextStyle(color: Color.fromRGBO(121, 121, 121, 1))),
              ),
            ]
            )
          ],
        ),
      ),
    );
  }
}