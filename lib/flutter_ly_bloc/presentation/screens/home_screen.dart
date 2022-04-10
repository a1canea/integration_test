import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bl/cubit/counter_cubit.dart';
import '../../bl/cubit/counter_state.dart';
import '../../bl/cubit/internet_cubit.dart';
import '../../bl/cubit/internet_state.dart';
import '../../constants/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // replacement for number '1' option with StreamSubscription
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text('Wifi');
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text('Mobile');
                } else if (state is InternetDisconnected) {
                  return Text('Disconnected');
                }
                return CircularProgressIndicator();
              },
            ),
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
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: Text('Go to Second screen'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: widget.color),
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              child: Text('Go to Third screen'),
            ),
          ],
        ),
      ),
    );
  }
}
