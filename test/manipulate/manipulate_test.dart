import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test(
      "should insert a provided string into the parent string at a provided index",
      () {
    expect("there".insert("Hullo ", 0), "Hullo there");
    expect("there".insert("hullo", 1), "thullohere");
    expect("there".insert("Hullo", 400), "there");
    expect("".insert("Hullo", 0), "Hullo");
  });

  test("should return the latinizes version of the string", () {
    expect("cafe\u0301".latinize(), 'cafe');
    expect("man\u0303ana".latinize(), 'manana');
    expect("anglikonų šiurkščios užrašinėti".latinize(),
        'anglikonu siurkscios uzrasineti');
    expect('Există peste 13.800 de localități în România'.latinize(),
        'Exista peste 13.800 de localitati in Romania');
  });

  test("should return reversed string", () {
    expect("Happy is sad".reverse(), "das si yppaH");
    expect("𝌆 bar mañana mañana".reverse(), 'anañam anañam rab 𝌆');
    expect('foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar'.reverse(),
        'rab\uD834\uDF06\u0303\u035C\u035D\u035Eoof');
    expect('foo\u0303\u035C\u035D\u035Ebar'.reverse(),
        'rabo\u0303\u035C\u035D\u035Eof');
  });

  test("should return the slug of a string", () {
    expect('BirdFlight'.slugify(), 'bird-flight');
    expect('__BIRD___FLIGHT___'.slugify(), 'bird-flight');
    expect('zborul păsării'.slugify(), 'zborul-pasarii');
    expect('Україна розташована в південно-східній частині Європи'.slugify(),
        'ukrayina-roztashovana-v-pivdenno-shidnij-chastini-yevropi');
    expect('foo\u0303\u035C\u035D\u035E bar'.slugify(), 'foo-bar');
  });

  test(
      'should splice the string at a given position, number of characters and addition string',
      () {
    expect('sting like a bee'.splice(0, 0, 'you should '),
        'you should sting like a bee');
    expect('sting like a bee'.splice(4, 6, 'as'), 'sting as a bee');
    expect('sting like a bee'.splice(16, 0, 'float like a butterfly'),
        'float like a butterfly');
    expect('make the days count'.splice(19, -100, 'matter'), 'matter');
  });
}
