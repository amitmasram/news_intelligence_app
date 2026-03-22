import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_intelligence_app/features/auth/data/repositories/auth_repository.dart';
import 'package:news_intelligence_app/features/auth/domain/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthNotifier extends Notifier<AuthState> {
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    // Return initial state based on repository
    final isLoggedIn = _repository.isLoggedIn();
    return isLoggedIn ? AuthState.authenticated() : AuthState.unauthenticated();
  }

  Future<void> login(String username, String password) async {
    state = AuthState.loading();
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple mock login logic
    if (username.isNotEmpty && password.isNotEmpty) {
      await _repository.setLoggedIn(true);
      state = AuthState.authenticated();
    } else {
      state = AuthState.error('Invalid credentials');
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.unauthenticated();
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
