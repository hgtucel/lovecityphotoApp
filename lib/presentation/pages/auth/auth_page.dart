import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovecity_app/application/auth/auth_cubit.dart';
import 'package:lovecity_app/application/auth/auth_state.dart';
import 'package:lovecity_app/domain/auth/user_model.dart';
import 'package:lovecity_app/presentation/pages/city/city_list_page.dart';
import 'package:lovecity_app/presentation/widgets/custom_flat_button.dart';
import 'package:lovecity_app/presentation/widgets/custom_text_field.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController _controller = PageController();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth"),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
            return _buildUI();
          }, listener: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthLoaded) {
              return Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CityListPage()),
                  (route) => false);
            } else if (state is AuthError) {
              print(state.message);
            }
          })
        ],
      ),
    );
  }

  Widget _buildUI() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 500,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [_signIn(), _signUp()],
      ),
    );
  }

  Widget _signIn() {
    return Column(
      children: [
        CustomTextField(
          icon: Icons.email,
          labelText: "E-Mail",
          keyboardType: TextInputType.emailAddress,
          inputAction: TextInputAction.next,
          onChanged: (val) => _email = val,
        ),
        CustomTextField(
          icon: Icons.security,
          labelText: "Şifre",
          keyboardType: TextInputType.visiblePassword,
          inputAction: TextInputAction.done,
          onChanged: (val) => _password = val,
        ),
        CustomFlatButton(
          size: Size(double.infinity, 54.0),
          color: Colors.amber,
          text: "Giriş",
          onPressed: () {
            final user = UserModel(email: _email, password: _password);
            BlocProvider.of<AuthCubit>(context).signIn(user);
          },
        ),
        RichText(
          text: TextSpan(
              text: "Hesabın yok mu? ",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: "Üye Ol",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.nextPage(
                            duration: Duration(microseconds: 1000),
                            curve: Curves.elasticInOut);
                      })
              ]),
        )
      ],
    );
  }

  Widget _signUp() {
    return Column(
      children: [
        CustomTextField(
          icon: Icons.email,
          labelText: "E-Mail",
          keyboardType: TextInputType.emailAddress,
          inputAction: TextInputAction.next,
          onChanged: (val) => _email = val,
        ),
        CustomTextField(
          icon: Icons.security,
          labelText: "Şifre",
          keyboardType: TextInputType.visiblePassword,
          inputAction: TextInputAction.done,
          onChanged: (val) => _password = val,
        ),
        CustomFlatButton(
          size: Size(double.infinity, 54.0),
          color: Colors.amber,
          text: "Üye Ol",
          onPressed: () {
            final user = UserModel(email: _email, password: _password);
            BlocProvider.of<AuthCubit>(context).signUp(user);
          },
        ),
        RichText(
          text: TextSpan(
              text: "Zaten hesabın var mı? ",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: "Giriş Yap",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.previousPage(
                            duration: Duration(microseconds: 1000),
                            curve: Curves.elasticInOut);
                      })
              ]),
        )
      ],
    );
  }
}
