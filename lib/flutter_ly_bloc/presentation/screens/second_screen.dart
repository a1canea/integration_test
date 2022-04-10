import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bl/cubit/counter_cubit.dart';
import '../../bl/cubit/counter_state.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('You pressed button this many times:'),
          BlocConsumer<CounterCubit, CounterState>(
            builder: (context, state) {
              if (state.currentValue == 0) {
                return Text('zero');
              } else if (state.currentValue < 0) {
                return Text('negative ${state.currentValue}');
              } else {
                return Text(state.currentValue.toString());
              }
            },
            buildWhen: (prevState, state) {
              return state.currentValue != 5;
            },
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.isIncremented ? 'Increment' : 'Decrement'),
              ));
            },
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 1,
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                },
                backgroundColor: widget.color,
                child: Icon(Icons.remove),
              ),
              FloatingActionButton(
                heroTag: 2,
                onPressed: () {
                  context.read<CounterCubit>().increment();
                },
                backgroundColor: widget.color,
                child: Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.color),
            onPressed: () {},
            child: Text('Go to Second screen'),
          ),
        ],
      ),
    );
  }
}
