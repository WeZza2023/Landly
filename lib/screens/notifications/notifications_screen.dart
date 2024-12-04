import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/login/login_screen.dart';
import 'package:landly/screens/notifications/notifications_cubit.dart';
import 'package:landly/screens/notifications/notifications_state.dart';
import 'package:landly/utils/app_sizes.dart';
import 'package:landly/utils/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/components.dart';
import '../../components/custom_texts.dart';
import '../../generated/l10n.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const id = 'NotificationsScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotificationsCubit>(context);
    return AppScaffold(
      appBar: MainAppBar(
        context: context,
        leading: AppMainBtn(context: context),
        title: BodyExtraSmallText(
          S.of(context).notifications,
          weight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) => ListView.builder(
          itemCount: cubit.notificationsModel == null ||
                  state is GetNotificationsLoadingState
              ? 5
              : cubit.notificationsModel!.sale!.length,
          itemBuilder: (context, index) => cubit.notificationsModel == null ||
                  state is GetNotificationsLoadingState
              ? Skeletonizer(
                  child: NotificationsBox(
                    context: context,
                    image: 'https://picsum.photos/200/300',
                    name: 'User Name',
                    title: 'Product Title',
                    phone: '0.0',
                    address: 'Address',
                  ),
                )
              : NotificationsBox(
                  context: context,
                  image: ApiConstants.kUrl +
                      cubit
                          .notificationsModel!.sale![index].product!.mainPhoto!,
                  name: cubit.notificationsModel!.sale![index].user!.name!,
                  title: cubit.notificationsModel!.sale![index].product!.title!,
                  phone:
                      cubit.notificationsModel!.sale![index].user!.phoneNumber!,
                  address:
                      cubit.notificationsModel!.sale![index].product!.address!,
                ),
        ),
      ),
    );
  }
}
