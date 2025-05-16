import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Define navigation pages
enum NavPage { reports, sites, generators, materials }

// Navigation State
class NavigationState extends Equatable {
  final NavPage currentPage;

  const NavigationState({this.currentPage = NavPage.reports});

  NavigationState copyWith({NavPage? currentPage}) {
    return NavigationState(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object> get props => [currentPage];
}

// Navigation Cubit
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(NavPage page) {
    emit(state.copyWith(currentPage: page));
  }

  void logout() {
    // In a real app, add signout logic here
    // For example: AuthRepository.signOut()
    emit(const NavigationState()); // Reset to default page
  }
}
