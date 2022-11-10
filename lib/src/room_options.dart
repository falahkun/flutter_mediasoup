import 'package:equatable/equatable.dart';

class RoomOptions extends Equatable {
  final String displayName;
  final String baseUrl;
  final String tokenId;
  final String userId;
  final String peerId;

  RoomOptions({
    required this.displayName,
    required this.baseUrl,
    required this.tokenId,
    required this.userId,
    required this.peerId,
  });

  Uri get _uri => Uri.parse(baseUrl);

  String get url =>
      'wss://${_uri.host}:${_uri.port}?token=$tokenId&userId=$userId&peerId=$peerId';

  @override
  // TODO: implement props
  List<Object?> get props => [
        displayName,
        url,
        tokenId,
        userId,
      ];
}
