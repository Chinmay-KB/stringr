const _highSurrogateStart = 0xd800;
const _highSurrogateEnd = 0xdbff;
const _lowSurrogateStart = 0xdc00;
const _lowSurrogateEnd = 0xdfff;

/// Extension bundling helper surrogate functions
extension Surrogates on int {
  /// Checks if `codePoint` is a high-surrogate number from range 0xD800 to 0xDBFF.
  bool isHighSurrogate() =>
      this >= _highSurrogateStart && this <= _highSurrogateEnd;

  /// Checks if `codePoint` is a low-surrogate number from range 0xDC00 to 0xDFFF.
  bool isLowSurrogate() =>
      this >= _lowSurrogateStart && this <= _lowSurrogateEnd;
}

/// Get the astral code point number based on surrogate pair numbers.
int getAstralNumberFromSurrogatePair(int highSurrogate, int lowSurrogate) =>
    (highSurrogate - _highSurrogateStart) * 0x400 +
    lowSurrogate -
    _lowSurrogateStart +
    0x10000;
