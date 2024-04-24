import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/screen/auth/bloc/auth_bloc.dart';
import 'package:youapp_code_challenge/screen/auth/login_screen.dart';
import 'package:integration_test/integration_test.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget({required Widget child, required AuthBloc auth}) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(),
          )
        ],
        child: MaterialApp(
          home: child,
        ));
  }
  
  testWidgets("email/username or password is empty, does not login", (widgetTester) async{

    MockAuthBloc bloc = MockAuthBloc();

    bool didSignIn  = false;

    LoginScreen screen = LoginScreen(onLogin: ()=> didSignIn = true);

    await widgetTester.pumpWidget(makeTestableWidget(child: screen, auth: bloc));

    await widgetTester.tap(find.byKey(const Key("login")));

    verifyNever(bloc.add(LoginEvent(RegisterPayload('', '', ''))));

    expect(didSignIn, false);

  });

  testWidgets("email/username or password is correct, can login", (widgetTester) async{

    WidgetsFlutterBinding.ensureInitialized();

    MockAuthBloc bloc = MockAuthBloc();

    when(bloc.add(LoginEvent(RegisterPayload('email', 'email', 'password')))).thenAnswer((realInvocation) => Future.value("access_token"));

    bool didSignIn  = false;

    LoginScreen screen = LoginScreen(onLogin: ()=> didSignIn = true);

    await widgetTester.pumpWidget(makeTestableWidget(child: screen, auth: bloc));

    await widgetTester.enterText(find.byKey(const Key("email")), "waiphyoaung@gmail.com");

    await widgetTester.enterText(find.byKey(const Key("password")), "aaAA11@@");

    await widgetTester.tap(find.byKey(const Key("login")));

    verify(bloc.add(LoginEvent(RegisterPayload('email', 'email', 'password')))).called(2);

    expect(didSignIn, true);

  });

}
