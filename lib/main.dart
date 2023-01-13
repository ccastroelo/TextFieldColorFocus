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

  String? validator(String? value) {
    if (value?.isEmpty ?? true) return "preenchimento obrigatório";
    return null;
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
                controller: controller1,
                hint: "campo 1",
                idx: 1,
                idxFocus: idxFocus,
                initColor: Colors.blue,
                selectColor: Colors.amber,
                prefixIcon: Icons.person,
                onTap: (value) {
                  setState(() {
                    idxFocus = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SelectTextField(
                invalidMsg: "campo obrigatório",
                controller: controller2,
                hint: "campo 2",
                idx: 2,
                idxFocus: idxFocus,
                initColor: Colors.blue,
                selectColor: Colors.amber,
                prefixIcon: Icons.person,
                onTap: (value) {
                  setState(() {
                    idxFocus = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.

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
    required this.idx,
    required this.idxFocus,
    required this.initColor,
    required this.selectColor,
    required this.prefixIcon,
    this.textColor = Colors.white,
    required this.onTap,
    required this.controller,
    this.invalidMsg,
  });
  final String? hint;
  final Color? hintColor;
  final int idx;
  final int idxFocus;
  final Color initColor;
  final Color selectColor;
  final IconData prefixIcon;
  final Color? textColor;
  final ValueSetter onTap;
  final TextEditingController controller;
  final String? invalidMsg;

  @override
  State<SelectTextField> createState() => _SelectTextFieldState();
}

class _SelectTextFieldState extends State<SelectTextField> {
  String? validatorMsg;

  @override
  void didUpdateWidget(SelectTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.idxFocus != widget.idxFocus ||
        oldWidget.invalidMsg != widget.invalidMsg) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              color: widget.invalidMsg != null
                  ? Colors.red
                  : widget.idx == widget.idxFocus
                      ? widget.selectColor
                      : widget.initColor),
          child: TextField(
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            onTap: () {
              widget.onTap(widget.idx);
            },
            style: TextStyle(color: widget.textColor),
            cursorColor: widget.hintColor,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.prefixIcon,
                  color: widget.idx == widget.idxFocus
                      ? widget.textColor
                      : widget.hintColor,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(color: widget.hintColor),
                border: InputBorder.none),
          ),
        ),
        if (widget.invalidMsg?.isNotEmpty ?? false)
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.invalidMsg!,
              style: const TextStyle(color: Colors.red),
            ),
          )
      ],
    );
  }
}
