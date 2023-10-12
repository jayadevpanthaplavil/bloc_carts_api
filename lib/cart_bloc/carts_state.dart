part of 'carts_bloc.dart';

class CartsState {
  List<Carts>? cartlist=[];
  CartsState({required this.cartlist});
}

class CartsInitial extends CartsState {
  CartsInitial({required super.cartlist});
}
