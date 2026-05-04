import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/di/dependency_injection.dart';
import 'package:whatsapp/feature/authorization/presentation/cubit/authorization_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/message_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/users_cubit.dart';
import 'package:whatsapp/feature/profile/presentation/screens/update_email_screen.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/feature/nav_screen/navigation_screen.dart';
import '../../feature/authorization/presentation/authorization_screen.dart';
import '../../feature/chat/data/models/chat_model.dart';
import '../../feature/chat/presentation/screens/chat_details_screen.dart';
import '../../feature/chat/presentation/screens/chat_list_screen.dart';
import '../../feature/chat/presentation/screens/select_chat_screen.dart';

class Routes {
  static const String chatList = '/';
  static const String chatDetails = '/chatDetails';
  static const String navigation = '/navigation';
  static const String authorization = '/authorization';
  static const String updateEmail = '/updateEmail';
  static const String selectChat = '/selectChat';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.chatList:
        return MaterialPageRoute(
          builder: (_) => const ChatListScreen(),
        );
      case Routes.chatDetails:
        final chat = settings.arguments as ChatModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
  create: (context) => getIt<MessageCubit>(),
  child: ChatDetailsScreen(chat: chat)),
);
      case Routes.selectChat:
        return MaterialPageRoute(
          builder: (_) =>BlocProvider(
              create: (context) => getIt<UsersCubit>()..getUsers()
              ,child:  const SelectChatScreen()));
      case Routes.navigation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NavigationCubit>(),
            child: NavigationScreen(),
          ),
        );
      case Routes.authorization:
        return MaterialPageRoute(
          builder: (_) =>BlocProvider(create:
    (context) => getIt<AuthorizationCubit>(),child:
    const AuthorizationScreen(),
        ));
      case Routes.updateEmail:
        final oldEmail = settings.arguments as String;
        return MaterialPageRoute<Map<String, String>?>(
          builder: (_) => UpdateEmailScreen(oldEmail: oldEmail),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
