import 'package:whatsapp/feature/call/data/model/call_model.dart';

import '../../domain/repository/calls_repository.dart';

class CallsRepositoryImpl implements CallsRepository{
  @override
   List<CallModel> getCalls() {
   return [
     CallModel(name: "Mahmoud Saeid",
         imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s",
         date: "1/4/2026", status:CallStatus.incoming),
     CallModel(name: "Ahmed Saeid",
         imageUrl:
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s"
         ,date: "28/3/2026", status:CallStatus.outgoing),
     CallModel(name: "Dalia",
         imageUrl:
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s"
         ,date: "20/3/2026", status:CallStatus.outgoing),
     CallModel(name: "Mostafa",
         imageUrl:
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s"         ,date: "5/3/2026", status:CallStatus.missed),
     CallModel(name: "Mohamed Ali",
         imageUrl:
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM9dMpC9td7opGNF1kH_ZHQrYMnP0GqMfpPQ&s"
         ,date: "20/2/2026", status:CallStatus.missed),
     CallModel(name: "Dalida",
         imageUrl:
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s"         ,date: "5/2/2026", status:CallStatus.outgoing),
     CallModel(name: "Amir Eid",
         imageUrl:
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MoTmVuBFt3jDsCnLjSFpBQKB9zV6kcrPlQ&s"
         ,date: "5/12/2025", status:CallStatus.missed),
     CallModel(name: "Sami Ahmed",
         imageUrl:
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM9dMpC9td7opGNF1kH_ZHQrYMnP0GqMfpPQ&s"
         ,date: "20/11/2025", status:CallStatus.missed),
   ];
  }

}