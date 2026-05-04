sealed class Result<T> {
  const Result();
  factory Result.success(T data) = Success;
  factory Result.failure(String message) = Failure;
}

class Failure<T> extends Result<T>{
  final String message;
   Failure(this.message);
}
class Success<T> extends Result<T>{
  final T data;
  Success(this.data);
}