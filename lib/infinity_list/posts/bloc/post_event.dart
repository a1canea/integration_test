import 'package:equatable/equatable.dart';

abstract class PostEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {

}