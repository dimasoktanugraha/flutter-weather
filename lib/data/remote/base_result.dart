enum ResponseStatus { success, error }

class BaseResult<T> {
  BaseResult(
      {this.statusCode,
      required this.status,
      required this.data,
      required this.message,
      required this.errorCode,
      required this.errorDesc});

  late final int? statusCode;
  late final ResponseStatus status;
  final T? data;
  late final String message;
  late final dynamic errorCode;
  late final String errorDesc;

  static BaseResult<T> success<T>(T data) {
    return BaseResult(
        status: ResponseStatus.success,
        data: data,
        message: '',
        errorCode: 0,
        errorDesc: '');
  }

  static BaseResult<T> error<T>(dynamic code, String name, String message) {
    return BaseResult(
      status: ResponseStatus.error,
      data: null,
      errorCode: code,
      errorDesc: name,
      message: message,
    );
  }
}
