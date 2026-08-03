class UnicodeGraphemeFixture {
  const UnicodeGraphemeFixture({
    required this.description,
    required this.input,
    required this.graphemes,
    required this.reversed,
  });

  final String description;
  final String input;
  final List<String> graphemes;
  final String reversed;
}

class UnicodeWordFixture {
  const UnicodeWordFixture({
    required this.description,
    required this.input,
    required this.words,
    this.camelCase,
    this.kebabCase,
    this.snakeCase,
  });

  final String description;
  final String input;
  final List<String> words;
  final String? camelCase;
  final String? kebabCase;
  final String? snakeCase;
}

class UnicodeTransformFixture {
  const UnicodeTransformFixture({
    required this.description,
    required this.input,
    this.capitalize,
    this.titleCase,
    this.slugify,
    this.latinize,
  });

  final String description;
  final String input;
  final String? capitalize;
  final String? titleCase;
  final String? slugify;
  final String? latinize;
}

const unicodeGraphemeFixtures = <UnicodeGraphemeFixture>[
  UnicodeGraphemeFixture(
    description: 'combining acute accent stays attached to the base letter',
    input: 'cafe\u0301',
    graphemes: ['c', 'a', 'f', 'e\u0301'],
    reversed: 'e\u0301fac',
  ),
  UnicodeGraphemeFixture(
    description: 'combining tilde stays attached during reverse',
    input: 'man\u0303ana',
    graphemes: ['m', 'a', 'n\u0303', 'a', 'n', 'a'],
    reversed: 'anan\u0303am',
  ),
  UnicodeGraphemeFixture(
    description: 'family emoji remains a single grapheme cluster',
    input: '👨‍👩‍👧‍👦',
    graphemes: ['👨‍👩‍👧‍👦'],
    reversed: '👨‍👩‍👧‍👦',
  ),
  UnicodeGraphemeFixture(
    description: 'flag emoji remains a single grapheme cluster',
    input: '🇮🇳',
    graphemes: ['🇮🇳'],
    reversed: '🇮🇳',
  ),
  UnicodeGraphemeFixture(
    description: 'emoji with skin tone and zwj remains intact while reversing',
    input: '👩🏽‍💻 works',
    graphemes: ['👩🏽‍💻', ' ', 'w', 'o', 'r', 'k', 's'],
    reversed: 'skrow 👩🏽‍💻',
  ),
];

const unicodeWordFixtures = <UnicodeWordFixture>[
  UnicodeWordFixture(
    description: 'decomposed latin words are matched as one word',
    input: 'cafe\u0301',
    words: ['cafe\u0301'],
    camelCase: 'cafe\u0301',
  ),
  UnicodeWordFixture(
    description: 'acronyms split cleanly from mixed-case identifiers',
    input: 'XMLHttpRequest',
    words: ['XML', 'Http', 'Request'],
    camelCase: 'xmlHttpRequest',
    kebabCase: 'xml-http-request',
    snakeCase: 'xml_http_request',
  ),
  UnicodeWordFixture(
    description: 'devanagari sentences split into words',
    input: 'नमस्ते दुनिया',
    words: ['नमस्ते', 'दुनिया'],
    camelCase: 'नमस्तेदुनिया',
    kebabCase: 'नमस्ते-दुनिया',
    snakeCase: 'नमस्ते_दुनिया',
  ),
  UnicodeWordFixture(
    description: 'arabic sentences split into words',
    input: 'مرحبا بالعالم',
    words: ['مرحبا', 'بالعالم'],
    camelCase: 'مرحبابالعالم',
    kebabCase: 'مرحبا-بالعالم',
    snakeCase: 'مرحبا_بالعالم',
  ),
  UnicodeWordFixture(
    description: 'zwj emoji words stay searchable around plain text',
    input: '👩🏽‍💻 works',
    words: ['👩🏽', '💻', 'works'],
    camelCase: '👩🏽💻Works',
  ),
];

const unicodeTransformFixtures = <UnicodeTransformFixture>[
  UnicodeTransformFixture(
    description: 'decomposed accents can be latinized and slugified',
    input: 'cafe\u0301',
    capitalize: 'Cafe\u0301',
    titleCase: 'Cafe\u0301',
    latinize: 'cafe',
    slugify: 'cafe',
  ),
  UnicodeTransformFixture(
    description: 'combining marks survive capitalization while latinize simplifies',
    input: 'man\u0303ana',
    capitalize: 'Man\u0303ana',
    titleCase: 'Man\u0303ana',
    latinize: 'manana',
    slugify: 'manana',
  ),
  UnicodeTransformFixture(
    description: 'turkish dotted i normalizes for latin-oriented transforms',
    input: 'İstanbul',
    capitalize: 'İstanbul',
    titleCase: 'İstanbul',
    latinize: 'Istanbul',
    slugify: 'istanbul',
  ),
  UnicodeTransformFixture(
    description: 'eszett keeps case behavior and transliterates for slugs',
    input: 'Straße',
    capitalize: 'Straße',
    titleCase: 'Straße',
    latinize: 'Strase',
    slugify: 'strase',
  ),
];
