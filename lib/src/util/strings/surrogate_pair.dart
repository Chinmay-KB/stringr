const _HIGH_SURROGATE_START = 0xd800;
const _HIGH_SURROGATE_END = 0xdbff;
const _LOW_SURROGATE_START = 0xdc00;
const _LOW_SURROGATE_END = 0xdfff;

/// Extension bundling helper surrogate functions
extension Surrogates on int {
  /// Checks if `codePoint` is a high-surrogate number from range 0xD800 to 0xDBFF.
  bool isHighSurrogate() =>
      this >= _HIGH_SURROGATE_START && this <= _HIGH_SURROGATE_END;

  /// Checks if `codePoint` is a low-surrogate number from range 0xDC00 to 0xDFFF.
  bool isLowSurrogate() =>
      this >= _LOW_SURROGATE_START && this <= _LOW_SURROGATE_END;
}

/// Get the astral code point number based on surrogate pair numbers.
int getAstralNumberFromSurrogatePair(int highSurrogate, int lowSurrogate) =>
    (highSurrogate - _HIGH_SURROGATE_START) * 0x400 +
    lowSurrogate -
    _LOW_SURROGATE_START +
    0x10000;
