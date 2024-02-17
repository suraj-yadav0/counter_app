import 'package:counter_app/counter_bloc/counter_bloc.dart';
import 'package:counter_app/counter_bloc/counter_event.dart';
import 'package:counter_app/counter_bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // bloc provider provides states to its children
    return BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: const MaterialApp(home: MyHomePage()));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // it rebuilds the Ui based on state, takes a bloc and a state
          BlocBuilder<CounterBloc, CounterState>(

              // u can use buildwhen for conditional Ui Update
              buildWhen: (previous, current) {
            // print(previous.counter);
            // print(current.counter);
            return true;
          }, builder: (context, state) {
            return Text(
              state.counter.toString(),
              style: const TextStyle(fontSize: 20),
            );
          }),
          // const SizedBox(
          //   height: 40,
          // ),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterIncrementEvent());
                },
                child: const Icon(Icons.add),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterDecrementEvent());
                },
                child: const Icon(Icons.remove),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
