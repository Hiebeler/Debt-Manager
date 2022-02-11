import 'package:debtmanager/home/Debt-Card/card_conf_dialog.dart';
import 'package:flutter/material.dart';

class DebtCard extends StatelessWidget {
  final String person;
  final String description;
  final double value;
  final Color color;
  final int debtId;
  final String field;

  const DebtCard(
      {
        required this.debtId,
        required this.field,
        required this.person,
      required this.description,
      required this.value,
      required this.color});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 1,
                  ),
                  Center(
                    child: Text(person,
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onSecondary)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        Card_conf_dialog alert = Card_conf_dialog(debtId: debtId, field: field,);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: Text(value.toString() + " €",
                        style: TextStyle(fontSize: 17, color: color)),
                  ),
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
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
