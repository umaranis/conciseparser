import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class AndParser extends Parser {
  final Parser first, second;

  AndParser(this.first, this.second);

  @override
  Result parse(Context context) {
    final r1 = first.parse(context);
    if(r1.isSuccess) {
      final r2 = second.parse(r1.context);
      if(r2.isSuccess) {
        return Success(r2.context, [r1.value, r2.value]);
      }
      else {
        return r2;
      }
    }
    else {
      return r1;
    }
  }


}

