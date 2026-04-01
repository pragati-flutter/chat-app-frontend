import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String userId;
  final String userName;

  const UserEntity({required this.userId, required this.userName});
  @override
  List<Object?> get props => [userId,userName];

}