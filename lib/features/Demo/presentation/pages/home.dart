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
          } else if (state is HomeAddUserFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomeAddUserSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.of(context).pop(); // Close dialog if open
            context.read<HomeBloc>().add(HomeDbFetchEvent());
          } else if (state is HomeUpdateUserFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomeUpdateUserSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.of(context).pop(); // Close dialog if open
            context.read<HomeBloc>().add(HomeDbFetchEvent());
          } else if (state is HomeUpdateUserFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is HomeUpdateUserSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.of(context).pop(); // Close dialog if open
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
                    state is HomeDeleteUserLoading ||
                    state is HomeAddUserLoading)
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _showEditUserDialog(context, user);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      HomeDeleteUserEvent(user.userId),
                                    );
                                  },
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUserDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final user = UserEntity(
                  userId: DateTime.now().millisecondsSinceEpoch,
                  name: nameController.text,
                  username: nameController.text.toLowerCase().replaceAll(' ', ''),
                  email: emailController.text,
                  phone: phoneController.text,
                  website: '',
                  street: '',
                  suite: '',
                  city: '',
                  zipcode: '',
                  lat: '',
                  lng: '',
                  companyName: companyController.text,
                  companyCatchPhrase: '',
                  companyBs: '',
                );
                context.read<HomeBloc>().add(HomeAddUserEvent(user));
                // We will pop the dialog in the listener on success
                // But since safe popping inside listener for dialogs can be tricky if context is unstable,
                // we can also pop here if we don't wait for success.
                // However, waiting for success to pop is better UX for errors.
                // For simplicity in this demo, I'll rely on the listener to pop on success.
                // NOTE: The listener calls Navigator.pop which pops the DIALOG. 
                // But wait, the listener is attached to the SCAFFOLD body. 
                // If I pop from listener, it will work.
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditUserDialog(BuildContext context, UserEntity user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);
    final companyController = TextEditingController(text: user.companyName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = UserEntity(
                  userId: user.userId, // Keep same ID
                  name: nameController.text,
                  username: user.username,
                  email: emailController.text,
                  phone: phoneController.text,
                  website: user.website,
                  street: user.street,
                  suite: user.suite,
                  city: user.city,
                  zipcode: user.zipcode,
                  lat: user.lat,
                  lng: user.lng,
                  companyName: companyController.text,
                  companyCatchPhrase: user.companyCatchPhrase,
                  companyBs: user.companyBs,
                );
                context.read<HomeBloc>().add(HomeUpdateUserEvent(updatedUser));
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
