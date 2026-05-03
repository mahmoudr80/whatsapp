# FLUTTER CODE GENERATION RULES (GENERAL — FEATURE-FIRST ARCHITECTURE)

Strictly follow every rule in this document when generating any Flutter code.
Read every section before writing a single line of code.

---

## ARCHITECTURE DESIGN RULE (MANDATORY — BEFORE EVERYTHING)

Before writing a single line of code, you MUST internally define:

```
1. Feature scope          → What does this feature do?
2. Required Cubit(s)      → How many? What operations per Cubit?
3. Required states        → Initial / Loading / Success / Failure per operation
4. Data flow              → UI → Cubit → Repository → Datasource → ApiHelper
5. Required models        → What JSON structures are involved?
6. Required endpoints     → What API paths will be used?
7. Required widgets       → What UI components need to be extracted?
```

> [!CAUTION]
> If the architecture is unclear at any step → clarify BEFORE coding.
> DO NOT start implementation without a fully defined structure.
> Acting as an architect first prevents structural mistakes that compound.

---

## 0. PRE-GENERATION THINKING STEP (MANDATORY)

Before writing ANY code, validate this checklist mentally:

```
[ ] What feature does this belong to?
[ ] Does data/ need datasources/, models/, repository/?
[ ] Does presentation/ need cubit/, screens/, widgets/?
[ ] Is domain/ justified? (abstract contract + use case both required?)
[ ] What states does this Cubit need? (Initial/Loading/Success/Failure per operation)
[ ] Does the datasource return ApiResult<Model>? (no throw)
[ ] Does the repository return ApiResult<T>? (no throw)
[ ] Does the Cubit switch on ApiResult? (no try/catch)
[ ] Is there only ONE Cubit instance for this screen?
[ ] Are all widget constructors verified before use?
[ ] Are all sizes using .w / .h / .r / .sp?
[ ] Are all colors and text styles using project-defined classes?
```

> [!CAUTION]
> Do NOT start writing code until every item above is mentally validated.
> Generating code first and fixing architecture later causes cascading inconsistencies.

---

## CORE PROTECTION RULE (STRICT)

```
NEVER modify any file inside lib/core/
```

- ✅ Use existing core utilities as-is
- ✅ If a core utility doesn't fit → adapt in the feature layer
- ❌ Do NOT edit network, storage, DI, routes, or theme files unless explicitly instructed
- ❌ Do NOT add new methods to core files unless asked

---

## REUSABILITY RULE (MANDATORY)

Before creating ANY new class, widget, or logic:

```
1. Check core/widgets/       → Does a reusable widget already exist?
2. Check core/utils/         → Does a utility already exist?
3. Check feature/widgets/    → Does a similar widget already exist?
4. Check feature/models/     → Does a similar model already exist?

If YES  → reuse it
If SIMILAR → extend or adapt it
If NO   → create new, following all rules
```

> [!WARNING]
> Duplicating logic that already exists is a structural bug.
> Always search before creating.

---

## DEBUGGING RULE

```
Code must be readable and easy to debug at a glance.
```

- ✅ Use clear, descriptive variable and method names (`userModel` not `um`, `getBestSeller` not `fetch`)
- ✅ Prefer flat, linear logic over deeply nested conditions
- ✅ Prefer splitting complex logic into smaller, focused methods
- ✅ Avoid deeply nested conditions — extract into a separate method instead
- ✅ Add comments ONLY when the logic is non-obvious — not for self-explanatory code
- ❌ Never use single-letter variable names outside of loop indices

```dart
// ❌ Hard to debug
final x = r is Success ? (r as Success).data['u']['n'] : null;

// ✅ Easy to debug
final result = await _datasource.getUser();
if (result is Success) {
  final userName = result.data['name'];
}
```

---

## SIMPLICITY RULE (KISS)

```
Always prefer the simplest solution that satisfies the requirement.
```

