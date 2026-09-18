import 'package:flutter_test/flutter_test.dart';
import 'package:smart_mirror_flutter_demo/main.dart';

void main() {
  testWidgets('renders smart mirror dashboard', (tester) async {
    await tester.pumpWidget(const SmartMirrorDemoApp());

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
    expect(find.text('Lightweight by design'), findsOneWidget);
  });
}
