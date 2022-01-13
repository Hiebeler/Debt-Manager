import 'package:debtmanager/home/add_debt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'SideBar.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String IOweOrIGet = "I Owe";

  changeIOweOrIGet(changeValue) {
    setState(() {
      IOweOrIGet = changeValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
        title: const Center(child: Text("Debt Manager")),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: IOweOrIGet == "I Owe"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 3, color: Theme.of(context).colorScheme.secondaryVariant),
                            ),
                          ),
                          child: IGetIOweButton(
                            text: "I Owe",
                            changeIOweOrIGet: changeIOweOrIGet,
                          ),
                        )
                      : IGetIOweButton(
                          text: "I Owe",
                    changeIOweOrIGet: changeIOweOrIGet,
                  ),
                ),
                Expanded(
                  child: IOweOrIGet == "I Get"
                      ? Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                        BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    child: IGetIOweButton(
                      text: "I Get",
                      changeIOweOrIGet: changeIOweOrIGet,
                    ),
                  )
                      : IGetIOweButton(
                    text: "I Get",
                    changeIOweOrIGet: changeIOweOrIGet,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(121, 121, 121, 1),
          ),
          onPressed: () => {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => AddDebt()))
              },
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(
            side: BorderSide(
              color: Color.fromRGBO(134, 194, 50, 1),
              width: 1,
            ),
          )),
    );
  }
}

class IGetIOweButton extends StatelessWidget {
  final String text;
  final Function changeIOweOrIGet;

  IGetIOweButton({required this.text, required this.changeIOweOrIGet});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        changeIOweOrIGet(text)
      },
      child: Text(text, style: Theme.of(context).textTheme.bodyText1,),
      style: ElevatedButton.styleFrom(
        onPrimary: const Color.fromRGBO(121, 121, 121, 1),
        primary: const Color.fromRGBO(23, 23, 23, 1),
        fixedSize: const Size(200, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
