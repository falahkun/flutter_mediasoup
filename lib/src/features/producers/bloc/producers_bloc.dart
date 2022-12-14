import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

part 'producers_event.dart';
part 'producers_state.dart';

class ProducersBloc extends Bloc<ProducersEvent, ProducersState> {
  ProducersBloc() : super(ProducersState()) {
    on<ProducerAdd>((event, emit) async {
      if (event.dataProducer != null) {
        emit(ProducersState.copy(state, chatDataProducer: event.dataProducer));
      } else switch (event.producer!.source) {
        case 'mic': {
          emit(ProducersState.copy(state, mic: event.producer));
          break;
        }
        case 'webcam': {
          emit(ProducersState.copy(state, webcam: event.producer));
          break;
        }
        case 'screen': {
          emit(ProducersState.copy(state, screen: event.producer));
          break;
        }
        default: break;
      }
    });
    on<ProducerRemove>((event, emit) async {
      switch (event.source) {
        case 'mic': {
          state.mic?.close();
          emit(ProducersState.removeMic(state));
          break;
        }
        case 'webcam': {
          state.webcam?.close();
          emit(ProducersState.removeWebcam(state));
          break;
        }
        case 'screen': {
          state.screen?.close();
          emit(ProducersState.removeScreen(state));
          break;
        }
        default: break;
      }
    });
    on<ProducerResumed>((event, emit) async {
      switch (event.source) {
        case 'mic': {
          emit(ProducersState.copy(state, mic: state.mic!.resumeCopy()));
          break;
        }
        case 'webcam': {
          emit(ProducersState.copy(state, webcam: state.webcam!.resumeCopy()));
          break;
        }
        case 'screen': {
          emit(ProducersState.copy(state, screen: state.screen?.resumeCopy()));
          break;
        }
        default: break;
      }
    });
    on<ProducerPaused>((event, emit) async {
      switch (event.source) {
        case 'mic': {
          emit(ProducersState.copy(state, mic: state.mic!.pauseCopy()));
          break;
        }
        case 'webcam': {
          emit(ProducersState.copy(state, webcam: state.webcam!.pauseCopy()));
          break;
        }
        case 'screen': {
          emit(ProducersState.copy(state, screen: state.screen!.pauseCopy()));
          break;
        }
        default: break;
      }
    });
  }

  @override
  Stream<ProducersState> mapEventToState(
    ProducersEvent event,
  ) async* {
    if (event is ProducerAdd) {
      yield* _mapProducerAddToState(event);
    } else if (event is ProducerRemove) {
      yield* _mapProducerRemoveToState(event);
    } else if (event is ProducerResumed) {
      yield* _mapProducerResumeToState(event);
    } else if (event is ProducerPaused) {
      yield* _mapProducerPausedToState(event);
    }
  }

  Stream<ProducersState> _mapProducerAddToState(ProducerAdd event) async* {
    if (event.dataProducer != null) {
      yield ProducersState.copy(state, chatDataProducer: event.dataProducer);
    } else switch (event.producer!.source) {
      case 'mic': {
        yield ProducersState.copy(state, mic: event.producer);
        break;
      }
      case 'webcam': {
        yield ProducersState.copy(state, webcam: event.producer);
        break;
      }
      case 'screen': {
        yield ProducersState.copy(state, screen: event.producer);
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerRemoveToState(ProducerRemove event) async* {
    switch (event.source) {
      case 'mic': {
        state.mic?.close();
        yield ProducersState.removeMic(state);
        break;
      }
      case 'webcam': {
        state.webcam?.close();
        yield ProducersState.removeWebcam(state);
        break;
      }
      case 'screen': {
        state.screen?.close();
        yield ProducersState.removeScreen(state);
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerResumeToState(ProducerResumed event) async* {
    switch (event.source) {
      case 'mic': {
        yield ProducersState.copy(state, mic: state.mic!.resumeCopy());
        break;
      }
      case 'webcam': {
        yield ProducersState.copy(state, webcam: state.webcam!.resumeCopy());
        break;
      }
      case 'screen': {
        yield ProducersState.copy(state, screen: state.screen?.resumeCopy());
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerPausedToState(ProducerPaused event) async* {
    switch (event.source) {
      case 'mic': {
        yield ProducersState.copy(state, mic: state.mic!.pauseCopy());
        break;
      }
      case 'webcam': {
        yield ProducersState.copy(state, webcam: state.webcam!.pauseCopy());
        break;
      }
      case 'screen': {
        yield ProducersState.copy(state, screen: state.screen!.pauseCopy());
        break;
      }
      default: break;
    }
  }
}
