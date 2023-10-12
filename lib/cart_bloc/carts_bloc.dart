import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Carts.dart';
import 'package:http/http.dart' as http;

import '../CartsJson.dart';

part 'carts_event.dart';
part 'carts_state.dart';

class CartsBloc extends Bloc<CartsEvent, CartsState> {
  CartsBloc() : super(CartsInitial(cartlist: [])) {
    on<CartsEvent>((event, emit) async {
      final response =
          await http.get(Uri.parse("https://dummyjson.com/carts"));
      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body.toString()) ;
        var data=CartsJson.fromJson(jsonString);
        var listCarts = data.carts;
        emit(CartsState(cartlist: listCarts));
      } else {
        throw Exception("Failed to load");
      }
    });
  }
}
