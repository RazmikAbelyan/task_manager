import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc_example/auth_bloc/auth_event.dart';
import 'package:flutter_bloc_example/auth_bloc/auth_state.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userName;
  var _userEmail;
  var _userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: BlocProvider(
        create: (ctx) => AuthBloc(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (ctx, state) {
            if (state is AuthInitialState) {
              return Center(
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            if (!state.isLogin)
                              TextFormField(
                                key: ValueKey('username'),
                                decoration: InputDecoration(labelText: 'Username'),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 4) {
                                    return 'Please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userName = value;
                                },
                              ),
                            TextFormField(
                              key: ValueKey('email'),
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userEmail = value;
                              },
                            ),
                            TextFormField(
                              key: ValueKey('password'),
                              decoration: InputDecoration(labelText: 'Password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 6) {
                                  return 'Password  must be at least 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
                            RaisedButton(
                              onPressed: () {
                                _trySubmit(context: ctx, isLogin: state.isLogin);
                              },
                              child: Text(state.isLogin ? 'Login' : 'Signup'),
                              color: Theme.of(context).primaryColor,
                            ),

                            FlatButton(
                              onPressed: () {

                                ctx.read<AuthBloc>().add(AuthSwitchToSignUpEvent());
                              },
                              child: Text(
                                state.isLogin ? 'Create new account' : 'I already have an account',
                                style: TextStyle(color: Colors.lightGreen),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            // else if (state is AuthLoadingState) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            else if (state is AuthSuccessState) {
              Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacementNamed('/firebasePage');

              });
            }

            return Container();
          },
        ),
      ),
    );
  }

  void _trySubmit({BuildContext context, bool isLogin}) {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      if (isLogin) {
        context.read<AuthBloc>().add(AuthLoginEvent(
              logEmail: _userEmail,
              logPassword: _userPassword,
            ));
      } else {
        context.read<AuthBloc>().add(AuthSignUpEvent(
              username: _userName,
              password: _userPassword,
              email: _userEmail,
            ));
      }
    }
  }

  showAlertDialog({BuildContext context, AuthState state}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('dc'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthInitialEvent());
              },
              child: Text('Try again'),
            ),
          ],
        );
      },
    );
  }
}
