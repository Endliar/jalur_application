import 'package:equatable/equatable.dart';

class RecoilState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecoilInitialState extends RecoilState {}

class RecoilLoadingState extends RecoilState {}

class RecoilSuccessState extends RecoilState {}

class RecoilErrorState extends RecoilState {
  final String message;
  RecoilErrorState(this.message);

  @override
  List<Object> get props => [message];
}
