import 'package:ecomfix/bloc/register_event.dart';
import 'package:ecomfix/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:your_project/bloc/user_bloc.dart';
import '../example/demo_bloc.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User Page')),
      body: BlocBuilder<UserBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RegisterErrorState) {
            return Center(child: Text(state.errorMsg));
          } else if (state is RegisterLoadedState) {
            return Text('User created: ${state.userModel.userEmail}');
          } else {
            return ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(CreateUserEvent as RegisterEvent);
              },
              child: const Text('Create User'),
            );
          }
        },
      ),
    );
  }
}
