// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:landly/network/api_constants.dart';
// import 'package:landly/network/dio_helper.dart';
// import 'package:landly/screens/product/product_state.dart';
//
// class ProductCubit extends Cubit<ProductState> {
//   ProductCubit() : super(ProductInitial());
//
//   Future<void> getProduct() async {
//     emit(ProductLoadingState());
//     try {
//       await DioHelper.getData(
//               url: ApiConstants.kProducts, token: ApiConstants.kToken)
//           .then((value) {
//         emit(ProductSuccessState());
//       }).catchError((e) {
//         emit(ProductErrorState());
//         print(e.toString());
//       });
//     } catch (e) {
//       emit(ProductErrorState());
//     }
//   }
// }
