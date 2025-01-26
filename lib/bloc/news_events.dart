import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NewsEvent extends Equatable {}

class LoadNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}
