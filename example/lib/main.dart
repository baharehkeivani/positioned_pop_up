import 'package:flutter/material.dart';
import 'package:positioned_pop_up/positioned_pop_up_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Positioned Popup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Positioned Popup Package'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Divider(color: Colors.white,),
          PositionedPopUpButton(backgroundIsBlurred: true,height: 150,
            button: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.purple,
              child: const Icon(Icons.touch_app),
            ),
            items: [
              StatefulBuilder(
                builder: (context, itemSetState) {
                  return InkWell(
                    child: Container(
                      height: 80,
                      child: const Text("First Item"),
                    ),
                    onHover: (value) {
                      itemSetState(() {
                        if (value) {
                          color = Colors.deepOrangeAccent;
                        } else {
                          color = Colors.red;
                        }
                      });
                    },
                    onTap: () {
                      itemSetState(() {
                        color = Colors.purpleAccent;
                      });
                    },
                  );
                },
              ),StatefulBuilder(
                builder: (context, itemSetState) {
                  return InkWell(
                    child: Container(
                      height: 80,
                      child: const Text("First Item"),
                    ),
                    onHover: (value) {
                      itemSetState(() {
                        if (value) {
                          color = Colors.deepOrangeAccent;
                        } else {
                          color = Colors.red;
                        }
                      });
                    },
                    onTap: () {
                      itemSetState(() {
                        color = Colors.purpleAccent;
                      });
                    },
                  );
                },
              ),StatefulBuilder(
                builder: (context, itemSetState) {
                  return InkWell(
                    child: Container(
                      height: 80,
                      child: const Text("First Item"),
                    ),
                    onHover: (value) {
                      itemSetState(() {
                        if (value) {
                          color = Colors.deepOrangeAccent;
                        } else {
                          color = Colors.red;
                        }
                      });
                    },
                    onTap: () {
                      itemSetState(() {
                        color = Colors.purpleAccent;
                      });
                    },
                  );
                },
              ),StatefulBuilder(
                builder: (context, itemSetState) {
                  return InkWell(
                    child: Container(
                      height: 80,
                      child: const Text("First Item"),
                    ),
                    onHover: (value) {
                      itemSetState(() {
                        if (value) {
                          color = Colors.deepOrangeAccent;
                        } else {
                          color = Colors.red;
                        }
                      });
                    },
                    onTap: () {
                      itemSetState(() {
                        color = Colors.purpleAccent;
                      });
                    },
                  );
                },
              ),
            ],
          ),Divider(color: Colors.white,),Divider(color: Colors.white,),
          Divider(color: Colors.white,),
        ],
      ),
    );
  }
}
