import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landly/models/dto_models/areas.dart';

import '../../models/dto_models/types.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  AreasModel? areasModel;
  TypesModel? typesModel;
  List<String> areasList = [];
  List<String> typesList = [];
  ImagePicker imagePicker = ImagePicker();
  XFile? mainPhoto;
  List<XFile>? images = [];
  String? areaId;
  String? typeId;
  int? currencySymbol =0;

  void clear(){
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
    final multipartFile = await MultipartFile.fromFile(mainPhoto!.path,
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
        "main_photo": multipartFile,
        "photos[]": photos,
      };
      await DioHelper.postData(
        url: ApiConstants.kProduct,
        token: ApiConstants.kToken,
        data: FormData.fromMap(json),
        onSendProgress: (count, total) {
          emit(AddProductLoadingState(percent: count / total));
        },
      ).then(
        (value) async {
          emit(AddProductSuccessState());
        },
      ).catchError((e) {
        if (e is DioException) {
          print(e.response!.data);
        }
        print(e.toString());
        emit(AddProductErrorState());
      });
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
      await DioHelper.getData(
        url: ApiConstants.kAreas,
        token: ApiConstants.kToken,
      ).then(
        (value) {
          print(value.data);
          areasModel = AreasModel.fromJson(value.data);
          areasList = List.generate(areasModel!.areas!.length,
              (index) => areasModel!.areas![index].areaName!);
          emit(GetAreasSuccessState(areasModel!));
        },
      ).catchError((e) {
        print(e.toString());
        emit(GetAreasErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(GetAreasErrorState());
    }
  }

  Future<void> getTypes() async {
    emit(GetTypesLoadingState());
    try {
      await DioHelper.getData(
        url: ApiConstants.kTypes,
        token: ApiConstants.kToken,
      ).then(
        (value) {
          print(value.data);
          typesModel = TypesModel.fromJson(value.data);
          typesList = List.generate(typesModel!.types!.length,
              (index) => typesModel!.types![index].typeName!);
          emit(GetTypesSuccessState(typesModel!));
        },
      ).catchError((e) {
        print(e.toString());
        emit(GetTypesErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(GetTypesErrorState());
    }
  }
}
