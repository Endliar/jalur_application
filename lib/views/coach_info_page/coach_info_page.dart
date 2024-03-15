import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/couch_data_page/coach_workout_bloc.dart';
import 'package:jalur/bloc/couch_data_page/coach_workout_event.dart';
import 'package:jalur/bloc/couch_data_page/coach_workout_state.dart';
import 'package:jalur/models/coach.dart';
import 'package:jalur/response_api/get_coach_data.dart';
import 'package:jalur/views/coach_info_page/coach_detail_page.dart';

import '../../helpers/colors.dart';

class CoachInfoPage extends StatelessWidget {
  final List<Coach> coaches;
  const CoachInfoPage({super.key, required this.coaches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Тренера",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: coaches.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10.0)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'http://89.104.69.88/storage/${coaches[index].image}'))),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${coaches[index].firstName} ${coaches[index].id}',
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<CoachDataBloc>(
                                    create: (context) =>
                                        CoachDataBloc((GetCoachData()))
                                          ..add(CoachDetailButtonPressed(
                                              coachId: coaches[index].id)),
                                    child: BlocBuilder<CoachDataBloc,
                                        CoachDataState>(
                                      builder: (context, state) {
                                        if (state is LoadingCoachDataState) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is LoadCoachDataSuccess) {
                                          return CoachDetailPage(
                                            coach: state.coaches.first,
                                          );
                                        } else if (state is CoachErrorState) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${state.error}'));
                                        }
                                        return const Center(
                                          child: Text('Данные не загружены'),
                                        );
                                      },
                                    ),
                                  ),
                                ));
                              },
                              child: const Text('Подробнее'),
                            ))
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
