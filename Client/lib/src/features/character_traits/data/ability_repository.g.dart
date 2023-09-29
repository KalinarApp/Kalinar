// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$abilityRepositoryHash() => r'645269bbc1d03ad257af6f9bb1a047e704892f69';

/// See also [abilityRepository].
@ProviderFor(abilityRepository)
final abilityRepositoryProvider = Provider<AbilityRepository>.internal(
  abilityRepository,
  name: r'abilityRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$abilityRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AbilityRepositoryRef = ProviderRef<AbilityRepository>;
String _$getAbilityByIdHash() => r'6797bf5e0a240b078f7d071e60fa1a3afd6682fc';

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

typedef GetAbilityByIdRef = AutoDisposeFutureProviderRef<Ability>;

/// See also [getAbilityById].
@ProviderFor(getAbilityById)
const getAbilityByIdProvider = GetAbilityByIdFamily();

/// See also [getAbilityById].
class GetAbilityByIdFamily extends Family<AsyncValue<Ability>> {
  /// See also [getAbilityById].
  const GetAbilityByIdFamily();

  /// See also [getAbilityById].
  GetAbilityByIdProvider call(
    String abilityId,
  ) {
    return GetAbilityByIdProvider(
      abilityId,
    );
  }

  @override
  GetAbilityByIdProvider getProviderOverride(
    covariant GetAbilityByIdProvider provider,
  ) {
    return call(
      provider.abilityId,
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
  String? get name => r'getAbilityByIdProvider';
}

/// See also [getAbilityById].
class GetAbilityByIdProvider extends AutoDisposeFutureProvider<Ability> {
  /// See also [getAbilityById].
  GetAbilityByIdProvider(
    this.abilityId,
  ) : super.internal(
          (ref) => getAbilityById(
            ref,
            abilityId,
          ),
          from: getAbilityByIdProvider,
          name: r'getAbilityByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAbilityByIdHash,
          dependencies: GetAbilityByIdFamily._dependencies,
          allTransitiveDependencies:
              GetAbilityByIdFamily._allTransitiveDependencies,
        );

  final String abilityId;

  @override
  bool operator ==(Object other) {
    return other is GetAbilityByIdProvider && other.abilityId == abilityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, abilityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$listAbilitiesHash() => r'518593676ed5e947802a7a3a5a8845d705edb13d';
typedef ListAbilitiesRef = AutoDisposeFutureProviderRef<List<Ability>>;

/// See also [listAbilities].
@ProviderFor(listAbilities)
const listAbilitiesProvider = ListAbilitiesFamily();

/// See also [listAbilities].
class ListAbilitiesFamily extends Family<AsyncValue<List<Ability>>> {
  /// See also [listAbilities].
  const ListAbilitiesFamily();

  /// See also [listAbilities].
  ListAbilitiesProvider call(
    String groupId,
  ) {
    return ListAbilitiesProvider(
      groupId,
    );
  }

  @override
  ListAbilitiesProvider getProviderOverride(
    covariant ListAbilitiesProvider provider,
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
  String? get name => r'listAbilitiesProvider';
}

/// See also [listAbilities].
class ListAbilitiesProvider extends AutoDisposeFutureProvider<List<Ability>> {
  /// See also [listAbilities].
  ListAbilitiesProvider(
    this.groupId,
  ) : super.internal(
          (ref) => listAbilities(
            ref,
            groupId,
          ),
          from: listAbilitiesProvider,
          name: r'listAbilitiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listAbilitiesHash,
          dependencies: ListAbilitiesFamily._dependencies,
          allTransitiveDependencies:
              ListAbilitiesFamily._allTransitiveDependencies,
        );

  final String groupId;

  @override
  bool operator ==(Object other) {
    return other is ListAbilitiesProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$listAbilityTagsByGroupIdHash() =>
    r'c19b5a085c2c030627e05774dcec8c4badd8431d';
typedef ListAbilityTagsByGroupIdRef
    = AutoDisposeFutureProviderRef<List<String>>;

/// See also [listAbilityTagsByGroupId].
@ProviderFor(listAbilityTagsByGroupId)
const listAbilityTagsByGroupIdProvider = ListAbilityTagsByGroupIdFamily();

/// See also [listAbilityTagsByGroupId].
class ListAbilityTagsByGroupIdFamily extends Family<AsyncValue<List<String>>> {
  /// See also [listAbilityTagsByGroupId].
  const ListAbilityTagsByGroupIdFamily();

  /// See also [listAbilityTagsByGroupId].
  ListAbilityTagsByGroupIdProvider call(
    String groupId,
  ) {
    return ListAbilityTagsByGroupIdProvider(
      groupId,
    );
  }

  @override
  ListAbilityTagsByGroupIdProvider getProviderOverride(
    covariant ListAbilityTagsByGroupIdProvider provider,
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
  String? get name => r'listAbilityTagsByGroupIdProvider';
}

/// See also [listAbilityTagsByGroupId].
class ListAbilityTagsByGroupIdProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [listAbilityTagsByGroupId].
  ListAbilityTagsByGroupIdProvider(
    this.groupId,
  ) : super.internal(
          (ref) => listAbilityTagsByGroupId(
            ref,
            groupId,
          ),
          from: listAbilityTagsByGroupIdProvider,
          name: r'listAbilityTagsByGroupIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listAbilityTagsByGroupIdHash,
          dependencies: ListAbilityTagsByGroupIdFamily._dependencies,
          allTransitiveDependencies:
              ListAbilityTagsByGroupIdFamily._allTransitiveDependencies,
        );

  final String groupId;

  @override
  bool operator ==(Object other) {
    return other is ListAbilityTagsByGroupIdProvider &&
        other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$listAbilityTagsByAbilityIdHash() =>
    r'e73794d8d313971793d77e31f56aae669673f3d6';
typedef ListAbilityTagsByAbilityIdRef
    = AutoDisposeFutureProviderRef<List<String>>;

/// See also [listAbilityTagsByAbilityId].
@ProviderFor(listAbilityTagsByAbilityId)
const listAbilityTagsByAbilityIdProvider = ListAbilityTagsByAbilityIdFamily();

/// See also [listAbilityTagsByAbilityId].
class ListAbilityTagsByAbilityIdFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [listAbilityTagsByAbilityId].
  const ListAbilityTagsByAbilityIdFamily();

  /// See also [listAbilityTagsByAbilityId].
  ListAbilityTagsByAbilityIdProvider call(
    String abilityId,
  ) {
    return ListAbilityTagsByAbilityIdProvider(
      abilityId,
    );
  }

  @override
  ListAbilityTagsByAbilityIdProvider getProviderOverride(
    covariant ListAbilityTagsByAbilityIdProvider provider,
  ) {
    return call(
      provider.abilityId,
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
  String? get name => r'listAbilityTagsByAbilityIdProvider';
}

/// See also [listAbilityTagsByAbilityId].
class ListAbilityTagsByAbilityIdProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [listAbilityTagsByAbilityId].
  ListAbilityTagsByAbilityIdProvider(
    this.abilityId,
  ) : super.internal(
          (ref) => listAbilityTagsByAbilityId(
            ref,
            abilityId,
          ),
          from: listAbilityTagsByAbilityIdProvider,
          name: r'listAbilityTagsByAbilityIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listAbilityTagsByAbilityIdHash,
          dependencies: ListAbilityTagsByAbilityIdFamily._dependencies,
          allTransitiveDependencies:
              ListAbilityTagsByAbilityIdFamily._allTransitiveDependencies,
        );

  final String abilityId;

  @override
  bool operator ==(Object other) {
    return other is ListAbilityTagsByAbilityIdProvider &&
        other.abilityId == abilityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, abilityId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