- ✅ If a concrete repository works — use it. Don't add an abstract layer for no reason.
- ✅ If a widget does the job — use it. Don't create a wrapper that wraps nothing.
- ❌ Do NOT introduce unnecessary layers, abstractions, or indirection
- ❌ Do NOT over-engineer a feature to handle cases that don't exist yet
- ❌ Do NOT add premature optimizations

> [!NOTE]
> Complexity that isn't justified by a real requirement is a bug, not a feature.
> When in doubt — do less, not more.

---

## EXPLAINABILITY RULE

```
Code must be easy to explain in an interview or code review.
```

- ✅ Each layer must have a single, clear responsibility
- ✅ Write code that you can explain line by line with confidence
- ❌ Avoid hidden logic, magic values, or non-obvious side effects
- ❌ Never write code that you yourself cannot explain

> [!NOTE]
> If you cannot explain why a line exists — it probably shouldn't be there.
> Clear code is the best proof of understanding.

---

## 1. TECHNOLOGY STACK

| Concern | Package |
|---|---|
| State management | `flutter_bloc` (Cubit only — no Bloc events) |
| Dependency injection | `get_it` |
| HTTP client | `dio` + custom `ApiHelper` wrapper |
| Responsive layout | `flutter_screenutil` |
| Localization | `easy_localization` (prefer; fallback to plain string only if key unavailable) |
| Secure storage | `flutter_secure_storage` |
| Local storage | `shared_preferences` |
| Navigation | Flutter named routes (`Navigator.pushNamed`) |

> If the project uses different packages, adapt accordingly — but keep all architectural rules.

---

## 2. MANDATORY FOLDER STRUCTURE

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── dependency_injection/
│   │   └── service_locator.dart   ← ALL get_it registrations in ONE file
│   ├── network/
│   │   ├── api_constants.dart     ← base URL + all endpoint path constants
│   │   ├── api_error_handler.dart ← converts DioException → ApiErrorModel
│   │   ├── api_error_model.dart   ← {String? error, int? code}
│   │   ├── api_helper.dart        ← thin wrapper: post(), get()
│   │   ├── api_result.dart        ← sealed Success<T> / Failure<T>
│   │   └── dio_factory.dart       ← creates Dio + adds interceptors ONCE
│   ├── routes/
│   │   └── routes_screens.dart    ← route name constants + generateRoutes()
│   ├── session/
│   │   └── session_manager.dart   ← token read / write / clear
│   ├── storage/
│   │   ├── local_storage_service.dart
│   │   └── secure_storage_service.dart
│   ├── theme/
│   │   ├── app_color.dart         ← class AppColor (NOT AppColors)
│   │   └── app_text_style.dart    ← class AppTextStyle (NOT AppTextStyles)
│   ├── utils/                     ← app-wide helpers (snackbar, dialogs…)
│   ├── validators/                ← pure functions, no Flutter imports
│   └── widgets/                   ← reusable cross-feature widgets ONLY
│
└── feature/
    └── [feature_name]/
        ├── data/
        │   ├── datasources/       ← PLURAL
        │   ├── models/            ← PLURAL
        │   └── repository/        ← SINGULAR
        │
        ├── domain/                ← OPTIONAL — see Section 4
        │   ├── entity/            ← lowercase, pure Dart classes only
        │   ├── repository/        ← abstract contract
        │   └── use_case/          ← snake_case folder, callable classes
        │
        └── presentation/          ← CORRECT spelling (never "presentaion")
            ├── cubit/
            ├── screens/
            └── widgets/           ← PLURAL
