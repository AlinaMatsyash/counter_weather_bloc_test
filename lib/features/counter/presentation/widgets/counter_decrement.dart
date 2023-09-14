import 'package:counter_weather_bloc/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterDecrement extends StatelessWidget {
  const CounterDecrement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return state == 0
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(Decrement());
                },
                child: const Icon(Icons.remove),
              );
      },
    );
  }
}
