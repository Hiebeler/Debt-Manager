import 'package:debtmanager/home/side_bar.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: Center(child: Text("Friends")),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 100,
                  ),
                  Text("hiebeler05",
                      style: Theme.of(context).textTheme.headline3)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("email: ", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 20),
                  Text("emanuel.hiebeler@gmail.com",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    "Friends",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(const Radius.circular(3)),
                        border: Border.all(
                            width: 1.5,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 20,),
                            Text("kim"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
