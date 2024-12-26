/// ### Failure 
/// 
/// This class is used to handle errors in the application.
/// 
/// #### Properties:
/// * [message] is the error message.
/// 
/// #### Author: 
/// Gonzalo Quedena
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// ### ServerFailure
/// 
/// This class is used to handle server errors in the application.
/// 
/// #### Properties:
/// * [message] is the error message.
/// 
/// #### Author: 
/// Gonzalo Quedena
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// ### CacheFailure
/// 
/// This class is used to handle cache errors in the application.
/// 
/// #### Properties:
/// * [message] is the error message.
/// 
/// #### Author: 
/// Gonzalo Quedena
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}