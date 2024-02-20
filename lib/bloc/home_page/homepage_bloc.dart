import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {

  HomepageBloc(HomepageState initialState) : super(initialState){
   on<HomepageEvent>((event, emit) {});
  }
}
