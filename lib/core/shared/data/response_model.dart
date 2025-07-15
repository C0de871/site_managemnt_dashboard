// Create a generic base response model
class ApiResponse<T> {
  final String message;
  final int statusCode;
  final T data;

  static const String messageKey = 'message';
  static const String statusKey = 'status';
  static const String dataKey = 'data';

  ApiResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final dataValue = json[dataKey];
    T parsedData;

    if (dataValue != null) {
      parsedData = fromJsonT(dataValue);
    } else {
      // Provide default empty value based on type parameter
      parsedData = _getDefaultValue<T>() as T;
    }

    return ApiResponse<T>(
      message: json[messageKey] ?? '',
      statusCode: json[statusKey] ?? -1,
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T) toJsonT) {
    return {messageKey: message, statusKey: statusCode, dataKey: toJsonT(data)};
  }

  // Helper method to get default empty values based on type
  static dynamic _getDefaultValue<V>() {
    if (V == List || V.toString().contains('List')) {
      return [];
    } else if (V == Map || V.toString().contains('Map')) {
      return {};
    }
    return null;
  }
}
