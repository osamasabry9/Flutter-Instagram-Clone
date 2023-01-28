import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/get_message_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessageUseCase getMessageUseCase;
  ChatCubit({required this.getMessageUseCase,required this.sendMessageUseCase}) : super(ChatInitial());

  Future<void> getMessages({
    required String senderId,
    required String receiverId,
  })async{
    emit(ChatLoading());
    final streamResponse= getMessageUseCase.call(senderId: senderId, receiverId: receiverId);
    streamResponse.listen((messages) {
      emit(ChatLoaded(messages: messages));
    });
  }

  Future<void> sendTextMessage({required MessageEntity message})async{
    try{
      await sendMessageUseCase.call(message);
    }on SocketException catch(_){
      emit(ChatFailure());
    }catch(_){
      emit(ChatFailure());
    }
  }


}