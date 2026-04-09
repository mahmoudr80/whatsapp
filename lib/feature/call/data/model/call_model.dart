 enum CallStatus  {outgoing,incoming,missed}
class CallModel {
  final String name;
  final String imageUrl;
  final String date;
  final CallStatus status;

  CallModel({required this.name,required  this.imageUrl,
    required  this.date,required  this.status});


}