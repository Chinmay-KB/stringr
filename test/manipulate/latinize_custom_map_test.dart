import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

// This file mutates the exported `diacritics` map before the first
// `latinize()` call of the isolate, so it must stay in its own test file.
void main() {
  test('latinize applies ASCII entries added to the diacritics map', () {
    diacritics['bang'] = '!';
    diacritics['_'] = '-'; // single code unit replacement
    expect('hi!'.latinize(), 'hibang');
    expect('a-b'.latinize(), 'a_b');
    expect('café!'.latinize(), 'cafebang');
    expect('plain'.latinize(), 'plain');
  });
}
