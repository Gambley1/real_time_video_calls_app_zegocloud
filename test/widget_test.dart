// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:user_repository/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('App', () {
    late UserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      when(() => userRepository.user).thenAnswer(
        (_) => Stream.value(
          const User(id: '123', email: 'test@gmail.com', name: 'test'),
        ),
      );
    });

    testWidgets('renders AppView', (WidgetTester tester) async {
      await tester.pumpWidget(
        App(
          userRepository: userRepository,
          user: await userRepository.user.first,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
