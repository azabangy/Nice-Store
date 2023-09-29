
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CardState{

}
class UpdateCardCounter extends CardState{}
class DataLoading extends CardState{}
class DataSuccess extends CardState{}
class DataFailure extends CardState{}