```

---

## 3. FILE & CLASS NAMING RULES

| Item | Convention | Example |
|---|---|---|
| All files | `snake_case.dart` | `auth_remote_datasource.dart` |
| All classes | `PascalCase` | `AuthRemoteDatasource` |
| All folders | `snake_case` lowercase | `use_case/` not `UseCase/` |
| Cubit | `[feature]_cubit.dart` | `home_cubit.dart` |
| State | `[feature]_state.dart` | `home_state.dart` — always `part of` cubit |
| Datasource | `[feature]_remote_datasource.dart` | `home_remote_datasource.dart` |
| Repository (concrete) | `[feature]_repository.dart` | `home_repository.dart` |
| Repository (abstract) | `[feature]_repo.dart` | `cart_repo.dart` |
| Model | `[entity]_model.dart` | `user_model.dart` |
| Screen | `[name]_screen.dart` | `login_screen.dart` |
| Widget | `[name]_widget.dart` or `[name]_item.dart` | `product_item.dart` |
| Use case | `[verb]_[noun]_use_case.dart` | `get_cart_products_use_case.dart` |

---

## 4. DOMAIN LAYER — STRICT YAGNI

### ✅ Create domain/ ONLY when BOTH are true:
1. An **abstract repository contract** is needed (data layer implements it)
2. A **use case** with callable business logic (`call()` method) exists

### ❌ Skip domain/ when:
- Repository is a concrete class called directly by the Cubit
- No abstraction or reuse is needed

### Domain rules (when used):

```dart
// domain/repository/cart_repo.dart — abstract ONLY, no implementation
abstract class CartRepo {
  Future<ApiResult<CartModel>> getCartProducts();
}

// domain/use_case/get_cart_products_use_case.dart
class GetCartProductsUseCase {
  final CartRepo _repo;
  const GetCartProductsUseCase(this._repo);

  Future<ApiResult<CartModel>> call() => _repo.getCartProducts();
}
```

> [!CAUTION]
> Domain files = **pure Dart only**. Zero Flutter imports (`package:flutter/...`).
> Never put UI widgets, dialogs, or constant lists inside domain files.

---

## 5. DATA LAYER — ApiResult FLOWS ALL THE WAY

This is the most critical rule. **No exceptions are thrown. No try/catch in Cubit.**

### The data flow:

```
ApiHelper → returns ApiResult<dynamic>
   ↓
Datasource → switches on it → returns ApiResult<Model>
   ↓
Repository → switches on it → returns ApiResult<T> (+ side effects on success)
   ↓
Cubit → switches on it → emits state (no try/catch)
```

---

### Layer 1 — ApiHelper (already exists, do not modify)

`ApiHelper` wraps Dio and returns `ApiResult<dynamic>`.
Only use methods that exist in the project's `ApiHelper`:

```dart
// Available methods (verify against your ApiHelper before using):
Future<ApiResult<dynamic>> post(String path, {dynamic data});
Future<ApiResult<dynamic>> get({required String path, Map<String, dynamic>? param});
```

> [!IMPORTANT]
> Do NOT call a method on `ApiHelper` that doesn't exist in the file.
> Do NOT add new methods to `ApiHelper` unless explicitly asked.

---

### Layer 2 — Remote Datasource

- Returns `ApiResult<Model>` — never throws
- **Prefer** `switch` on `ApiResult<dynamic>` from `ApiHelper`
- `if (result is Success)` is also acceptable when simpler
- On `Success`: parse JSON and wrap in `ApiResult.success(...)`
- On `Failure`: propagate with `ApiResult.failure(e)`

```dart
class HomeRemoteDatasource {
  final ApiHelper _helper;
  const HomeRemoteDatasource(this._helper);

  // Preferred — switch expression
  Future<ApiResult<BookListModel>> getBestSeller() async {
    final result = await _helper.get(path: ApiConstants.bestSellerEndpoint);
    return switch (result) {
      Success(data: final data) => ApiResult.success(BookListModel.fromJson(data)),
      Failure(errorModel: final e) => ApiResult.failure(e),
    };
  }

