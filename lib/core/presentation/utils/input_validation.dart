import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

class InputConverter{
  Either<Failures,int> stringToUnsignedInteger(String string){
    try{
      final integer = int.parse(string);
      if(integer < 0) throw const FormatException();
      return Right(integer);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InvalidInputFailure extends Failures{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
