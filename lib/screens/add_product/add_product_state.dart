import 'package:landly/models/areas.dart';

import '../../models/types.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoadingState extends AddProductState {
 double? percent = 0;

  AddProductLoadingState({this.percent});
}

class AddProductSuccessState extends AddProductState {}

class AddProductErrorState extends AddProductState {}

class GetAreasLoadingState extends AddProductState {}

class GetAreasSuccessState extends AddProductState {
 final AreasModel areasModel;
  GetAreasSuccessState(this.areasModel);
}

class GetAreasErrorState extends AddProductState {}

class GetTypesLoadingState extends AddProductState {}

class GetTypesSuccessState extends AddProductState {
 final TypesModel typesModel;
  GetTypesSuccessState(this.typesModel);
}

class GetTypesErrorState extends AddProductState {}

class PickedImageSuccessState extends AddProductState {}

class PickedImageErrorState extends AddProductState {}

class ClearState extends AddProductState {}