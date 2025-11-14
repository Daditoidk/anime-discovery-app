abstract class Failure{
String? message;
Failure({this.message});
}

class ServerFailure extends Failure{
   ServerFailure({super.message});
}

class CacheFailure extends Failure{
   CacheFailure({super.message});
}

class UnexpectedFailure extends Failure{
   UnexpectedFailure({super.message});
}

class NetworkFailure extends Failure{
   NetworkFailure({super.message});
}

class ApiFailure extends Failure{
   ApiFailure({super.message});
}