  // Also acceptable — if/is check (BOTH cases MUST be handled)
  Future<ApiResult<SliderModel>> getSliders() async {
    final result = await _helper.get(path: ApiConstants.slidersEndpoint);
    if (result is Success) {
      return ApiResult.success(SliderModel.fromJson(result.data));
    }
    // Failure case MUST always be explicitly returned — never ignored
    return ApiResult.failure((result as Failure).errorModel);
  }
}
```

> [!IMPORTANT]
> Whether using `switch` or `if (result is Success)`:
> **BOTH** the success path AND the failure path MUST always be handled.
> Silently ignoring the failure case is forbidden.

---

### Layer 3 — Repository

- Returns `ApiResult<T>` — never throws
- Uses `switch` statement (not expression — allows `await` inside)
- On `Success`: perform side effects (save session, cache, etc.), then return `ApiResult.success`
- On `Failure`: propagate with `ApiResult.failure(e)`

```dart
class AuthRepository {
  final AuthRemoteDatasource _datasource;
  final SessionManager _session;
  const AuthRepository(this._datasource, this._session);

  Future<ApiResult<UserModel>> login(String email, String password) async {
    final result = await _datasource.login({'email': email, 'password': password});
    switch (result) {
      case Success(data: final session):
        await _session.saveSession(session.token, session.user.toJson().toString());
        return ApiResult.success(session.user);
      case Failure(errorModel: final e):
        return ApiResult.failure(e);
    }
  }
}
```

> [!NOTE]
> Use `switch statement` (not switch expression) inside repository methods that need `await` on success.
> Use `switch expression` in datasources where no `await` is needed.

---

### Model — always `fromJson` and `toJson`:

```dart
class UserModel {
  final int id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}
```

---

## 6. CUBIT & STATE PATTERN

### State — sealed class with final sub-classes

The **only** state pattern used in this project:

```dart
// [feature]_state.dart
part of '[feature]_cubit.dart';

@immutable
sealed class FeatureState {}

final class FeatureInitial extends FeatureState {}

final class FeatureLoading extends FeatureState {}

final class FeatureSuccess extends FeatureState {
  final MyModel data;
  const FeatureSuccess(this.data);
}

final class FeatureFailure extends FeatureState {
  final String error;
  const FeatureFailure(this.error);
}
```

### When one Cubit handles multiple operations:

Give each operation its **own set** of states:

```dart
sealed class HomeState {}
final class HomeInitial extends HomeState {}

final class SliderLoading extends HomeState {}
final class SliderSuccess extends HomeState {
  final List<SliderModel> sliders;
  const SliderSuccess(this.sliders);
}
final class SliderFailure extends HomeState {
  final String error;
  const SliderFailure(this.error);
}

final class BestSellerLoading extends HomeState {}
final class BestSellerSuccess extends HomeState {
  final BookListModel books;
  const BestSellerSuccess(this.books);
}
final class BestSellerFailure extends HomeState {
  final String error;
  const BestSellerFailure(this.error);
}
```

---

### Cubit — switch on ApiResult, NO try/catch, ALWAYS check isClosed

```dart
// [feature]_cubit.dart
part '[feature]_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(HomeInitial());
  final HomeRepository _repository;

  Future<void> getBestSeller() async {
    if (isClosed) return;
    emit(BestSellerLoading());

    final result = await _repository.getBestSeller();

    if (isClosed) return;
    switch (result) {
      case Success(data: final books):
        emit(BestSellerSuccess(books));
      case Failure(errorModel: final e):
        emit(BestSellerFailure(e.error ?? 'Unexpected error'));
    }
  }
}
```

> [!IMPORTANT]
> ❌ No `try/catch` in Cubit — errors come through `ApiResult.failure`, not exceptions.
> ✅ Always check `if (isClosed) return;` before every `emit()`.
> ✅ Always check `if (isClosed) return;` immediately after every `await`.

---

### ONE Cubit per screen — strict rule

```
Each screen MUST have exactly ONE instance of a Cubit.
Never create multiple BlocProviders of the same Cubit type in one screen or widget tree.
```

❌ Wrong:
```dart
// Two instances of the same Cubit — NEVER
BlocProvider(create: (_) => HomeCubit(repo)..getSliders(), child: SliderWidget())
BlocProvider(create: (_) => HomeCubit(repo)..getBestSeller(), child: BestSellerList())
```

✅ Correct:
```dart
// One Cubit instance, multiple methods called on init
BlocProvider(
  create: (_) => HomeCubit(getIt<HomeRepository>())
    ..getSliders()
    ..getBestSeller(),
  child: HomeScreen(),
)
```

---

### Cubit responsibility rule

```
A Cubit MAY handle multiple related operations ONLY when they
belong to the SAME feature context.

