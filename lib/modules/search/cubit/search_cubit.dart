// ignore_for_file: unnecessary_import, depend_on_referenced_packages, avoid_print
import 'package:market_app/modules/search/cubit/search_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/components/constants.dart';
import 'package:market_app/shared/network/end_points.dart';
import 'package:market_app/shared/network/remote/dio_helper.dart';

import '../../../models/products_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  ProductsModel? model;

  void search(String q) {
    emit(SearchLoadingState());
    DioHelper.getData(
      url: '$SEARCH?query=$q',
      token: token,
    ).then((value) {
      model = ProductsModel.fromJson(value.data);
      print('Search status is');
      //print(model?.status);
      emit(SearchSuccsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  // Future<void> search({required String q}) async {
  //   try {
  //     print(q);
  //     // Set the state to loading
  //     emit(SearchLoadingState());

  //     // Make the API call using Dio
  //     final response = await DioHelper.getData(
  //       url: '$SEARCH?query=$q',
  //       token: token,
  //     );

  //     // Handle the response based on your API's behavior
  //     if (response.statusCode! > 199 && response.statusCode! < 206) {
  //       // Authentication success
  //       model = ProductsModel.fromJson(response.data);
  //       // model!.addAll(response.data);
  //       // for (var el in response.data) {
  //       //   final pro = Products.fromJson(el);
  //       //   model!.add(pro);
  //       // }
  //       print(response.data);

  //       emit(SearchSuccsessState());
  //     } else {
  //       // Authentication failure
  //       print("hh");
  //       print('${response.statusCode} error failure');
  //       emit(SearchErrorState());
  //     }
  //   } catch (e) {
  //     // Handle any error that occurred during the API call
  //     print('api call search $e');
  //     print('h');
  //     emit(SearchErrorState());
  //   }
  // }
}
