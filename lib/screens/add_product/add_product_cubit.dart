// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landly/models/domain_models/areas_entity.dart';
import 'package:landly/models/domain_models/types_entity.dart';
import 'package:landly/models/dto_models/areas.dart';
import 'package:landly/repositories/main_products_repo/main_products_repo_impl.dart';
import 'package:landly/use_cases/areas_use_case.dart';
import 'package:landly/use_cases/main_products_use_case.dart';
import 'package:landly/use_cases/types_use_case.dart';

import '../../models/dto_models/types.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import '../../repositories/areas_repo/areas_repo_impl.dart';
import '../../repositories/types_repo/types_repo_impl.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  AreasUseCase areasUseCase = AreasUseCase(areasRepo: AreasRepoImpl());
  TypesUseCase typesUseCase = TypesUseCase(typesRepo: TypesRepoImpl());
  MainProductsUseCase mainProductsUseCase =
      MainProductsUseCase(mainProductsRepo: MainProductsRepoImpl());
  List<AreaEntity> areasList = [];
  List<TypeEntity> typesList = [];
  ImagePicker imagePicker = ImagePicker();
  XFile? mainPhoto;
  List<XFile>? images = [];
  int? currencySymbol = 0;

  void clear() {
    mainPhoto = null;
    images = null;
    emit(ClearState());
  }

  Future<void> addProduct({
    required String title,
    required String price,
    required String description,
    required String address,
    required String phone,
    required String extraServices,
    required String typeId,
    required String areaId,
  }) async {
    emit(AddProductLoadingState());
    List<MultipartFile> photos = [];
    if (images != null) {
      for (var element in images!) {
        final multipartFile = await MultipartFile.fromFile(element.path,
            filename: element.path.split('/').last,
            contentType: MediaType(
              "image",
              'jpeg',
            ));
        photos.add(multipartFile);
      }
    }
    final mainPhotoMultipart = await MultipartFile.fromFile(mainPhoto!.path,
        filename: mainPhoto!.path.split('/').last,
        contentType: MediaType(
          "image",
          'jpeg',
        ));
    try {
      Map<String, dynamic> json = {
        "title": title,
        "price": price,
        "description": description,
        "address": address,
        "phone_number": phone,
        "type_id": typeId,
        "area_id": areaId,
        "extra_service": extraServices,
        "user_id": ApiConstants.kUserId,
        "main_photo": mainPhotoMultipart,
        "photos[]": photos,
      };
      await mainProductsUseCase.addNewProduct(
          data: json,
          mainPhoto: mainPhotoMultipart,
          onSendProgress: (count, total) {
            emit(AddProductLoadingState(percent: count / total));
          });
      emit(AddProductSuccessState());
    } catch (e) {
      print(e.toString());
      emit(AddProductErrorState());
    }
  }

  Future<void> pickImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      mainPhoto = image;
      emit(PickedImageSuccessState());
    } else {
      print('No image selected');
      emit(PickedImageErrorState());
    }
  }

  Future<void> pickMultipleImages() async {
    final List<XFile>? pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages != null) {
      images = pickedImages;
      emit(PickedImageSuccessState());
    } else {
      print('No image selected');
      emit(PickedImageErrorState());
    }
  }

  Future<void> getAreas() async {
    emit(GetAreasLoadingState());
    try {
      final areas = await areasUseCase.getAreas();
      areasList = areas!.areas;
      emit(GetAreasSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetAreasErrorState());
    }
  }

  Future<void> getTypes() async {
    emit(GetTypesLoadingState());
    try {
      final types = await typesUseCase.getTypes();
      typesList = types!.types;
      emit(GetTypesSuccessState());
    } catch (e) {
      emit(GetTypesErrorState());
    }
  }
}
