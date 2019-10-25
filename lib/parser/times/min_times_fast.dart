import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/parser/times/min_times.dart';

class MinTimesFastParser extends MinTimesParser with FastParser, DefaultFastParseResult, TimesFastParser, IntrusiveFastParser {

  MinTimesFastParser(FastParser parser, int min) : super(parser, min);
  
  @override
  int fastParse(Context context, int position) {    
    
    int result;
    for(int i = 0; i < min; i++) {
      result = fastParser.fastParse(context, position);
      if (result != -1) {
        position = result;
      }
      else {
        return -1;
      }
    }

    while(true) {
      result = fastParser.fastParse(context, position);
      if(result != -1) {
        position = result;
      }
      else {        
        return position;
      }
    }   
  }  

}