When operations grow independent or complex → split into a new Cubit.
```

| ✅ Same Cubit OK | ❌ Split into new Cubit |
|---|---|
| Slider + BestSeller in HomeCubit | Auth logic inside HomeCubit |
| GetUser + UpdateUser in ProfileCubit | Cart logic inside HomeCubit |
| Search + Filter in SearchCubit | Two unrelated features in one Cubit |

---

### Duplicate API call prevention

```
Avoid triggering the same API call more than once unintentionally.
```

- ✅ Call Cubit methods on init only in `generateRoutes()` or screen `initState` — not in both
- ✅ Check current state before re-fetching: if already `Success` → skip
- ❌ Never call the same method from multiple `BlocProvider.create` in the same widget tree
- ❌ Never call a fetch method both in `generateRoutes()` AND inside the screen

---

## 7. SCREEN DESIGN RULES

### Screen = lightweight container only

✅ Screen responsibilities:
- Provide `BlocProvider` (create Cubit here)
- Define `Scaffold`, `AppBar`, `SafeArea`, `Padding`, layout skeleton
- Declare form controllers + `GlobalKey<FormState>` when needed
- Dispose controllers in `dispose()`
- Connect `BlocConsumer` / `BlocBuilder`

❌ Screen MUST NOT:
- Contain inline UI exceeding ~20 lines
- Contain business logic
- Instantiate datasources or repositories directly

### StatefulWidget vs StatelessWidget:

| Use `StatefulWidget` when | Use `StatelessWidget` when |
|---|---|
| Screen has `TextEditingController` | Screen is display-only |
| Screen has `GlobalKey<FormState>` | All state driven by Cubit |
| Screen needs local `setState` | No local mutable state |

### BlocConsumer listener — match on concrete state types:

```dart
BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    if (state is BestSellerLoading) {
      // show loading indicator
    } else if (state is BestSellerSuccess) {
      // navigate or show success feedback
    } else if (state is BestSellerFailure) {
      AppSnackbar.showError(context, state.error);
    }
  },
  builder: (context, state) {
    if (state is BestSellerLoading) return const LoadingView();
    if (state is BestSellerSuccess) return ProductList(books: state.books);
    if (state is BestSellerFailure) return ErrorView(message: state.error);
    return const SizedBox.shrink();
  },
);
```

### Loading UX consistency rule

```
Use a consistent loading pattern across the entire app.
```

- ✅ Prefer a reusable `LoadingView` widget in the builder for inline loading states
- ✅ Use `showDialog` with `CircularProgressIndicator` for blocking operations (e.g., form submit)
- ❌ Never mix both styles randomly in the same app
- ❌ Never show a blank screen while loading — always provide visual feedback

```dart
// Inline loading (in builder)
if (state is FeatureLoading) return const LoadingView();

// Blocking dialog (in listener, for mutations)
if (state is FeatureLoading) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
}
```

### Error UI consistency rule

```
Always show user-friendly error messages.
Never expose raw API error strings directly.
```

- ✅ Use `AppSnackbar.showError(context, message)` for transient errors
- ✅ Use a reusable `ErrorView` widget for inline full-screen error states
- ❌ Never show technical errors (stack traces, exception class names) to the user
- ❌ Never leave an error state with no UI feedback

```dart
// Inline error (in builder)
if (state is FeatureFailure) return ErrorView(message: state.error);

