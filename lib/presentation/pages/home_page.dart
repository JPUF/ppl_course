import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/logic/basic/basic_bloc.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocConsumer<BasicBloc, Response<BasicState>>(
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Fetched"),
                  duration: Duration(seconds: 1),
                ));
              },
              builder: (context, state) {
                switch (state.status) {
                  case Status.loading:
                    return Text(
                      "Loading",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  case Status.completed:
                    return Text(
                      state.data?.basicText ?? "",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  default:
                    return Text(
                      "Error",
                      style: Theme.of(context).textTheme.headline5,
                    );
                }
              },
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
                heroTag: 'primaryCta',
                child: const Icon(Icons.gavel_outlined),
                onPressed: () {
                  BlocProvider.of<BasicBloc>(context).add(Fetch());
                }),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: 'routeCta',
              onPressed: () {
                Navigator.of(context).pushNamed(Destination.second);
              },
              child: const Icon(Icons.navigate_next_rounded),
            )
          ],
        ),
      ),
    );
  }
}
