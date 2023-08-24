// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupRepositoryHash() => r'd860ea9914cc3c92a5558107e542fb4361e7ff3d';

/// See also [groupRepository].
@ProviderFor(groupRepository)
final groupRepositoryProvider = AutoDisposeProvider<GroupRepository>.internal(
  groupRepository,
  name: r'groupRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GroupRepositoryRef = AutoDisposeProviderRef<GroupRepository>;
String _$getGroupByIdHash() => r'b716c506be09cb6e7da73b492b34fc2f260fb4b6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetGroupByIdRef = AutoDisposeFutureProviderRef<Group>;

/// See also [getGroupById].
@ProviderFor(getGroupById)
const getGroupByIdProvider = GetGroupByIdFamily();

/// See also [getGroupById].
class GetGroupByIdFamily extends Family<AsyncValue<Group>> {
  /// See also [getGroupById].
  const GetGroupByIdFamily();

  /// See also [getGroupById].
  GetGroupByIdProvider call(
    String groupId,
  ) {
    return GetGroupByIdProvider(
      groupId,
    );
  }

  @override
  GetGroupByIdProvider getProviderOverride(
    covariant GetGroupByIdProvider provider,
  ) {
    return call(
      provider.groupId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getGroupByIdProvider';
}

/// See also [getGroupById].
class GetGroupByIdProvider extends AutoDisposeFutureProvider<Group> {
  /// See also [getGroupById].
  GetGroupByIdProvider(
    this.groupId,
  ) : super.internal(
          (ref) => getGroupById(
            ref,
            groupId,
          ),
          from: getGroupByIdProvider,
          name: r'getGroupByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGroupByIdHash,
          dependencies: GetGroupByIdFamily._dependencies,
          allTransitiveDependencies:
              GetGroupByIdFamily._allTransitiveDependencies,
        );

  final String groupId;

  @override
  bool operator ==(Object other) {
    return other is GetGroupByIdProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getGroupMembersByIdHash() =>
    r'83fa553a4571759929df305a7dc27339d8256437';
typedef GetGroupMembersByIdRef
    = AutoDisposeFutureProviderRef<List<GroupMember>>;

/// See also [getGroupMembersById].
@ProviderFor(getGroupMembersById)
const getGroupMembersByIdProvider = GetGroupMembersByIdFamily();

/// See also [getGroupMembersById].
class GetGroupMembersByIdFamily extends Family<AsyncValue<List<GroupMember>>> {
  /// See also [getGroupMembersById].
  const GetGroupMembersByIdFamily();

  /// See also [getGroupMembersById].
  GetGroupMembersByIdProvider call(
    String groupId,
  ) {
    return GetGroupMembersByIdProvider(
      groupId,
    );
  }

  @override
  GetGroupMembersByIdProvider getProviderOverride(
    covariant GetGroupMembersByIdProvider provider,
  ) {
    return call(
      provider.groupId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getGroupMembersByIdProvider';
}

/// See also [getGroupMembersById].
class GetGroupMembersByIdProvider
    extends AutoDisposeFutureProvider<List<GroupMember>> {
  /// See also [getGroupMembersById].
  GetGroupMembersByIdProvider(
    this.groupId,
  ) : super.internal(
          (ref) => getGroupMembersById(
            ref,
            groupId,
          ),
          from: getGroupMembersByIdProvider,
          name: r'getGroupMembersByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGroupMembersByIdHash,
          dependencies: GetGroupMembersByIdFamily._dependencies,
          allTransitiveDependencies:
              GetGroupMembersByIdFamily._allTransitiveDependencies,
        );

  final String groupId;

  @override
  bool operator ==(Object other) {
    return other is GetGroupMembersByIdProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
