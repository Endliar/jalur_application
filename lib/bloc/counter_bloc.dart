import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class CounterState {
  final int value;
  CounterState(this.value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterEvent>(
      (event, emit) {
        switch (event) {
          case CounterEvent.increment:
            emit(CounterState(state.value + 1));
            break;
          case CounterEvent.decrement:
            emit(CounterState(state.value - 1));
            break;
        }
      },
    );
  }
}
