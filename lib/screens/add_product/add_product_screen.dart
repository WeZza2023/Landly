import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/components/components.dart';
import 'package:landly/components/custom_texts.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/models/domain_models/areas_entity.dart';
import 'package:landly/models/domain_models/types_entity.dart';
import 'package:landly/screens/add_product/add_product_cubit.dart';
import 'package:landly/screens/add_product/add_product_state.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/utils/app_sizes.dart';
import 'package:landly/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:wheel_slider/wheel_slider.dart';
import '../../components/default_formfield.dart';
import '../../generated/l10n.dart';
import '../../utils/colors.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  static const id = 'AddProductScreen';
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController titleController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController typeController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController areaController = TextEditingController();
  static TextEditingController extraServicesController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddProductCubit>(context);
    void clearControllers() {
      titleController.clear();
      priceController.clear();
      typeController.clear();
      descriptionController.clear();
      addressController.clear();
      phoneController.clear();
      areaController.clear();
      extraServicesController.clear();
      cubit.clear();
    }

    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccessState) {
          BlocProvider.of<HomeCubit>(context).refresh();
          Navigator.pop(context);
          clearControllers();
        }
      },
      builder: (context, state) => AppScaffold(
          appBar: MainAppBar(
              context: context,
              leading: AppMainBtn(
                context: context,
                onTap: () {
                  clearControllers();
                  Navigator.pop(context);
                },
              ),
              title: BodyExtraSmallText(
                S.of(context).add_property,
                weight: FontWeight.bold,
              )),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      overlayColor: WidgetStateProperty.all(
                          kMainBtnColor.withOpacity(0.2)),
                      focusColor: kSubBackgroundColor,
                      onTap: () {
                        cubit.pickImage();
                      },
                      child: Container(
                        height: AppSizes.getBaseScale(context) * 200,
                        clipBehavior: Clip.antiAlias,
                        width: AppSizes.getScreenWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: kMainBtnColor.withOpacity(0.2)),
                        ),
                        child: cubit.mainPhoto == null
                            ? Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(AppConstants.photoJson,
                                            width:
                                                AppSizes.getBaseScale(context) *
                                                    40,
                                            height:
                                                AppSizes.getBaseScale(context) *
                                                    40)
                                        .bP8,
                                    BodyTinyText(
                                      S.of(context).add_main_photo,
                                      weight: FontWeight.normal,
                                    )
                                  ],
                                ),
                              )
                            : Image.file(
                                File(cubit.mainPhoto!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      overlayColor: WidgetStateProperty.all(
                          kMainBtnColor.withOpacity(0.2)),
                      focusColor: kSubBackgroundColor,
                      onTap: () {
                        cubit.pickMultipleImages();
                      },
                      child: Container(
                        height: AppSizes.getBaseScale(context) * 200,
                        clipBehavior: Clip.antiAlias,
                        width: AppSizes.getScreenWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: kMainBtnColor.withOpacity(0.2)),
                        ),
                        child: cubit.images == null || cubit.images!.isEmpty
                            ? Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppConstants.photoJson,
                                      height:
                                          AppSizes.getBaseScale(context) * 40,
                                      width:
                                          AppSizes.getBaseScale(context) * 40,
                                    ).bP8,
                                    BodyTinyText(
                                      S.of(context).add_property_photos,
                                      weight: FontWeight.normal,
                                    )
                                  ],
                                ),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: cubit.images!.length,
                                itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: kMainBtnColor.withOpacity(0.2)),
                                  ),
                                  child: Image.file(
                                    File(cubit.images![index].path),
                                    fit: BoxFit.cover,
                                    height:
                                        AppSizes.getBaseScale(context) * 150,
                                    width: AppSizes.getBaseScale(context) * 150,
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 8,
                                ),
                              ),
                      ),
                    ),
                    DefaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      label: S.of(context).ad_name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_ad_name;
                        }
                        return null;
                      },
                    ).vP8,
                    MainDropDownFormField(
                      icon: cubit.typesList.isEmpty
                          ? AppLoadingIndicator(context: context)
                          : null,
                      labelText: S.of(context).ad_type,
                      Controller: typeController,
                      items: cubit.typesList.map((TypeEntity type) {
                        return DropdownMenuItem<String>(
                            child: Text(type.typeName),
                            value: type.id.toString());
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          typeController.text = value;
                        }
                      },
                      validation: (value) {
                        if (value == null) {
                          return S.of(context).please_enter_ad_type;
                        }
                        return null;
                      },
                    ).bP8,
                    MainDropDownFormField(
                      labelText: S.of(context).ad_region,
                      Controller: areaController,
                      icon: cubit.areasList.isEmpty
                          ? AppLoadingIndicator(context: context)
                          : null,
                      items: cubit.areasList.map((AreaEntity area) {
                        return DropdownMenuItem<String>(
                          child: Text(area.areaName),
                          value: area.id.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          areaController.text = value;
                        }
                      },
                      validation: (value) {
                        if (value == null) {
                          return S.of(context).please_enter_ad_region;
                        }
                        return null;
                      },
                    ).bP8,
                    DefaultFormField(
                      controller: addressController,
                      type: TextInputType.text,
                      label: S.of(context).ad_address,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_ad_address;
                        }
                        return null;
                      },
                    ).bP8,
                    Row(
                      children: [
                        Expanded(
                          child: DefaultFormField(
                            controller: priceController,
                            type: TextInputType.number,
                            label: S.of(context).ad_price,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).please_enter_ad_price;
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kSubBackgroundColor,
                              border: Border.all(
                                  color: kMainBtnColor.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10)),
                          width: AppSizes.getScreenWidth(context) * 0.3,
                          height: AppSizes.getBaseScale(context) * 50,
                          constraints: BoxConstraints(maxHeight: 65),
                          child: WheelSlider.customWidget(
                            horizontal: false,
                            totalCount: AppConstants.currencySymbols.length,
                            initValue: 7,
                            isVibrate: true,
                            isInfinite: false,
                            scrollPhysics: const BouncingScrollPhysics(),
                            onValueChanged: (val) {
                              cubit.currencySymbol = val;
                            },
                            hapticFeedbackType: HapticFeedbackType.mediumImpact,
                            showPointer: false,
                            itemSize: 40,
                            children: List.generate(
                                AppConstants.currencySymbols.length,
                                (index) => Center(
                                        child: BodyTinyText(
                                      AppConstants.currencySymbols[index],
                                    ))),
                          ),
                        ).setPadding(start: 8),
                      ],
                    ).bP8,
                    DefaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: S.of(context).ad_phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_ad_phone;
                        }
                        return null;
                      },
                    ).bP8,
                    DefaultFormField(
                      controller: extraServicesController,
                      type: TextInputType.text,
                      label: S.of(context).extra_services,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_extra_services;
                        }
                        return null;
                      },
                    ).bP8,
                    DefaultFormField(
                      controller: descriptionController,
                      type: TextInputType.text,
                      label: S.of(context).ad_description,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_ad_description;
                        }
                        return null;
                      },
                    ).bP25,
                    state is AddProductLoadingState
                        ? AppLoadingIndicator(
                            context: context,
                            percent: state.percent,
                          )
                        : CustomTextButton(
                                context: context,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (cubit.mainPhoto != null &&
                                        cubit.images!.isNotEmpty) {
                                      cubit.addProduct(
                                        title: titleController.text,
                                        price:
                                            '${priceController.text}  ${AppConstants.currencySymbols[cubit.currencySymbol!]}',
                                        description: descriptionController.text,
                                        address: addressController.text,
                                        typeId: typeController.text,
                                        areaId: areaController.text,
                                        phone: phoneController.text,
                                        extraServices:
                                            extraServicesController.text,
                                      );
                                    } else if (cubit.mainPhoto == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(AppSnackBar(
                                              message: S
                                                  .of(context)
                                                  .you_have_to_add_property_main_photo,
                                              error: true));
                                    } else if (cubit.images!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(AppSnackBar(
                                              message: S
                                                  .of(context)
                                                  .you_have_to_add_property_photos,
                                              error: true));
                                    }
                                  }
                                },
                                text: S.of(context).add)
                            .bP16
                  ],
                ).p16,
              ),
            ),
          )),
    );
  }
}
