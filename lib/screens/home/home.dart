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

  final _searchController = TextEditingController();

  @override
  void initState() {
    _bloc.get();

    _searchController.addListener(_onSearchChanged);

    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _bloc.filter(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 60),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Users',
                  style: TextStyle(
                    color: Color(0xFF60107B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search user by name...',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF60107B),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Color(0xFF60107B),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged();
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFbf9fca),
                  ),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
              ),
            ],
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
