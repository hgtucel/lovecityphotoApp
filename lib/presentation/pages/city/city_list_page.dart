import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovecity_app/application/city/city_cubit.dart';
import 'package:lovecity_app/application/city/city_state.dart';
import 'package:lovecity_app/domain/city/city_model.dart';

class CityListPage extends StatefulWidget {
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  List<CityModel> cities = [];

  @override
  void initState() {
    BlocProvider.of<CityCubit>(context).getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Container(
      child: BlocConsumer<CityCubit, CityState>(builder: (context, state) {
        if (state is CityLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CitiesLoaded) {
          cities.addAll(state.cities);
        }
        return _buildCities();
      }, listener: (context, state) {
        if (state is CityError) {
          print("Error");
        }
      }),
    );
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
}