// Transient error (in listener)
if (state is FeatureFailure) {
  Navigator.pop(context); // close loading dialog if open
  AppSnackbar.showError(context, state.error);
}
```

---

## 8. WIDGET DECOMPOSITION RULES

### Extract into a widget when ANY is true:
- Inline UI block exceeds **~20 lines**
- It is a logically separate component
- It repeats in two or more places

### Common widget naming:

| Component | File | Class |
|---|---|---|
| List of items | `product_list.dart` | `ProductList` |
| Single item card | `product_item.dart` | `ProductItem` |
| Custom app bar | `home_app_bar.dart` | `HomeAppBar` |
| Form section | `login_form.dart` | `LoginForm` |
| Loading spinner | `loading_view.dart` | `LoadingView` |
| Error display | `error_view.dart` | `ErrorView` |
| Empty state | `empty_view.dart` | `EmptyView` |

### Widget placement:

```
Is this widget reused across 2+ features?
├── YES → lib/core/widgets/
└── NO  → lib/feature/[name]/presentation/widgets/
```

> [!TIP]
> **Always** check `core/widgets/` first before creating anything new.
> Reuse existing buttons, text fields, back buttons, network images.

### Widget API validation rule (MANDATORY)

Before using ANY widget — core or feature-level:

```
1. Open the widget file
2. Read its constructor
3. Only pass parameters that are explicitly defined
4. Never assume a parameter exists
5. Never pass extra parameters not in the constructor
```

> [!WARNING]
> Passing undefined parameters to a widget causes runtime errors that are hard to trace.
> This applies to ALL widgets — buttons, text fields, feature widgets, everything.
> When in doubt — read the constructor first, then write the call.

---

## 9. RESPONSIVENESS & ADAPTIVE UI RULES

`flutter_screenutil` scales sizes only — it does **NOT** handle layout adaptation.
Real responsiveness requires **two layers**:

| Layer | Tool | Purpose |
|---|---|---|
| Scaling | `flutter_screenutil` | All sizes, fonts, radii |
| Layout adaptation | `MediaQuery` / `LayoutBuilder` | Breakpoints, layout direction |

### ScreenUtil — mandatory for all sizes

```dart
SizedBox(height: 16.h)
Padding(padding: EdgeInsets.symmetric(horizontal: 20.w))
BorderRadius.circular(12.r)
Text("Title", style: TextStyle(fontSize: 16.sp))
```
❌ Never use raw numbers: `height: 16`, `width: 20`, `fontSize: 14`

### Breakpoint rule

```dart
final isTablet = MediaQuery.of(context).size.width > 600;
```

### Adaptive layout examples

```dart
// Layout direction
isTablet ? Row(children: [...]) : Column(children: [...])

// Grid count
final crossAxisCount = isTablet ? 4 : 2;

// Padding scaling
padding: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w)
```

### Flexible widgets — prefer over fixed sizes

| ✅ Use | ❌ Avoid |
|---|---|
| `Expanded` | `Container(width: 300)` |
| `Flexible` | Fixed pixel widths |
| `Spacer` | Hardcoded spacing |

### Text overflow — mandatory

```dart
Text(title, maxLines: 2, overflow: TextOverflow.ellipsis)
```

### Scroll safety

If content might overflow vertically → wrap in `SingleChildScrollView` or use `ListView`.
Never allow overflow errors.

### Image responsiveness

- Use `BoxFit.cover` or `BoxFit.contain`
- Avoid fixed height without constraints

### Tablet behavior

- Increase spacing
- Use multi-column layouts
- Avoid stretched single-column UI

> [!TIP]
> ScreenUtil for scaling + MediaQuery for breakpoint = 80% of real apps.
> Do NOT over-engineer responsiveness with complex systems.

---

## 10. DEPENDENCY INJECTION RULES

**One file only**: `lib/core/dependency_injection/service_locator.dart`

### Registration order:

```dart
final getIt = GetIt.instance;

