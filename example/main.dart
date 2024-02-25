import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(child: CalculatorPage())),
    );
  }
}

class CalculatorStyles {
  static const double headerPadding = 50;
  static const double innerPadding = 5;
  static const Color titleColor = Colors.white;
  static const Color subColor = Color.fromRGBO(225, 225, 225, 1);
  static const Color descriptionColor = Color.fromRGBO(160, 160, 160, 1);
  static const Color foregroundColor = Color.fromRGBO(16, 16, 16, 1);
  static const Color foregroundColor2 = Color.fromRGBO(32, 32, 32, 1);
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final header = Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(
            vertical: CalculatorStyles.headerPadding,
            horizontal: CalculatorStyles.headerPadding / 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TouchRipple(
                onTap: () {},
                rippleColor: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(10),
                behavior: const TouchRippleBehavior(
                  fadeInDuration: Duration(milliseconds: 250),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(CalculatorStyles.innerPadding),
                  child: Text(
                    '0.01',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: CalculatorStyles.titleColor,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ),
              const Text(
                '10 * (0.5 + 0.01) = ',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: CalculatorStyles.descriptionColor,
                  fontFamily: 'Pretendard',
                ),
              ),
            ],
          ),
        );
        final content = Padding(
          padding: const EdgeInsets.all(CalculatorStyles.innerPadding),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            value: 'MC',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'MR',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'M+',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'M-',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'MS',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'M↓',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '( / )',
                            foregroundColor: Colors.transparent,
                            fontColor: CalculatorStyles.descriptionColor,
                            fontSize: 16,
                            onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: CalculatorButton(value: '%', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(value: 'CE', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(value: 'Init', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: 'Cancel',
                            hoverColor: Colors.red.withAlpha(25),
                            onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(value: '¹⁄ₓ', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(value: 'x²', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(value: '√(2x)', onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(child: CalculatorButton(value: '/', onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            value: '7',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '8',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '9',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(child: CalculatorButton(value: 'X', onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            value: '4',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '5',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '6',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(child: CalculatorButton(value: 'ㅡ', onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            value: '1',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '2',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '3',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(child: CalculatorButton(value: '+', onTap: () {})),
                  ],
                ),
              ),
              const SizedBox(height: CalculatorStyles.innerPadding),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CalculatorButton(
                            value: '-/+',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '0',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '.',
                            foregroundColor: CalculatorStyles.foregroundColor2,
                            onTap: () {})),
                    const SizedBox(width: CalculatorStyles.innerPadding),
                    Expanded(
                        child: CalculatorButton(
                            value: '=',
                            foregroundColor:
                                const Color.fromRGBO(0, 150, 255, 1),
                            onTap: () {})),
                  ],
                ),
              ),
            ],
          ),
        );

        const maxHeight = 750.0;
        if (constraints.maxHeight >= maxHeight) {
          return Column(
            children: [
              Expanded(child: header),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: maxHeight - 190,
                ),
                child: content,
              ),
            ],
          );
        }

        return Column(
          children: [header, Expanded(child: content)],
        );
      },
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.value,
    this.onTap,
    this.foregroundColor,
    this.hoverColor,
    this.fontColor,
    this.fontSize = 18,
  });

  final String value;
  final VoidCallback? onTap;
  final Color? fontColor;
  final Color? foregroundColor;
  final Color? hoverColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);

    return TouchRipple(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
        print('on tapped');
      },
      rippleColor: Colors.white.withAlpha(50),
      hoverColor: hoverColor,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: foregroundColor ?? CalculatorStyles.foregroundColor,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor ?? CalculatorStyles.subColor,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
    );
  }
}
