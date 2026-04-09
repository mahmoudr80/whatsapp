import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/feature/call/data/model/call_model.dart';
import 'package:whatsapp/feature/call/presentation/cubit/call_cubit.dart';
import 'package:whatsapp/feature/call/presentation/cubit/call_cubit.dart';
import 'package:whatsapp/feature/call/presentation/widgets/calls_app_bar.dart';
import 'package:whatsapp/feature/call/presentation/widgets/calls_list.dart';


class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CallCubit, CallState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CallsAppBar(
                  selectedSegment: state.index,
                  onSegmentChanged:(index) => context.read<CallCubit>().getCalls(index),
                ),
              ),
              Expanded(
                child: CallsList(calls:state.calls),
              ),
            ],
          );
        },
      ),
    );
  }
}