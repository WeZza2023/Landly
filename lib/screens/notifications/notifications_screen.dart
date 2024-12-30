import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/notifications/notifications_cubit.dart';
import 'package:landly/screens/notifications/notifications_state.dart';
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
          itemCount: cubit.notificationsList.isEmpty ||
                  state is GetNotificationsLoadingState
              ? 5
              : cubit.notificationsList.length,
          itemBuilder: (context, index) => cubit.notificationsList.isEmpty ||
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
                      cubit.notificationsList[index].product.mainPhoto!,
                  name: cubit.notificationsList[index].user.name,
                  title: cubit.notificationsList[index].product.title!,
                  phone: cubit.notificationsList[index].user.phoneNumber,
                  address: cubit.notificationsList[index].product.address!,
                ),
        ),
      ),
    );
  }
}
