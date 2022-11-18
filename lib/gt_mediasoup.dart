library mediasoup_gt;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/me/bloc/me_bloc.dart';
import 'src/features/media_devices/bloc/media_devices_bloc.dart';
import 'src/features/peers/peers.dart';
import 'src/features/producers/bloc/producers_bloc.dart';
import 'src/features/room/bloc/room_bloc.dart';
import 'src/features/signaling/room_client_repository.dart';

export 'src/app_modules/app_modules.dart';
export 'src/features/media_devices/bloc/media_devices_bloc.dart';
export 'src/features/producers/bloc/producers_bloc.dart';
export 'src/features/signaling/room_client_repository.dart';
export 'src/features/peers/peers.dart';
export 'src/room_modules.dart';
export 'src/room_options.dart';

RoomClientRepository onCreate(BuildContext context,
    {MediaDevicesBloc? mediaDevicesBloc, ProducersBloc? producersBloc}) {
  final meState = context.read<MeBloc>().state;
  String displayName = meState.displayName;
  String id = meState.id;
  final roomState = context.read<RoomBloc>().state;
  String url = roomState.url;

  return RoomClientRepository(
    peerId: id,
    displayName: displayName,
    url: url,
    roomId: '',
    peersBloc: context.read<PeersBloc>(),
    producersBloc: producersBloc ?? context.read<ProducersBloc>(),
    meBloc: context.read<MeBloc>(),
    roomBloc: context.read<RoomBloc>(),
    mediaDevicesBloc: mediaDevicesBloc ?? context.read<MediaDevicesBloc>(),
  );
}
