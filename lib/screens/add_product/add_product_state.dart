import 'package:landly/models/dto_models/areas.dart';
import 'package:landly/use_cases/types_use_case.dart';

import '../../models/dto_models/types.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoadingState extends AddProductState {
  double? percent = 0;

  AddProductLoadingState({this.percent});
}

class AddProductSuccessState extends AddProductState {}

class AddProductErrorState extends AddProductState {}

class GetAreasLoadingState extends AddProductState {}

class GetAreasSuccessState extends AddProductState {}

class GetAreasErrorState extends AddProductState {}

class GetTypesLoadingState extends AddProductState {}

class GetTypesSuccessState extends AddProductState {}

class GetTypesErrorState extends AddProductState {}

class PickedImageSuccessState extends AddProductState {}

class PickedImageErrorState extends AddProductState {}

class ClearState extends AddProductState {}
