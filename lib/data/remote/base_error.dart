import 'dart:convert';

class BaseError {
    final String? cod;
    final String? message;

    BaseError({
        this.cod,
        this.message,
    });

    factory BaseError.fromJson(String str) => BaseError.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BaseError.fromMap(Map<String, dynamic> json) => BaseError(
        cod: json["cod"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
    };
}