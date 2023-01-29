import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stroy_state.dart';

class StroyCubit extends Cubit<StroyState> {
  StroyCubit() : super(StroyInitial());
}
