// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel {
  String? status;
  dynamic result;
  ResponseModel({
    this.status,
    required this.result,
  });

  ResponseModel copyWith({
    String? status,
    dynamic result,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'result': result,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'] != null ? map['status'] as String : null,
      result: map['result'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseModel(status: $status, result: $result)';

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ result.hashCode;
}
