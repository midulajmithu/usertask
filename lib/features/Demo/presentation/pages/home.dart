import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';
import 'package:flutter_application_1/features/Demo/presentation/bloc/auth_bloc/auditor_auth_event.dart';
import 'package:flutter_application_1/features/Demo/presentation/bloc/auth_bloc/auditor_auth_state.dart';
import 'package:flutter_application_1/features/Demo/presentation/bloc/auth_bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: BlocConsumer<HomeBloc, FetchdetailState>(
        listener: (context, state) {
          if (state is HomefetchFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomefetchSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is HomeDbFetchFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomeDeleteUserFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomeDeleteUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Deleted user with ID: ${state.userId}')),
            );

            context.read<HomeBloc>().add(HomeDbFetchEvent());
          }
        },
        builder: (context, state) {
          List<UserEntity> users = [];
          if (state is HomeDbFetchSuccess) {
            users = state.users;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HomeBloc>().add(HomedetailFetchEvent());
                      },
                      icon: const Icon(Icons.cloud_download),
                      label: const Text('Fetch API Details'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HomeBloc>().add(HomeDbFetchEvent());
                      },
                      icon: const Icon(Icons.storage),
                      label: const Text('Fetch DB Details'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Loading indicator for any fetch
                if (state is HomefetchLoading ||
                    state is HomeDbFetchLoading ||
                    state is HomeDeleteUserLoading)
                  const Center(child: CircularProgressIndicator()),

                // Show DB users list
                if (users.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(child: Text(user.name[0])),
                            title: Text(user.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${user.email}'),
                                Text('Phone: ${user.phone}'),
                                Text('Company: ${user.companyName}'),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                  HomeDeleteUserEvent(user.userId),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                if (users.isEmpty &&
                    !(state is HomefetchLoading || state is HomeDbFetchLoading))
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Click a button to fetch details',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
