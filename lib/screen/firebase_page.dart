import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../firebase_bloc/firebase_bloc.dart';
import '../firebase_bloc/firebase_state.dart';
import '../firebase_bloc/firebase_event.dart';

class FirebasePage extends StatefulWidget {
  @override
  _FirebasePageState createState() => _FirebasePageState();
}

class _FirebasePageState extends State<FirebasePage> {
  final _formKey = GlobalKey<FormState>();
  var _username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseBloc>(
      create: (ctx) => FirebaseBloc(),
      child: BlocBuilder<FirebaseBloc, FirebaseState>(
        builder: (ctx, state) {
          if (state is FirebaseLoadedState) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text("are you sure you want to exit?"),
                      title: Text(
                        "Exit account",
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/authScreen'),
                          child: Text('Yes'),
                        ),
                      ],
                    ),
                  ),
                ),

                centerTitle: true,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  return ctx.read<FirebaseBloc>().add(FirebaseLoadedEvent());
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: state.docs.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        _openUserTask(context: ctx, id: state.docs[index].id);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Text(
                          // state.docs[index].data()['username'],
                          'abo',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _addNewUserDialog(ctx);
                },
              ),
            );
          } else if (state is FirebaseLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is FirebaseFailedState) {
            return Text('ERROR');
          }
          ctx.read<FirebaseBloc>().add(FirebaseLoadedEvent());
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  void _addNewUserDialog(final BuildContext ctx) {
    showDialog(
      barrierDismissible: true,
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter New Username'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              key: ValueKey('Username'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a Username';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Username'),
              onSaved: (value) {
                _username = value;
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _tryAddNewUser(ctx);
              },
              child: Text('Add'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
          ],
        );
      },
    );
  }

  void _openUserTask({BuildContext context, String id}) {
    Navigator.pushNamed(context, '/taskDetailScreen', arguments: id);
  }

  void _tryAddNewUser(final BuildContext ctx) {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      Navigator.of(context).pop();
      ctx.read<FirebaseBloc>().add(FirebaseAddNewUserEvent(username: _username));
    }
  }
}
