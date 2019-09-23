import 'package:concisely/context.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:test/test.dart';
import 'helper.dart';

void main() {
  test('eof', () {
    var grammar = digit & eof;
    expectSuccess(
      parse("1", grammar), 
      ["1"]);
  });

  test('eof fail', () {
    var grammar = digit & eof;
    expectFailure(
      parse("12", grammar), 
      "End of File expected");
  });

  test('eof empty string', () {
    var grammar = eof;
    expectSuccess(
      parse("", grammar), 
      null);
  });

  test('eof fast parse', () {
    expect(
      eof.fastParse(Context("", 0), 0), 
      0);
  });
}