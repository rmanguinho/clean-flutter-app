# Run instructions

A Flutter application built with TDD, Clean Architecture, design patterns and SOLID
principles. It is the mobile counterpart of `clean-ts-api` and the reference
implementation used to teach the approach.

## Prerequisites

Flutter with a Dart SDK in the `>=2.12.0 <3.0.0` range — the project predates Dart 3 and
uses the null-safety syntax of that era. A device or simulator, plus Xcode for iOS or the
Android SDK for Android.

## Install and run

```bash
flutter pub get
flutter run
```

The API base URL is configured in the composition root under `lib/main/`. Point it at a
running `clean-ts-api` instance, or at any API exposing the same contract.

## Tests

```bash
flutter test
```

The suite covers every layer: domain use cases, data implementations against mocked
HTTP clients, presentation logic through stream assertions, and the UI through widget
tests.

## Layout

```
lib/domain/         Entities, use-case contracts and domain errors
lib/data/           Use-case implementations, depending only on domain contracts
lib/infra/          HTTP client and local storage adapters
lib/presentation/   Presenters, exposing state as streams
lib/ui/             Pages, components and the presentation contracts they consume
lib/main/           Composition root: factories, routes, decorators
lib/validation/     Validator implementations and the builder that composes them
test/               Mirrors the lib/ tree
```

Presenters expose state as streams rather than holding widget references, so the
presentation layer is testable without pumping a widget tree — and the UI layer depends
on an abstract presenter contract, never on a concrete presenter.
