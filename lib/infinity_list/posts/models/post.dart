import 'package:equatable/equatable.dart';

class Post with EquatableMixin {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [userId, id, title, body];
}
