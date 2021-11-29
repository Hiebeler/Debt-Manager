import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(onPressed: () => {}, child: Text("guten tag")),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (input) {},
                  decoration: const InputDecoration(
                    hintText: 'First name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Color.fromRGBO(121, 121, 121, 1))
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (input) {},
                  decoration: const InputDecoration(hintText: 'First name'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}