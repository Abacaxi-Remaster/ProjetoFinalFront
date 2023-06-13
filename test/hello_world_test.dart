import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_front/Paginas/HelloWorld.dart';

void main() {
  test('Printing "Hello, World!" should be successful', () {
    final output = getHelloWorld();

    expect(output, equals('Hello, World!'));
  });
}