void configureDependencies() {
  // 1. Third-party infrastructure
  getIt.registerLazySingleton<Dio>(() => DioFactory.createDio());
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getIt<Dio>()));
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  getIt.registerSingletonAsync<SharedPreferences>(() async => SharedPreferences.getInstance());

  // 2. Storage & session
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton<SessionManager>(() => SessionManager(getIt<LocalStorageService>(), getIt<SecureStorageService>()));

  // 3. Datasources
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource(getIt<ApiHelper>()));

  // 4. Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<AuthRemoteDatasource>(), getIt<SessionManager>()));
}
```

### Key rules:

- ❌ **Cubits are NEVER registered in `getIt`** — always created inside `BlocProvider.create`
- ✅ Use `registerLazySingleton` for services created once on first use
- ✅ Use `registerSingletonAsync` only for async init (e.g., `SharedPreferences`)
- ✅ Always register dependencies before dependents

### Instantiation rule

```
Do NOT manually instantiate repositories, datasources, or services anywhere.
```

- ✅ Always use `getIt<T>()` to access any registered dependency
- ✅ The ONLY place to create a Cubit is inside `BlocProvider.create`
- ❌ Never write `MyRepository(MyDatasource(...))` directly in a screen or widget
- ❌ Never write `MyCubit(MyRepository(...))` outside of `BlocProvider.create`

### Async DI readiness rule

```
If using registerSingletonAsync (e.g. SharedPreferences),
ensure getIt is fully initialized BEFORE runApp().
```

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt.allReady(); // wait for all async singletons
  runApp(const MyApp());
}
```

- ❌ Never access an async singleton before `getIt.allReady()` completes

---

## 11. ROUTING RULES

All routes live in `lib/core/routes/routes_screens.dart`.

### Step 1 — Add a constant:
```dart
abstract class RoutesScreens {
  static const String loginScreen = '/login_screen';
  static const String homeScreen  = '/home_screen';
}
```

### Step 2 — Add a case to `generateRoutes()`:
```dart
Route<dynamic>? generateRoutes(RouteSettings route) {
  switch (route.name) {

    // Simple screen — Cubit provided inside the screen
    case RoutesScreens.loginScreen:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    // Cubit must auto-fetch on init — provide here
    case RoutesScreens.homeScreen:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => HomeCubit(getIt<HomeRepository>())..getBestSeller(),
          child: const HomeScreen(),
        ),
      );

    // Screen needs route arguments
    case RoutesScreens.bookDetailScreen:
      final book = route.arguments as BookModel;
      return MaterialPageRoute(builder: (_) => BookDetailsScreen(bookModel: book));

    default:
      return null;
  }
}
```

### Navigation rules:
- ✅ Always `Navigator.pushNamed(context, RoutesScreens.xxx)`
- ✅ Pass data via `arguments:` parameter
- ❌ Never use `MaterialPageRoute` inline inside widget `onTap`
- ❌ Never hardcode route strings

---

## 12. THEME & STYLING — STRICT CONSTRAINTS

| Rule | ✅ Correct | ❌ Wrong |
|---|---|---|
| Color class name | `AppColor` | `AppColors` |
| Text style class name | `AppTextStyle` | `AppTextStyles` |
| Sizes | `20.w`, `16.h`, `12.r`, `14.sp` | `20`, `16`, `12`, `14` |
| Colors | `AppColor.primaryColor` | `Colors.blue` (except black/white/transparent) |
| Text styles | `AppTextStyle.headlineStyle` or `Theme.of(context).textTheme.xxx` | Inline `TextStyle(...)` |

---

## 13. NETWORK — STRICT CONSTRAINTS

- ❌ Never use `Dio` directly in feature code — always use `ApiHelper`
- ❌ Never add Dio interceptors inside `get()` or `post()` methods — only in `DioFactory`
- ❌ Never assume an `ApiHelper` method exists — check the file first
- ✅ All endpoint paths are constants in `ApiConstants`
- ✅ `ApiResult<T>` is the only return type from `ApiHelper`
- ✅ Prefer `switch` on `ApiResult`; `if (result is Success)` allowed when simpler, **but BOTH success and failure MUST always be handled**

---

