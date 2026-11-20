// ignore_for_file: avoid_print
import 'package:stringr/stringr.dart';

/// Tiny micro-benchmark. Run with `dart run benchmark/stringr_benchmark.dart`.
///
/// Numbers are indicative only (no isolation from JIT warm-up noise beyond a
/// warm-up pass); compare before/after on the same machine.
const _iterations = 20000;

const _inputs = <String, String>{
  'ascii': 'The quick brown fox jumps over the lazy dog',
  'accented': 'Există peste 13.800 de localități în România',
  'cyrillic': 'Україна розташована в південно-східній частині Європи',
};

int _sink = 0;

void _bench(String name, void Function() body) {
  for (var i = 0; i < _iterations ~/ 4; i++) {
    body();
  }
  final watch = Stopwatch()..start();
  for (var i = 0; i < _iterations; i++) {
    body();
  }
  watch.stop();
  print(
      '${name.padRight(24)} ${watch.elapsedMilliseconds.toString().padLeft(5)}'
      ' ms / $_iterations calls');
}

void main() {
  for (final entry in _inputs.entries) {
    final text = entry.value;
    _bench('latinize (${entry.key})', () => _sink += text.latinize().length);
  }
  for (final entry in _inputs.entries) {
    final text = entry.value;
    _bench('words (${entry.key})', () => _sink += text.words().length);
  }
  _bench(
      'titleCase (ascii)', () => _sink += _inputs['ascii']!.titleCase().length);
  // Keeps the work observable so it cannot be optimised away.
  if (_sink == -1) {
    print(_sink);
  }
}
