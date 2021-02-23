import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovecity_app/application/auth/auth_cubit.dart';
import 'package:lovecity_app/application/auth/auth_state.dart';
import 'package:lovecity_app/application/city/city_cubit.dart';
import 'package:lovecity_app/application/city/city_state.dart';
import 'package:lovecity_app/application/province/province_cubit.dart';
import 'package:lovecity_app/application/province/province_state.dart';
import 'package:lovecity_app/domain/city/city_model.dart';
import 'package:lovecity_app/domain/province/province_model.dart';
import 'package:lovecity_app/presentation/pages/city/home_page_adapter.dart';

class CityListPage extends StatefulWidget {
  final IHomePageAdapter adapter;
  CityListPage(this.adapter);
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  List<CityModel> cities = [];
  List<ProvinceModel> provincies = [];

  @override
  void initState() {
    BlocProvider.of<ProvinceCubit>(context).getAll();
    BlocProvider.of<CityCubit>(context).getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  _logout();
                }),
          ],
        ),
        body: Container(
          height: 750,
          child: Column(
            children: [
              Container(
                height: 200,
                child: BlocConsumer<ProvinceCubit, ProvinceState>(
                    builder: (context, state) {
                  if (state is ProvinceInitial) {
                    return Text("....");
                  } else if (state is ProvinceLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProvinciesLoaded) {
                    provincies.addAll(state.provincies);
                    return _buildProvincies();
                  } else {
                    return Text(":???");
                  }
                }, listener: (context, state) {
                  if (state is ProvinceError) {
                    print("Province Error");
                  }
                }),
              ),
              Container(
                height: 200,
                child: BlocConsumer<CityCubit, CityState>(
                    builder: (context, state) {
                  if (state is CityInitial) {
                    return Text("....");
                  } else if (state is CityLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CitiesLoaded) {
                    cities.addAll(state.cities);
                    return _buildCities();
                  } else {
                    return Text("....");
                  }
                }, listener: (context, state) {
                  if (state is CityError) {
                    print("Error");
                  }
                }),
              ),
              Container(
                height: 250,
                child: BlocListener<AuthCubit, AuthState>(
                    child: Container(),
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator();
                      } else if (state is SignOutSuccess) {
                        widget.adapter.onUserLogout(context);
                      }
                    }),
              )
            ],
          ),
        ));
  }

  _logout() {
    BlocProvider.of<AuthCubit>(context).signOut();
  }

  Widget _buildCities() {
    return Container(
      child: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(cities[index].title),
            );
          }),
    );
  }

  Widget _buildProvincies() {
    return Container(
      child: ListView.builder(
          itemCount: provincies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provincies[index].title),
            );
          }),
    );
  }
}
