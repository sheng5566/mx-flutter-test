import '../error/failure.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String LOCATION_FAILURE_MESSAGE =
    'Unable to locate your device, please turn on the location service.';

class Failure2Message {
  static String map(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case LocationFailure:
        return LOCATION_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
