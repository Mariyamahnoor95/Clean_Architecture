import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failures{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failures{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}