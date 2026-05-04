import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/users_cubit.dart';
import 'select_chat_list_success.dart';

class SelectChatBody extends StatelessWidget {
  const SelectChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit,UsersState>(

      builder: (context, state) {
        if (state is UserListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserListSuccess) {
          return SelectChatListSuccess(users: state.users);
        } else if (state is UserListFailure) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
