import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_intelligence_app/features/auth/data/repositories/auth_repository.dart';
import 'package:news_intelligence_app/features/auth/domain/auth_state.dart';

/// Provider for the [AuthRepository] instance.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Notifier responsible for managing the authentication state of the application.
class AuthNotifier extends Notifier<AuthState> {
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    
    // Determine the initial state based on persisted data.
    final isLoggedIn = _repository.isLoggedIn();
    return isLoggedIn ? AuthState.authenticated() : AuthState.unauthenticated();
  }

  /// Attempts to log in the user with the provided [username] and [password].
  /// 
  /// NOTE: This is currently a mock implementation with simulated delay.
  Future<void> login(String username, String password) async {
    state = AuthState.loading();
    
    // Simulate network latency.
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple mock validation: accepts any non-empty credentials.
    if (username.isNotEmpty && password.isNotEmpty) {
      await _repository.setLoggedIn(true);
      state = AuthState.authenticated();
    } else {
      state = AuthState.error('Invalid credentials');
    }
  }

  /// Logs out the current user and resets the authentication state.
  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.unauthenticated();
  }
}

/// Global provider for the [AuthNotifier] and its state.
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
