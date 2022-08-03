import 'package:bloc_example2/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: BlocProvider(
          create: (context) => CounterCubit(),
          child: const MyHomePage(title: 'Bloc Practice')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocConsumer<CounterCubit, int>(
        bloc: cubit,
        listener: (context, state) {
          final snackbar = SnackBar(
            content: Text('State reached for $state times.'),
          );
          if (state % 5 == 0) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '$state',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lime,
                          minimumSize: const Size(80, 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onPressed: () {
                        cubit.incrementCounter();
                      },
                      child: const Text("ADD"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          minimumSize: const Size(80, 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onPressed: () {
                        cubit.decrementCounter();
                      },
                      child: const Text("MINUS"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        onPressed: () {
                          cubit.reset();
                        },
                        child: const Text('RESET'))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
