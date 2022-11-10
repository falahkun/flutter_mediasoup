import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gt_mediasoup/src/features/me/bloc/me_bloc.dart';
import 'package:gt_mediasoup/src/features/media_devices/bloc/media_devices_bloc.dart';
import 'package:gt_mediasoup/src/features/peers/bloc/peers_bloc.dart';
import 'package:gt_mediasoup/src/features/producers/bloc/producers_bloc.dart';
import 'package:gt_mediasoup/src/features/room/bloc/room_bloc.dart';
import 'package:gt_mediasoup/src/room_options.dart';

List<BlocProvider> getRoomModules({
  required RoomOptions options,
}) {
  return [
    BlocProvider<ProducersBloc>(
      lazy: false,
      create: (context) => ProducersBloc(),
    ),
    BlocProvider<PeersBloc>(
      lazy: false,
      create: (context) => PeersBloc(
        mediaDevicesBloc: context.read<MediaDevicesBloc>(),
      ),
    ),
    BlocProvider<MeBloc>(
      lazy: false,
      create: (context) => MeBloc(
        displayName: options.displayName,
        id: options.userId,
      ),
    ),
    BlocProvider<RoomBloc>(
      lazy: false,
      create: (context) => RoomBloc(options.url),
    ),
  ];
}
