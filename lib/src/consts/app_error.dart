class AppError extends Error {
  final String log;
  final int code;

  AppError(this.log, this.code);

  @override
  String toString() => log;
}
