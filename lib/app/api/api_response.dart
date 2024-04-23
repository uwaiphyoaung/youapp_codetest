sealed class ApiResponse<S, E extends ApiError> {
  const ApiResponse();
}

final class Success<S, E extends ApiError> extends ApiResponse<S, E> {
  const Success(this.data);
  final S data;
}

final class Fail<S, E extends ApiError> extends ApiResponse<S, E> {
  const Fail(this.error);
  final E error;
}

class ApiError{
  final dynamic data;
  final int code;
  ApiError(this.data, this.code);
}