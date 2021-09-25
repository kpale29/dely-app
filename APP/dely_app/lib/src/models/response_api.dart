import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {

  String? message;
  String? error;
  late bool succes;
  dynamic? data;

  ResponseApi({
    this.message,
    this.error,
    required this.succes,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
  message =  json["message"];
  error = json["error"];
  succes = json["success"];

    try {
      data = json['data'];
    } catch (e) {
      print('Exception data $e');
    } 

  }
  Map<String, dynamic> toJson() => {
      "message": message,
      "error": error,
      "succes": succes,
  };
}
