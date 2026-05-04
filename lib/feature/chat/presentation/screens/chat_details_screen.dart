import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/message_cubit.dart';
import '../../../../gen/assets.gen.dart';
import '../../data/models/chat_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_nav_bar.dart';
import '../widgets/message_list_view.dart';


class ChatDetailsScreen extends StatefulWidget {
  final ChatModel chat;

  const ChatDetailsScreen({super.key, required this.chat});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getMessages(chatId: widget.chat.chatID);
  }

  @override
  Widget build(BuildContext context) {
     UserModel ?user ;
    widget.chat.participantData
    .forEach((key, value) {
      if(key!=FirebaseAuth.instance.currentUser?.uid){
        user= UserModel(name: value.name,
            image: value.image, email: '');
        return;
      }
    },);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Assets.images.backgroundChatImg2.image(fit: BoxFit.cover),
            ),
            Column(
              children: [
                ChatAppBar(
                  name: user?.name??'',
                  image: user?.image??'',
                ),
                const Expanded(
                  child: MessageListView(),
                ),
                BlocListener<MessageCubit,MessageState>
                  (listener: (BuildContext context, MessageState state) {  },
                  child:  ChatNavBar(chatID: widget.chat.chatID)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
