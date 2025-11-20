import 'package:flutter/material.dart';
import 'package:frame_box/screens/home/home_bloc.dart';
import 'package:frame_box/screens/home/home_card.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  @override
  void initState() {
    _bloc.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6.0,
                offset: Offset(0, 2.0),
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              'Users',
              style: TextStyle(
                color: Color(0xFF60107B),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: StreamBuilder<dynamic>(
        stream: _bloc.output,
        builder: (_, snapshot) {
          //Carregando
          if (!snapshot.hasData || snapshot.data == true) {
            return Center(child: CircularProgressIndicator());
          }

          //Erro
          if (snapshot.hasData && snapshot.data == false) {
            return Center(child: Text('Erro'));
          }

          //Sucesso
          final List<UserModel> users = snapshot.data as List<UserModel>;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    top: index == 0 ? 10 : 0,
                  ),
                  child: HomeCard(user: user, index: index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
