import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/helpers/colors.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Главная",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocListener<HomepageBloc, HomepageState>(
          listener: (context, state) {
            if (state is HomepageErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: ${state.error}')));
            }
          },
          child: BlocBuilder<HomepageBloc, HomepageState>(
              builder: (context, state) {
            if (state is HomepageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomepageChoiceWorkoutSuccess) {
              return ListView.builder(
                itemCount: state.workouts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.workouts[index].name),
                  );
                },
              );
            } else if (state is InitialState) {
              return const Center(
                child: Text('Нет данных'),
              );
            }
            return const Center(
              child: Text("Ничего не отработало"),
            );
          }),
        ));
  }
}
