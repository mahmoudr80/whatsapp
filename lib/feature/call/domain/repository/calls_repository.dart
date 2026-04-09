import 'package:whatsapp/feature/call/data/model/call_model.dart';

abstract class CallsRepository {
   List<CallModel> getCalls();
}