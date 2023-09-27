import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main simple
/*
void main() {
  runApp(MyApp());
}
*/
/// Muchos proveedores desde Main
/*
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProviderClass1()),
      ChangeNotifierProvider(create: (_) => MyProviderClass2()),
    ],
    child: MyApp(),
  ));
}
*/

/// Un solo proveedor desde Main
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProviderClass1(),
      child: MyApp(),
    ),
  );
}

/// ChangeNotifier = Observable : Proporciona notificaciones de cambios a sus oyentes
/// ChangeNotifierProvider : Widget q' proporciona una instancia del ChangeNotifier a los descendientes
/// Consumer : Widget para usar la clase con el ChangeNotifier correspondiente.
/// Provider.of : Acceder al listener sin tener que reconstruir el widget.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProviderClass2(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Level2();
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Level3(),
        SizedBox(
          height: 30.0,
        ),
        Level4(),
        SizedBox(
          height: 30.0,
        ),
        Level5(),
        SizedBox(
          height: 30.0,
        ),
        MyTextfield(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  const Level3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'You have pushed the button this many times',
          style: TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15.0,
        ),
        TextButton(
            onPressed: () {
              var counter = context.read<MyProviderClass1>();
              counter.increment();
            },
            child: const Icon(
              Icons.add,
              size: 50.0,
            )),
      ],
    );
  }
}

/// Forma de usar el Provider.of (sin actualización de datos)
class Level4 extends StatelessWidget {
  const Level4({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<MyProviderClass2>(context, listen: false).data,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}

/// Forma de usar el Provider.of (con actualización de datos)
class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<MyProviderClass2>(context).data);
  }
}

/// Forma de usar el Consumer
class Level5 extends StatelessWidget {
  const Level5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          'Number is:',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Consumer<MyProviderClass1>(builder: (context, data, child) {
          return Text(
            '${data.value}',
            style: const TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          );
        }),
      ],
    );
  }
}

class MyTextfield extends StatelessWidget {
  const MyTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newText) {
        var myProviderClass2 = context.read<MyProviderClass2>();
        myProviderClass2.changeData(newText);
      },
    );
  }
}

class MyProviderClass1 with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}

class MyProviderClass2 with ChangeNotifier {
  String data = 'Top Secret';

  void changeData(String newData) {
    data = newData;
    notifyListeners();
  }
}
