import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:test/test.dart';

class ExpectParseHelper {
  void pass(Parser p, String input, Object? expectedResult) {
    var actual = p.parse(Context(input, 0));
    expect(actual.isSuccess, true, reason: actual.toString());
    expect(actual.value, expectedResult);
  }

  void fail(Parser p, String input, [String message = '']) {
    var actual = p.parse(Context(input, 0));
    expect(actual.isFailure, true, reason: 'Failure expected instead of Success');
    var resultString = actual.message!;
    if(message != '') {
      expect(resultString.contains(message), true, reason: 'Error message is not matching: \n >> ' + resultString + '\n >> ' + message );
    }
  }

  /// expect an exception
  void exception(Parser p, String input, Type exceptionType) {
    expect(
      () => p.parse(Context(input, 0)),
      throwsA((e) => e.runtimeType ==  exceptionType)
    );
  }

  void equalGrammar(Parser one, Parser two) {
    expect(one.equals(two), true);
  }
}

final expectParse = ExpectParseHelper();