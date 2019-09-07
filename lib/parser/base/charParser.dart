import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fastParser.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

abstract class CharBaseParser extends FastParser<String>{

  @override
  Result<String> parse(Context context) {
    int value = context.seek();
    if (verify(value)) {
      return Success(context.move(1), String.fromCharCode(value));
    }
    return Failure(context, getFastParseMessage() + ' expected');
  }
  
  @override
  int fastParse(Context context, int offset) {
    int value = context.seek(offset);
    if (verify(value)) {
      return offset + 1;
    }    
    return -1;    
  }

  @override
  String getFastParseResult(Context context, int initialOffset, int resultPosition) {
    return String.fromCharCode(context.seek(initialOffset));
  }

  bool verify(int charCode);
}

