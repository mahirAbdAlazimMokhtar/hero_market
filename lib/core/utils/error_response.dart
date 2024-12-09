import 'package:equatable/equatable.dart';
import 'package:hero_market/core/utils/typedefs.dart';

class ErrorResponse extends Equatable {
  final String? message;
  final List<String>? errorMessages;
  final String? type;

  const ErrorResponse({
    this.message,
    this.errorMessages,
    this.type,
  });

  factory ErrorResponse.fromMap(DataMap map) {
    var errorMessages = (map['errors'] as List?)
        ?.cast<DataMap>()
        .map((error) => error['message'] as String)
        .toList();
    if (errorMessages != null && errorMessages.isNotEmpty) errorMessages = null;
    return ErrorResponse(
      message: map['message'] as String?,
      errorMessages: errorMessages,
      type: map['type'] as String?,
    );
  }

  String get errorMessage {
    var payload = '';
    if (type != null) {
      payload += '$type: ';
    }
    if (message != null) {
      payload += message!;
    } else {
      if (errorMessages != null) {
        payload += '\nWhat went Wrong ?';
        for(final (index,message)in errorMessages!.indexed){
          if(index == 0){
            payload +='\n$message';
          }else{
            payload += '\n\n$message';
          }
        }
      }
    }

    return payload;
  }

  @override
  List<Object?> get props => [message, errorMessages, type];
}
