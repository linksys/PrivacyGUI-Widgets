# Project Test Case Writing Guide

This document aims to provide project members with the conventions and best practices to follow when writing automated test cases, ensuring consistency, readability, maintainability, and effectiveness of the test code.

---

## 1. Test File Naming and Structure

### 1.1 File Naming
*   Test files should be named in the format `[component_name]_test.dart`.
    *   Examples: `tree_node_widget_test.dart`, `tree_action_menu_test.dart`

### 1.2 File Structure
*   Each test file should contain a `main()` function.
*   Use the `group()` function to logically group related tests, typically using the name of the Widget being tested as the `group` description.
*   Each individual test case should use the `testWidgets()` or `testWidgetGoldens()` function.

```dart
void main() {
  group('MyWidget', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      // Arrange, Act, Assert
    });

    testWidgetGoldens('Golden test for MyWidget', (WidgetTester tester) async {
      // Golden test steps
    });
  });
}
```

---

## 2. Test Case Writing Principles

### 2.1 Arrange-Act-Assert (AAA) Pattern
*   Each test case should be clearly divided into three parts:
    *   **Arrange**: Set up the test environment, initialize data, and create the Widget under test.
    *   **Act**: Simulate user interaction or trigger the behavior being tested.
    *   **Assert**: Verify that the outcome of the behavior meets expectations.

### 2.2 Test Descriptions
*   The descriptions for `testWidgets()` and `testWidgetGoldens()` should be clear, concise, and state the specific purpose or behavior being verified by the test case.
    *   Examples: `'renders title and popup menu'`, `'tapping a simple action calls onActionTap'`

### 2.3 Helper Functions
*   For repetitive Widget creation logic, helper functions (e.g., `buildWidget`) should be created to simplify test code, improving readability and maintainability.
*   These helper functions should accept necessary parameters to allow flexible configuration of the Widget in different test cases.

```dart
Widget buildWidget({
  String label = 'Default Label',
  List<TreeAction> actions = const [],
  // ... other parameters
}) {
  return buildTestWidget(
    child: MyWidget(
      label: label,
      actions: actions,
      // ...
    ),
  );
}
```

---

## 3. Widget Testing Specific Conventions

### 3.1 Test Environment Setup
*   All Widget tests should use the `buildTestWidget` function (from `test/tester/test_widget.dart`) to wrap the Widget under test, ensuring it is rendered within the correct Widget tree environment.

```dart
import '../../tester/test_widget.dart';
// ...
await tester.pumpWidget(buildTestWidget(child: MyWidget()));
```

### 3.2 Simulating User Interaction
*   Use `tester.tap()` to simulate tap events.
*   After each simulated interaction, always use `tester.pumpAndSettle()` to wait for UI updates and any animations to complete, ensuring the test performs assertions in a stable state.

```dart
await tester.tap(find.text('Click Me'));
await tester.pumpAndSettle();
```

### 3.3 Assertions
*   **Finding Widgets**:
    *   `find.text('Some Text')`: Finds a Widget containing specific text.
    *   `find.byType(SomeWidget)`: Finds a Widget of a specific type.
    *   `find.byKey(ValueKey('someKey'))`: Finds a Widget with a specific Key.
*   **Verifying Existence**:
    *   `findsOneWidget`: Verifies that one Widget is found.
    *   `findsNothing`: Verifies that no Widgets are found.
    *   `findsNWidgets(n)`: Verifies that n Widgets are found.
*   **Verifying Callbacks**:
    *   Use `bool` flags or `mock` objects to verify if a callback function was triggered.

```dart
expect(find.text('Hello'), findsOneWidget);
expect(find.byType(SomeOtherWidget), findsNothing);

bool tapped = false;
await tester.pumpWidget(buildWidget(onTap: () => tapped = true));
await tester.tap(find.byType(GestureDetector));
expect(tapped, isTrue);
```

---

## 4. Golden Tests (Visual Regression Testing)

### 4.1 When to Use
*   Use Golden Tests when you need to ensure that the visual presentation of a Widget (layout, colors, fonts, icons, etc.) remains unchanged after code modifications.
*   Especially suitable for complex UI layouts or custom-drawn Widgets.

### 4.2 Writing Conventions
*   Use the `testWidgetGoldens()` function to define Golden Test cases.
*   At the beginning of the test, you can set `tester.binding.setSurfaceSize()` to specify the screen size for the test, ensuring Golden images are generated at a fixed size.
*   Use `tester.takeGolden('golden_file_name')` to capture a visual snapshot of the current Widget.
    *   `golden_file_name` should clearly describe the state represented by the snapshot.
*   For different states of the same Widget, multiple Golden snapshots should be taken and given different names.
    *   Examples: `'tree_action_menu'`, `'tree_action_menu_open'`, `'tree_action_menu_sub_open'`

```dart
testWidgetGoldens('Golden test for MyWidget states',
    variants: ValueVariant<Size>(<Size>{const Size(340, 200)}), // Optional: test different sizes
    (WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(340, 200));
  await tester.pumpWidget(buildWidget(state: WidgetState.initial));
  await tester.takeGolden('my_widget_initial_state');

  await tester.tap(find.text('Button'));
  await tester.pumpAndSettle();
  await tester.takeGolden('my_widget_after_button_tap');
});
```

---

## 5. Other Best Practices

*   **Single Responsibility Principle**: Each test case should test only one specific function or behavior.
*   **Independence**: Test cases should not have dependencies on each other; each test should be able to run independently.
*   **Readability**: Test code should be as easy to read and understand as documentation.
*   **Avoid Magic Strings**: For frequently used text or Keys, consider defining them as constants.
*   **Fail Fast**: Tests should fail as early as possible when a problem occurs, rather than discovering it in subsequent steps.

---

Following these guidelines will help us build a robust and easily maintainable test suite, thereby improving project quality and development efficiency.
