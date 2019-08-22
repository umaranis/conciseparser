import 'package:dallang/context.dart';
import 'package:dallang/parser.dart';
import 'package:dallang/result.dart';
import 'package:dallang/success.dart';

import 'failure.dart';

CharParser char(Object charCode, [String message]) {
  return CharParser(charCode);
}

class CharParser extends Parser<String> {
  final Object char;
  final String message;

  CharParser(this.char, [this.message]);

  @override
  Result<String> parse(Context context) {    
    int col = context.pos.col;
    if(context.colExists(col)) {
      int code = toCharCode(char);
      int result = context.getCharCode(col);
      if(code == result) {
        return Success(context.moveCol(1), String.fromCharCode(result));
      }     
      
    }

    return Failure(context, message ?? '"${toReadableString(char)}" expected');
      
  }
  
}

/// Converts an object to a character code.
int toCharCode(Object element) {
  if (element is num) {
    return element.round();
  }
  final value = element.toString();
  if (value.length != 1) {
    throw ArgumentError('"$value" is not a character');
  }
  return value.codeUnitAt(0);
}

/// Converts a character to a readable string.
String toReadableString(Object element) {
  if (element is String && element.length > 1) {
    final buffer = StringBuffer();
    for (var i = 0; i < element.length; i++) {
      buffer.write(toReadableString(element[i]));
    }
    return buffer.toString();
  }
  final code = toCharCode(element);
  switch (code) {
    case 0x08:
      return '\\b'; // backspace
    case 0x09:
      return '\\t'; // horizontal tab
    case 0x0A:
      return '\\n'; // new line
    case 0x0B:
      return '\\v'; // vertical tab
    case 0x0C:
      return '\\f'; // form feed
    case 0x0D:
      return '\\r'; // carriage return
    case 0x22:
      return '\\"'; // double quote
    case 0x27:
      return "\\'"; // single quote
    case 0x5C:
      return '\\\\'; // backslash
  }
  if (code < 0x20) {
    return '\\x${code.toRadixString(16).padLeft(2, '0')}';
  }
  return String.fromCharCode(code);
}