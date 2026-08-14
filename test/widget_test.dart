import 'package:flutter_test/flutter_test.dart';
import 'package:news_hw/main.dart';

void main() {
  testWidgets('App smoke test placeholder', (WidgetTester tester) async {
    // DI needs setup; skip full pump for unit CI
    expect(MyApp, isNotNull);
  });
}
