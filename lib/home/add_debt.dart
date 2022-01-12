import 'package:debtmanager/home/debt_card.dart';
import 'package:flutter/material.dart';

class AddDebt extends StatelessWidget {
  AddDebt({Key? key}) : super(key: key);

  var person = "";
  var description = "";
  var value = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    onChanged: (input) {
                      person = input;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Person',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              width: 2.7)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (input) {
                      description = input;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              width: 2.7)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              width: 2.7)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () => {/*
                      signUp(context).then((value) => {
                        if (value == true)
                          {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Home()))
                          }
                      }),
                   */ },
                    child: const Text("Add new Debt",
                        style: TextStyle(
                            color: Color.fromRGBO(160, 160, 160, 1))),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(340, 50),
                      maximumSize: const Size(340, 50),
                      primary: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 17),
                    ),
                  ),
                  DebtCard(),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
