import 'dart:async';

import 'package:frame_box/models/user_model.dart';

//import '../../services/placeholder_service.dart';

class HomeBloc {
  final controller = StreamController<dynamic>.broadcast();
  List<UserModel> _allUsers = [];

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get() async {
    input.add(true);

    // LISTA COMPLETA DOS 10 USUÁRIOS HARDCODED
    final List<UserModel> mockUsers = [
      // Usuário 1
      UserModel(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        phone: '1-770-736-8031 x56442',
        website: 'hildegard.org',
        address: Address(
          street: 'Kulas Light',
          suite: 'Apt. 556',
          city: 'Gwenborough',
          zipcode: '92998-3874',
          geo: Geo(lat: '-37.3159', lng: '81.1496'),
        ),
        company: Company(
          name: 'Romaguera-Crona',
          catchPhrase: 'Multi-layered client-server neural-net',
          bs: 'harness real-time e-markets',
        ),
      ),
      // Usuário 2
      UserModel(
        id: 2,
        name: 'Ervin Howell',
        username: 'Antonette',
        email: 'Shanna@melissa.tv',
        phone: '010-692-6593 x09125',
        website: 'anastasia.net',
        address: Address(
          street: 'Victor Plains',
          suite: 'Suite 879',
          city: 'Wisokyburgh',
          zipcode: '90566-7771',
          geo: Geo(lat: '-43.9509', lng: '-34.4618'),
        ),
        company: Company(
          name: 'Deckow-Crist',
          catchPhrase: 'Proactive didactic contingency',
          bs: 'synergize scalable supply-chains',
        ),
      ),
      // Usuário 3
      UserModel(
        id: 3,
        name: 'Clementine Bauch',
        username: 'Samantha',
        email: 'Nathan@yesenia.net',
        phone: '1-463-123-4447',
        website: 'ramiro.info',
        address: Address(
          street: 'Douglas Extension',
          suite: 'Suite 847',
          city: 'McKenziehaven',
          zipcode: '59590-4157',
          geo: Geo(lat: '-68.6102', lng: '-47.0653'),
        ),
        company: Company(
          name: 'Romaguera-Jacobson',
          catchPhrase: 'Face to face bifurcated interface',
          bs: 'e-enable strategic applications',
        ),
      ),
      // Usuário 4
      UserModel(
        id: 4,
        name: 'Patricia Lebsack',
        username: 'Karianne',
        email: 'Julianne.OConner@kory.org',
        phone: '493-170-9623 x156',
        website: 'kale.biz',
        address: Address(
          street: 'Hoeger Mall',
          suite: 'Apt. 692',
          city: 'South Elvis',
          zipcode: '53919-4257',
          geo: Geo(lat: '29.4572', lng: '-164.2990'),
        ),
        company: Company(
          name: 'Robel-Corkery',
          catchPhrase: 'Multi-tiered zero tolerance productivity',
          bs: 'transition cutting-edge web services',
        ),
      ),
      // Usuário 5
      UserModel(
        id: 5,
        name: 'Chelsey Dietrich',
        username: 'Kamren',
        email: 'Lucio_Hettinger@annie.ca',
        phone: '(254)954-1289',
        website: 'demarco.info',
        address: Address(
          street: 'Skiles Walks',
          suite: 'Suite 351',
          city: 'Roscoeview',
          zipcode: '33263',
          geo: Geo(lat: '-31.8129', lng: '62.5342'),
        ),
        company: Company(
          name: 'Keebler LLC',
          catchPhrase: 'User-centric fault-tolerant solution',
          bs: 'revolutionize end-to-end systems',
        ),
      ),
      // Usuário 6
      UserModel(
        id: 6,
        name: 'Mrs. Dennis Schulist',
        username: 'Leopoldo_Corkery',
        email: 'Karley_Dach@jasper.info',
        phone: '1-477-935-8478 x6430',
        website: 'ola.org',
        address: Address(
          street: 'Norberto Crossing',
          suite: 'Apt. 950',
          city: 'South Christy',
          zipcode: '23505-1337',
          geo: Geo(lat: '-71.4197', lng: '71.7478'),
        ),
        company: Company(
          name: 'Considine-Lockman',
          catchPhrase: 'Synchronised bottom-line interface',
          bs: 'e-enable innovative applications',
        ),
      ),
      // Usuário 7
      UserModel(
        id: 7,
        name: 'Kurtis Weissnat',
        username: 'Elwyn.Skiles',
        email: 'Telly.Hoeger@billy.biz',
        phone: '210.067.6132',
        website: 'elvis.io',
        address: Address(
          street: 'Rex Trail',
          suite: 'Suite 280',
          city: 'Howemouth',
          zipcode: '58804-1099',
          geo: Geo(lat: '24.8918', lng: '21.8984'),
        ),
        company: Company(
          name: 'Johns Group',
          catchPhrase: 'Configurable multimedia task-force',
          bs: 'generate enterprise e-tailers',
        ),
      ),
      // Usuário 8
      UserModel(
        id: 8,
        name: 'Nicholas Runolfsdottir V',
        username: 'Maxime_Nienow',
        email: 'Sherwood@rosamond.me',
        phone: '586.493.6943 x140',
        website: 'jacynthe.com',
        address: Address(
          street: 'Ellsworth Summit',
          suite: 'Suite 729',
          city: 'Aliyaview',
          zipcode: '45169',
          geo: Geo(lat: '-14.3990', lng: '-120.7677'),
        ),
        company: Company(
          name: 'Abernathy Group',
          catchPhrase: 'Implemented secondary concept',
          bs: 'e-enable extensible e-tailers',
        ),
      ),
      // Usuário 9
      UserModel(
        id: 9,
        name: 'Glenna Reichert',
        username: 'Delphine',
        email: 'Chaim_McDermott@dana.io',
        phone: '(775)976-6794 x41206',
        website: 'conrad.com',
        address: Address(
          street: 'Dayna Park',
          suite: 'Suite 449',
          city: 'Bartholomebury',
          zipcode: '76495-3109',
          geo: Geo(lat: '24.6463', lng: '-168.8889'),
        ),
        company: Company(
          name: 'Yost and Sons',
          catchPhrase: 'Switchable contextually-based project',
          bs: 'aggregate real-time technologies',
        ),
      ),
      // Usuário 10
      UserModel(
        id: 10,
        name: 'Clementina DuBuque',
        username: 'Moriah.Stanton',
        email: 'Rey.Padberg@karina.biz',
        phone: '024-648-3804',
        website: 'ambrose.net',
        address: Address(
          street: 'Kattie Turnpike',
          suite: 'Suite 198',
          city: 'Lebsackbury',
          zipcode: '31428-2261',
          geo: Geo(lat: '-38.2386', lng: '57.2232'),
        ),
        company: Company(
          name: 'Hoeger LLC',
          catchPhrase: 'Centralized empowering task-force',
          bs: 'target end-to-end models',
        ),
      ),
    ];

    final users = mockUsers;

    await Future.delayed(const Duration(milliseconds: 500));

    if (users.isEmpty) {
      input.add(false);
    } else {
      _allUsers = users;
      input.add(_allUsers);
    }
  }

  void filter(String query) {
    if (_allUsers.isEmpty) {
      return;
    }

    final lowerCaseQuery = query.toLowerCase();

    if (lowerCaseQuery.isEmpty) {
      input.add(_allUsers);
      return;
    }

    final filteredUsers = _allUsers.where((user) {
      return user.name.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    input.add(filteredUsers);
  }

  void dispose() {
    controller.close();
  }
}

/* Código antigo que depende da API
class HomeBloc {
  final controller = StreamController<dynamic>.broadcast();

  List<UserModel> _allUsers = [];

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get() async {
    input.add(true);

    final users = await PlaceholderService.getUsers();

    if (users == null) {
      input.add(false);
    } else {
      _allUsers = users;

      input.add(_allUsers);
    }
  }

  void filter(String query) {
    if (_allUsers.isEmpty) {
      return;
    }

    final lowerCaseQuery = query.toLowerCase();

    if (lowerCaseQuery.isEmpty) {
      input.add(_allUsers);
      return;
    }
    final filteredUsers = _allUsers.where((user) {
      return user.name.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    input.add(filteredUsers);
  }

  void dispose() {
    controller.close();
  }
}
*/
