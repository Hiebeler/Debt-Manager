import 'package:flutter/material.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 4,
      color: Theme.of(context).colorScheme.onBackground,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(70, 70, 70, 1), width: 0.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              Center(
                child: Text("Kim",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).colorScheme.onSecondary)),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: Text("50,00€",
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                  Expanded(
                    child: Text(
                      "Gesamte schulden",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
