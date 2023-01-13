import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int idxFocus = 0;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  FocusNode focusBt = FocusNode();
  bool onValidate = false;

  String? validator(String? value) {
    if (value?.isEmpty ?? true) return "preenchimento obrigatório";
    return null;
  }

  void onChange(String value) {
    onValidate = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectTextField(
                  onChange: onChange,
                  onValidate: onValidate,
                  validate: validator,
                  controller: controller1,
                  hint: "campo 1",
                  initColor: Colors.blue,
                  selectColor: Colors.amber,
                  prefixIcon: Icons.person,
                  focusChange: () => setState(() {})),
              const SizedBox(
                height: 20,
              ),
              SelectTextField(
                  onChange: onChange,
                  onValidate: onValidate,
                  validate: validator,
                  controller: controller2,
                  hint: "campo 2",
                  initColor: Colors.blue,
                  selectColor: Colors.amber,
                  prefixIcon: Icons.person,
                  focusChange: () => setState(() {})),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                focusNode: focusBt,
                onPressed: () {
                  focusBt.requestFocus();
                  onValidate = true;
                  setState(() {});

                  print(controller1.text);
                  print(controller2.text);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ));
  }
}

class SelectTextField extends StatefulWidget {
  const SelectTextField({
    super.key,
    this.hint,
    this.hintColor = Colors.white54,
    required this.initColor,
    required this.selectColor,
    required this.prefixIcon,
    this.textColor = Colors.white,
    required this.focusChange,
    required this.controller,
    required this.validate,
    required this.onValidate,
    required this.onChange,
  });
  final String? hint;
  final Color? hintColor;
  final Color initColor;
  final Color selectColor;
  final IconData prefixIcon;
  final Color? textColor;
  final VoidCallback focusChange;
  final TextEditingController controller;
  final String? Function(String?) validate;
  final bool onValidate;
  final void Function(String) onChange;

  @override
  State<SelectTextField> createState() => _SelectTextFieldState();
}

class _SelectTextFieldState extends State<SelectTextField> {
  String? validateMsg;
  bool onFocus = false;

  @override
  void didUpdateWidget(SelectTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.onValidate) {
      validateMsg = widget.validate(widget.controller.text);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        onFocus = hasFocus;
        if (hasFocus) {
          widget.focusChange();
        }
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400]!,
                      offset: Offset.fromDirection(1.2, 2),
                      blurRadius: 2,
                      spreadRadius: 1)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: widget.onValidate && (validateMsg?.isNotEmpty ?? false)
                    ? Colors.red
                    : onFocus
                        ? widget.selectColor
                        : widget.initColor),
            child: TextField(
              onChanged: widget.onChange,
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: widget.textColor),
              cursorColor: widget.hintColor,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    color: onFocus ? widget.textColor : widget.hintColor,
                  ),
                  hintText: widget.hint,
                  hintStyle: TextStyle(color: widget.hintColor),
                  border: InputBorder.none),
            ),
          ),
          if (widget.onValidate && (validateMsg?.isNotEmpty ?? false))
            const Align(
              alignment: Alignment.center,
              child: Text(
                "campo obrigatório",
                style: TextStyle(color: Colors.red),
              ),
            )
        ],
      ),
    );
  }
}
