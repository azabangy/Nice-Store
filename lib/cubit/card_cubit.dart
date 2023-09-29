

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesapp/cubit/card_state.dart';

import '../cartpage.dart';
import '../data.dart';
import '../db.dart';

class CardCubit extends Cubit<CardState>{
  CardCubit() :super(UpdateCardCounter());

  int cardItemCount = 0;
  SqlDb sql = SqlDb();
  List<Map> products = [];

  Future<List<Map>> readData() async {
    emit(DataLoading());
    try{
      List<Map> response = await sql.read("products");
      products.clear();
      products.addAll(response);
      emit(DataSuccess());
      cardItemCount = products.length;
      emit(UpdateCardCounter());
      return response;
    }catch (e){
      emit(DataFailure());
      return [];
    }
  }
  Future<List<Map>> deleteData(int i) async{
    int response = await sql.delete(
        'products', 'id = ${products[i]['id']}');

    if (response > 0) {
      products.removeWhere(
          (element) => element['id'] == products[i]['id']);
      emit(DataSuccess());
      readData();
    }
    return products;

  }

  Future<void> addToCard(context, productId)async{
    emit(DataLoading());
    try{
      int response = await sql.insert('products', {
        "title":Data.generateProductId(productId).title,
        "type":Data.generateProductId(productId).type,
        "description":Data.generateProductId(productId).description,
        "image":Data.generateProductId(productId).image,
        "price":Data.generateProductId(productId).price,
        "amount":Data.amount,
        "total_price": Data.generateProductId(productId).price
      });
      if (response > 0 ) {
        print('add product successfully ############');
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Cart(),), (route) => true);
      }
      emit(DataSuccess());
    }catch (e){
      emit(DataFailure());
    }

  }





}