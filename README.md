# Positioned Popup Package

This package provides a customizable popup dialog widget for Flutter applications. With this package, users can easily create popup dialogs with various customizations such as setting solid color backgrounds, gradient color backgrounds, and even blurred backgrounds. Additionally, this package addresses an issue with Flutter's popup menu button where the menu closes only after selecting an item or tapping outside the menu area.

## Features

- **Customizable Popup Dialog:** Easily create popup dialogs with custom backgrounds and styles.
- **Solid Color Backgrounds:** Set solid color backgrounds for your popup dialogs.
- **Gradient Color Backgrounds:** Apply gradient color backgrounds to enhance visual appeal.
- **Blurred Backgrounds:** Add a blurred effect to the background for a modern look.
- **Fixed Popup Menu Issue:** Resolve the issue with Flutter's popup menu button, ensuring it closes as expected.

## Installation

To use this package, add `positioned_pop_up` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  positioned_pop_up: ^1.0.0
```

Then, run:

```bash
$ flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:positioned_pop_up/positioned_simple_pop_up.dart';
```

Now, you can create popup dialogs anywhere in your Flutter application. Here's a simple example:

```dart
PositionedSimplePopUp(
  position: Offset(
    100,
    200,
  ),
  barrierColor: Colors.red,
  content: Container(
    width: 200,
    height: 100,
    child: Text("Positioned Popup"),
  ),
).show(context);
```

## Example

Here's a more detailed example demonstrating various customizations:

```dart
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
      body: Center(
        child: PositionedPopUpButton(
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
                    color: color,
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
            )
          ],
        ),
      ),
    );
  }
}

```

## Support and Feedback

If you encounter any issues or have suggestions for improvements, feel free to open an issue on [GitHub](https://github.com/baharehkeivani/positioned_pop_up.git). Your feedback is highly appreciated!

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Enjoy using the Popup Dialog package in your Flutter projects! If you have any questions or need further assistance, don't hesitate to reach out.
