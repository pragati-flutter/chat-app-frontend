import 'package:chat_app/features/chat/domain/entities/user_entites.dart';

class UserModel extends UserEntity{
  const UserModel( {required super.userId, required super.userName});

  factory UserModel.fromUser(Map<String,dynamic>json){
    return UserModel(userId:json['userId'] , userName: json['userName']);

  }

  Map<String,dynamic>toJson(){
    return{
      'userId':userId,
      'userName':userName
    };
  }


}