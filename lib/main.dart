import 'package:counter_app/color_bloc/color_bloc.dart';
import 'package:counter_app/color_bloc/color_state.dart';
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
    return MultiBlocProvider(providers: [
      BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
      ),
      BlocProvider<ColorBloc>(
        create: (context) => ColorBloc(),
      )
    ], child: const MaterialApp(home: MyHomePage()));

    //  BlocProvider<CounterBloc>(
    //     create: (context) => CounterBloc(),
    //     child: const MaterialApp(home: MyHomePage()));
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
          BlocBuilder<ColorBloc, ColorState>(builder: (context, state) {
            return Container(
              height: 200,
              width: 200,
              color: state.color,
            );
          }),
          // it rebuilds the Ui based on state, takes a bloc and a state
          BlocBuilder<CounterBloc, CounterState>(

              // u can use buildwhen for conditional Ui Update
              //   buildWhen: (previous, current) {
              // // print(previous.counter);
              // // print(current.counter);
              // return true; },
              builder: (context, state) {
            return Text(
              state.counter.toString(),
              style: const TextStyle(fontSize: 20),
            );
          }),
          // BlocConsumer<CounterBloc, CounterState>(builder: (context, state) {
          //   return Text(state.counter.toString());
          // }, listener: (context, state) {
          //   if (state.counter >= 5) {
          //     final snackBar = SnackBar(
          //       /// need to set following properties for best effect of awesome_snackbar_content
          //       elevation: 0,
          //       behavior: SnackBarBehavior.floating,
          //       backgroundColor: Colors.transparent,
          //       content: AwesomeSnackbarContent(
          //         title: 'Its Working',
          //         message: 'You have reached the Goal. !!',

          //         /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          //         contentType: ContentType.success,
          //       ),
          //     );

          //     ScaffoldMessenger.of(context)
          //       ..hideCurrentSnackBar()
          //       ..showSnackBar(snackBar);
          //   }
          // }),
          // BlocListener<CounterBloc, CounterState>(
          //   listener: (context, state) {
          //     if (state.counter >= 5) {
          //       final snackBar = SnackBar(
          //         /// need to set following properties for best effect of awesome_snackbar_content
          //         elevation: 0,
          //         behavior: SnackBarBehavior.floating,
          //         backgroundColor: Colors.transparent,
          //         content: AwesomeSnackbarContent(
          //           title: 'Its Working',
          //           message: 'This is an example !!',

          //           /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          //           contentType: ContentType.success,
          //         ),
          //       );

          //       ScaffoldMessenger.of(context)
          //         ..hideCurrentSnackBar()
          //         ..showSnackBar(snackBar);
          //     }
          //   },
          //   child: const Text("Bloc Listener"),
          // ),

          // BlocSelector<CounterBloc, CounterState, bool>(
          //     selector: (state) => state.counter >= 5 ? true : false,
          //     builder: (context, state) {
          //       return Container(
          //         height: 200,
          //         width: 200,
          //         color: state ? Colors.green : Colors.amber,
          //       );
          //     }),
          // const SizedBox(
          //   height: 40,
          // ),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterIncrementEvent());
                  context.read()<ColorBloc>().add(CounterIncrementEvent());
                },
                child: const Icon(Icons.add),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterDecrementEvent());
                  context.read()<ColorBloc>().add(CounterDecrementEvent());
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
