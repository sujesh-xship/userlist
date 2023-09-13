import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_details/bloc/userdata_bloc.dart';
import 'package:user_details/model/user_data.dart';
import 'package:user_details/service/service.dart';
import 'package:user_details/view/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int limit = 10;
  int total = 0;
  bool isLoading = true;
  List<User> users = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<UserDataBloc>(context).add(LoaduserDataEvent(limit));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("loading event is called>>>>>>>>>>>>>>>>>>>>>");
      limit += 10;
      print("limit>>>>>>>>>>>>>>>>>>>>>>>$limit");
      BlocProvider.of<UserDataBloc>(context).add(
        LoadAfterUserDataEvent(limit: limit, skip: total),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("User List"),
          centerTitle: true,
        ),
        body: BlocListener<UserDataBloc, UserDataState>(
          listener: (context, state) {
            if (state is UserDataLoadedState) {
              setState(() {
                users.addAll(state.userData!.users);
                total += state.userData!.users.length;
                isLoading = false;
              });
              print("Length------------------------${users.length}");
            }
          },
          child: isLoading && users.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
            controller: _scrollController,
            itemCount: users.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < users.length) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(user: users[index])));
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage(users[index].image.toString()),
                  ),
                  title: Text(
                      "${users[index].firstName} ${users[index].lastName}"),
                  subtitle: Text(
                    users[index].email.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              } else {
                // This is the loading indicator
                return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ));
              }
            },
          ),
        ));
  }
}

