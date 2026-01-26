import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/models/name_source.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';

extension NameExtension on Name {
  bool isFavorite(BuildContext context) =>
      BlocProvider.of<FavoriteCubit>(context).favoriteNameIds.contains(id);

  NameAudioSource get toAudioSource => NameAudioSource(path: audioPath);
}
