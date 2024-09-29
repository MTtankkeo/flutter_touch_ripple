<div align="center">
    <img src="https://github.com/user-attachments/assets/3656c10c-6911-45bd-b035-ada85263b23a">
    <h1>Flutter Touch Ripple</h1>
    <table>
        <thead>
          <tr>
            <th>Version</th>
            <th>v2.0.0</th>
          </tr>
        </tbody>
    </table>
</div>

# Introduction
This Flutter package allows developer to customize most of the behaviors and animations, with excellent performance and a touch effect package that can be controlled externally.

| Event Type | Description | ♾️ Async | ♻️ Consecutive |
| ---------- | ----------- | ----- | ----------- |
| Tap        | When the user taps or clicks. | 🟢 | 🔴 |
| Double Tap | When the user double taps or double clicks. | 🔴 | 🟢 |
| Long Tap   | When the user long tap or long press. | 🔴 | 🟢 |
| Drag(V, H) | Not support yet. | 🟡 | 🟡 |

## Usage
The following explains the basic usage of this package.

### How to apply the ripple effect?
Called when the user taps or clicks.

```dart
TouchRipple(
  onTap: () => print("Hello, World!"),
  child: ... // <- this your widget
)
```

### How to perform an async task?
```dart
TouchRipple<String>(
    onTapAsync: () async {
        return await Future.delayed(const Duration(milliseconds: 500), () {
            return "end";
        });
    },
    onTapAsyncStart: () => print("start"),
    onTapAsyncEnd: print,
    // ... skip
);
```