## 14. LOCALIZATION RULES

- Prefer `LocaleKeys.some_key.tr()` for all user-facing strings
- Fallback to plain string only when the key does not exist yet
- Arguments: `LocaleKeys.welcome.tr(args: ['John'])`
- Plurals: `LocaleKeys.item_count.plural(3)`

---

## 15. ANTI-PATTERNS — NEVER DO THESE

| ❌ Wrong | ✅ Correct |
|---|---|
| `throw Exception(...)` in datasource/repository | Return `ApiResult.failure(e)` |
| `try/catch` in Cubit | Switch on `ApiResult` |
| Emit without `if (isClosed) return` guard | Always guard before emit |
| `if (result is Success)` without handling Failure | Always handle both cases explicitly |
| Action+Status enum pattern (unless project already uses it) | Sealed state sub-classes |
| Cubit registered in `getIt` | Cubit only in `BlocProvider.create` |
| Dio interceptors added inside a request method | Interceptors only in `DioFactory` |
| Multiple `BlocProvider`s for same Cubit in one screen | One provider, one Cubit instance |
| UI or Flutter imports in domain files | Domain = pure Dart only |
| Hardcoded pixel values | Always `.w`, `.h`, `.r`, `.sp` |
| Inline `Colors.blue` | `AppColor.xxx` |
| `AppColors` or `AppTextStyles` (plural) | `AppColor`, `AppTextStyle` (singular) |
| PascalCase folder names (`Entity/`) | `snake_case` folders (`entity/`) |
| Singular widget/datasource/model folders | `widgets/`, `datasources/`, `models/` |
| Plural repository folder (`repositories/`) | `repository/` (singular) |
| Misspelled `presentaion/` | `presentation/` |

---

## 16. FINAL CHECKLIST BEFORE SUBMITTING CODE

- [ ] Folder names: `presentation/`, `datasources/`, `models/`, `repository/`, `widgets/` — correct
- [ ] All folders are `snake_case` lowercase
- [ ] Files are `snake_case`, classes are `PascalCase`
- [ ] State file: `part of '[cubit].dart'` with `@immutable sealed class`
- [ ] State sub-classes use `final class`
- [ ] Cubit: `if (isClosed) return` before every `emit()` and after every `await`
- [ ] Cubit: `switch` on `ApiResult` — NO `try/catch`
- [ ] Only ONE Cubit instance per screen (no duplicate BlocProviders of same type)
- [ ] Cubit handles only related operations — split if logic is independent
- [ ] No duplicate API calls triggered from multiple places
- [ ] All widget constructors verified before passing parameters
- [ ] Dependencies accessed via `getIt<T>()` — no manual instantiation
- [ ] `getIt.allReady()` awaited before `runApp()` if using async singletons
- [ ] No raw pixel values — all sizes use `.w`, `.h`, `.r`, `.sp`
- [ ] Layout adapts for tablet using `MediaQuery` breakpoint
- [ ] All `Text` widgets have `maxLines` + `overflow: TextOverflow.ellipsis`
- [ ] Scrollable content wrapped in `SingleChildScrollView` or `ListView`
- [ ] Flexible widgets used instead of fixed-width containers
- [ ] Datasource: returns `ApiResult<Model>` — does NOT throw
- [ ] Repository: returns `ApiResult<T>` — does NOT throw
- [ ] Only `ApiHelper` methods that actually exist in the codebase are used
- [ ] Dio interceptors are in `DioFactory`, not in request methods
- [ ] New dependency registered in `service_locator.dart` (Cubits excluded)
- [ ] New route constant + `generateRoutes` case added
- [ ] `core/widgets/` checked before creating a new widget
- [ ] All sizes use `flutter_screenutil` extensions
- [ ] Colors use `AppColor` (not `AppColors`)
- [ ] Text styles use `AppTextStyle` (not `AppTextStyles`)
- [ ] Domain layer created only when abstract contract + use case both exist
- [ ] No Flutter imports inside domain files
