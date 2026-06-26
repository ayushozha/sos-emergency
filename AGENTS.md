# AGENTS.md

Guidance for AI coding agents working in this repository. These practices are derived
from the official [Flutter](https://github.com/flutter/skills) and
[Dart](https://github.com/dart-lang/skills) agent skills
(see <https://docs.flutter.dev/ai/agent-skills>), adapted to this project's chosen
architecture: **Riverpod (with code generation), Freezed, go_router, and the
repository pattern**.

## Tech stack & required packages

This project standardizes on the following. Add them to `pubspec.yaml` before writing
feature code, and prefer these over ad-hoc alternatives.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.1.0       # state management
  riverpod_annotation: ^4.0.0    # @riverpod codegen annotations
  go_router: ^17.3.0             # declarative routing
  freezed_annotation: ^3.1.0     # immutable models / unions
  json_annotation: ^4.9.0        # JSON serialization annotations

dev_dependencies:
  build_runner: ^2.15.0
  riverpod_generator: ^4.0.0
  freezed: ^3.2.3
  json_serializable: ^6.11.2
  custom_lint: ^0.8.1
  riverpod_lint: ^3.1.0
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.1
  very_good_analysis: ^10.3.0
```

> These are the versions currently resolved in `pubspec.yaml` (Dart 3.12). Riverpod 3
> and Freezed 3 are in use — note the API differences below versus older 2.x snippets
> you may find online.

This repo already uses `very_good_analysis` for lints — keep it. Add `riverpod_lint`
to `analysis_options.yaml` under the `custom_lint` plugin.

## Code generation workflow

Riverpod, Freezed, and JSON serialization in this project are **all code-generated**.
Hand-writing the boilerplate they generate is a mistake.

- After editing any file with `@riverpod`, `@freezed`, or `@JsonSerializable`, run:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- During active development, prefer the watcher:
  ```bash
  dart run build_runner watch --delete-conflicting-outputs
  ```
- Generated files end in `.g.dart` (Riverpod / JSON) and `.freezed.dart` (Freezed).
  **Never edit generated files by hand.** Each source file must declare its parts:
  ```dart
  part 'user.freezed.dart';
  part 'user.g.dart';
  ```
- `.g.dart` and `.freezed.dart` files are build artifacts. Do not commit fixes to them
  directly; regenerate instead.

## Project structure

Use a feature-first layout layered into UI → Logic → Data, per the Flutter
architecture guidance.

```
lib/
  main.dart
  router/                 # go_router configuration
    app_router.dart
  features/
    <feature>/
      data/
        <feature>_repository.dart        # repository interface + impl
        models/
          <model>.dart                   # Freezed + JSON models
      application/                        # providers / notifiers (logic)
        <feature>_controller.dart
      presentation/                       # widgets & screens (UI)
        <feature>_screen.dart
  shared/                 # cross-feature widgets, utils, providers
```

Keep the layers' dependencies pointing inward: **UI depends on Logic, Logic depends on
Data. Data never imports UI.**

## Models — Freezed + JSON serialization

The Flutter `implement-json-serialization` skill describes manual `fromJson`/`toJson`.
In this project, **generate them instead** using Freezed + `json_serializable`.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    @Default(false) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

- Use Freezed `sealed`/union types for state and result modeling (e.g. loading /
  data / error) and exhaust them with `switch` pattern matching (Dart
  `use-pattern-matching` skill).
- Keep models immutable. Never add mutable fields or business logic to model classes.

## Repository pattern (Data layer)

All external I/O (network, local storage, platform channels) lives behind a repository.
Logic and UI layers depend on the repository's **interface**, never on the HTTP client
or data source directly.

```dart
abstract interface class UserRepository {
  Future<User> fetchUser(String id);
}

class HttpUserRepository implements UserRepository {
  HttpUserRepository(this._client);
  final http.Client _client;

  @override
  Future<User> fetchUser(String id) async {
    final res = await _client.get(Uri.parse('$baseUrl/users/$id'));
    if (res.statusCode != 200) {
      throw UserRepositoryException(res.statusCode);
    }
    return User.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}
```

- Repositories return domain models, never raw `Response`/JSON maps.
- Translate transport errors into typed domain exceptions/failures at this boundary.
- Expose each repository through a Riverpod provider so it can be overridden in tests.

## State management — Riverpod with codegen

Use the `@riverpod` annotation (code generation), not the legacy manual provider
constructors.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) =>
    HttpUserRepository(ref.watch(httpClientProvider));

@riverpod
class UserController extends _$UserController {
  @override
  Future<User> build(String id) {
    return ref.watch(userRepositoryProvider).fetchUser(id);
  }
}
```

- Async state: return `Future`/`Stream` from a `build` method and consume
  `AsyncValue` in the UI with `.when(data:, loading:, error:)`.
- Read providers in widgets via `ConsumerWidget` / `ConsumerStatefulWidget` and
  `ref.watch` (rebuild) vs `ref.read` (one-off, e.g. in callbacks).
- Never create providers inside `build()`; declare them at top level.
- Wrap the app in a single `ProviderScope` at the root.

## Routing — go_router

Configure declarative routing via `MaterialApp.router` and `go_router`, per the Flutter
`setup-declarative-routing` skill.

```dart
@riverpod
GoRouter appRouter(Ref ref) => GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'user/:id',
          builder: (context, state) =>
              UserScreen(id: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
);
```

- Define route paths as constants/typed routes; avoid magic strings scattered in
  widgets.
- Use `context.go()` for navigation that replaces the stack and `context.push()` to
  stack on top.
- Centralize redirect/auth-guard logic in the router's `redirect` callback.
- Nest routes for hierarchical navigation and keep deep-linking working.

## Responsive layouts

Per the Flutter `build-responsive-layout` and `fix-layout-issues` skills:

- Adapt to screen size with `LayoutBuilder`, `MediaQuery.sizeOf(context)`, and
  `Expanded`/`Flexible` rather than hard-coded pixel sizes.
- Prefer `MediaQuery.sizeOf`/`.of` accessors that subscribe to only what you use.
- Diagnose overflow and unbounded-constraint errors by reading the constraints flowing
  down the widget tree; don't mask them with fixed sizes.

## Testing

Follow the Dart/Flutter testing skills:

- **Unit tests** (`package:test` / `flutter_test`) for repositories and Riverpod
  notifiers. Override providers in a `ProviderContainer` and use `mocktail` to fake
  repositories.
- **Widget tests** (`WidgetTester`) for UI rendering and interactions; pump widgets
  inside a `ProviderScope` with overridden providers.
- **Integration tests** (`integration_test` package) for end-to-end flows.
- Use `mocktail` (already a dependency) for mocks — no manual mock classes.
- Place tests in `test/` mirroring the `lib/` structure; name files `*_test.dart`.

```dart
final container = ProviderContainer(
  overrides: [
    userRepositoryProvider.overrideWithValue(MockUserRepository()),
  ],
);
addTearDown(container.dispose);
```

## Static analysis & quality gates

Per the Dart `run-static-analysis` skill, before considering any change complete:

```bash
dart run build_runner build --delete-conflicting-outputs   # regenerate code
dart analyze                                                # must be clean
dart fix --apply                                            # auto-fix lints
dart format .                                               # format
flutter test                                                # tests pass
```

- Resolve all analyzer warnings; do not commit with analysis errors.
- When `pub get` fails on version conflicts, follow the
  `resolve-package-conflicts` workflow (inspect constraints, bump/loosen, re-run) rather
  than blindly deleting `pubspec.lock`.

## Conventions

- `lowerCamelCase` for members/variables, `UpperCamelCase` for types,
  `lower_snake_case.dart` for filenames.
- Prefer `const` constructors and `final` fields wherever possible.
- Exhaustively handle Freezed unions and `AsyncValue` states — let the analyzer catch
  missing cases.
- Keep widgets small; extract sub-widgets rather than deeply nesting build methods.
- No business logic in widgets — it belongs in Riverpod notifiers or repositories.
