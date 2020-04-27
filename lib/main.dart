import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_bloc/home_bloc.dart';
import 'package:stop_watch_bloc/home_state_action.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop watch',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: ThemeData.estimateBrightnessForColor(Colors.purple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop watch'),
      ),
      body: StreamBuilder<HomeState>(
        initialData: bloc.state$.value,
        stream: bloc.state$,
        builder: (context, snapshot) {
          final state = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 32),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Start'),
                    padding: const EdgeInsets.all(12),
                    onPressed: state.state.isStartEnabled ? bloc.start : null,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Pause'),
                    padding: const EdgeInsets.all(12),
                    onPressed: state.state.isPauseEnabled ? bloc.pause : null,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Reset'),
                    padding: const EdgeInsets.all(12),
                    onPressed: state.state.isResetEnabled ? bloc.reset : null,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  state.seconds.formatted,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
