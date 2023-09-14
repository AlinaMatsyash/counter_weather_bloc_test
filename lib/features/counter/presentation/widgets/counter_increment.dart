import 'package:counter_weather_bloc/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterIncrement extends StatelessWidget {
  const CounterIncrement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return state == 10
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(Increment());
                },
                child: const Icon(Icons.add),
              );
      },
    );
  }
}
