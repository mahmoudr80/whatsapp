import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_text_style.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/feature/chat/presentation/widgets/chat_list_success_widget.dart';
import '../cubit/chat_cubit.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getChats();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chats', style: AppTextStyle.font24BlackBold),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                    IconButton(onPressed: () {
                      Navigator.pushNamed(context, Routes.selectChat);
                    },
                        icon: const Icon(Icons.edit_outlined)),
                  ],
                )
              ],
            ),
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(

              builder: (context, state) {
                if (state is ChatListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatListSuccess) {
                  return  ChatListSuccessWidget(chats: state.chats);
                } else if (state is ChatListFailure) {
                  return Center(child: Text(state.error));
                }
                return const SizedBox.shrink();
              },
            ),
        )
          ],
        ),
      ),
    );
  }
}
