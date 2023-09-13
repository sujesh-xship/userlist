import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_details/bloc/userdata_bloc.dart';
import 'package:user_details/model/user_data.dart';
import 'package:user_details/service/service.dart';

class DetailsPage extends StatelessWidget {
  final User user;
  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDataBloc(RepositoryProvider.of<NetworkService>(context))
            ..add(LoaduserDataEvent(10)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("User Details"),
          centerTitle: true,
        ),
        body: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is UserDataErrorState) {
              return const Text("errorr");
            } else if (state is UserDataLoadedState) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 6, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image.toString()),
                            backgroundColor: Colors.blue,
                            radius: 50)),
                    const SizedBox(height: 30),
                    Text("Name : ${user.firstName} ${user.lastName}"),
                    Text("User name : ${user.username}"),
                    Text("Email : ${user.email}"),
                    Text("Mobile : ${user.phone}"),
                    Text("Gender : ${user.gender}"),
                    Text("Birth Day : ${user.birthDate}"),
                    // Text("Age: ${user.age}"),
                    Text(
                      "Address : ${user.address?.address},${user.address?.city}, ${user.address?.postalCode},${user.address?.state}",
                    ),
                    Text("Company name : ${user.company?.name}"),
                    Text("Title : ${user.company?.title}"),
                    Text("Department  : ${user.company?.department}"),
                    Text(
                        "Address : ${user.company?.address?.address}, ${user.company?.address?.city}, ${user.company?.address?.postalCode}, ${user.company?.address?.state}"),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
