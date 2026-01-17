import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/presentation/bloc/name_cubit.dart';
import 'package:ninety/presentation/bloc/name_state.dart';
import 'package:ninety/presentation/screens/drawer_menu.dart';
import 'package:ninety/presentation/widgets/custom_app_bar.dart';

import '../../domain/entities/name.dart';
import '../widgets/name_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<Name>> _names;
  late final ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _names = ValueNotifier(<Name>[]);
    _isLoading = ValueNotifier(false);
    BlocProvider.of<NameCubit>(context).loadNames();
  }

  @override
  void dispose() {
    _names.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawlerMenu(),
      backgroundColor: context.colors.background,
      appBar: _appBar(context),
      body: BlocListener<NameCubit, NameState>(
        listener: (context, state) {
          _watchState(state);
        },
        child: _body(context),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            context.gaps.extra,
            _buildScreenTitle(context),
            context.gaps.extra,
            context.gaps.extra,
            ListenableBuilder(
                listenable: _isLoading,
                builder: (context, _) {
                  return _isLoading.value
                      ? const CupertinoActivityIndicator()
                      : ListenableBuilder(
                          listenable: _names,
                          builder: (context, _) {
                            return _names.value.isEmpty
                                ? const Center(child: Text('...'))
                                : NamesWidget(
                                    names: _names.value,
                                    isFav: true,
                                  );
                          });
                }),
          ],
        ),
      ),
    );
  }

  SizedBox _buildScreenTitle(BuildContext context) {
    return SizedBox(
      width: 193.sp,
      height: 71.sp,
      child: "The 99 Names of Allah"
          .medium(fontColor: context.colors.black, textAlign: TextAlign.center)
          .title,
    );
  }

  AppBar _appBar(BuildContext context) {
    return CustomAppBar.build(
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(8.sp),
          enableFeedback: true,
          onTap: () {
            context.push("/favorite");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            alignment: Alignment.center,
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
        ),
      ],
      leading: Builder(builder: (context) {
        return InkWell(
          enableFeedback: true,
          borderRadius: BorderRadius.circular(8.sp),
          onTap: () async => Scaffold.of(context).openDrawer(),
          child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.menu, color: context.colors.primary),
          ),
        );
      }),
    );
  }

  void _watchState(NameState state) {
    switch (state) {
      case InitialNamesState():
      case NamesLoadingState():
        _isLoading.value = true;
      case NamesLoadedState():
        _isLoading.value = false;
        _names.value = state.names;
      case ErrorLoadingNamesState():
        _isLoading.value = false;
        _names.value.clear();
    }
  }
}
