import 'package:flutter_test/flutter_test.dart';
import 'package:module_home/module_home.dart';
import 'package:module_mine/module_mine.dart';
import 'package:module_profile/module_profile.dart';
import 'package:flutter_mulit_module/main.dart';

void main() {
  testWidgets('shows default features and switches tabs', (tester) async {
    registerHomeModule();
    registerMineModule();
    registerProfileModule();

    await tester.pumpWidget(const MyApp());

    expect(find.text('主页'), findsWidgets);
    expect(find.text('我的'), findsOneWidget);
    expect(find.text('计数器: 0'), findsOneWidget);

    await tester.tap(find.text('我的'));
    await tester.pump();

    expect(find.text('测试用户'), findsOneWidget);
    expect(find.text('个人信息设置'), findsOneWidget);

    await tester.tap(find.text('个人信息设置'));
    await tester.pumpAndSettle();

    expect(find.text('个人信息设置'), findsWidgets);
    expect(find.text('昵称'), findsOneWidget);
    expect(find.text('邮箱'), findsOneWidget);
  });
}
