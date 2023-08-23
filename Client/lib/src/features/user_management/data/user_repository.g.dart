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
String _$getUserGroupsByIdHash() => r'64f019e960719d72fc9d0b09b0634cc65c0e4d3d';

/// See also [getUserGroupsById].
@ProviderFor(getUserGroupsById)
final getUserGroupsByIdProvider =
    AutoDisposeFutureProvider<List<GroupMember>>.internal(
  getUserGroupsById,
  name: r'getUserGroupsByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserGroupsByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserGroupsByIdRef = AutoDisposeFutureProviderRef<List<GroupMember>>;
String _$getSelectedGroupHash() => r'9ce840f95da9d0d7273f01abfb2e563e6cf6a070';

/// See also [getSelectedGroup].
@ProviderFor(getSelectedGroup)
final getSelectedGroupProvider =
    AutoDisposeFutureProvider<GroupMember?>.internal(
  getSelectedGroup,
  name: r'getSelectedGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSelectedGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSelectedGroupRef = AutoDisposeFutureProviderRef<GroupMember?>;
String _$isAdminInSelectedGroupHash() =>
    r'e82308c99d2d09b035827b1503fa1a3554fd82e6';

/// See also [isAdminInSelectedGroup].
@ProviderFor(isAdminInSelectedGroup)
final isAdminInSelectedGroupProvider = AutoDisposeProvider<bool>.internal(
  isAdminInSelectedGroup,
  name: r'isAdminInSelectedGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAdminInSelectedGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAdminInSelectedGroupRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
