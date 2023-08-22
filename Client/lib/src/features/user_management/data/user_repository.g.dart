// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'b2fe08b3bab0e08cda7ba6543416e5fa94549521';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = ProviderRef<UserRepository>;
String _$getUserByIdHash() => r'd78d69113870f3ca3714b776a14664015a74fa11';

/// See also [getUserById].
@ProviderFor(getUserById)
final getUserByIdProvider = AutoDisposeFutureProvider<User>.internal(
  getUserById,
  name: r'getUserByIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserByIdRef = AutoDisposeFutureProviderRef<User>;
String _$getUserGroupsByIdHash() => r'4df35f4a94f13e6f79891ee7a803d145d0c6a496';

/// See also [getUserGroupsById].
@ProviderFor(getUserGroupsById)
final getUserGroupsByIdProvider = FutureProvider<List<GroupMember>>.internal(
  getUserGroupsById,
  name: r'getUserGroupsByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserGroupsByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserGroupsByIdRef = FutureProviderRef<List<GroupMember>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
