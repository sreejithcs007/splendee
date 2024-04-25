import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String name;
  final Key? formkey;
  final TextEditingController? controller;
  final String? label;
  final String? hinttext;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffix;
  final int? maxline;
  final bool? obsecuringtext;
  final TextInputType? keyboardtype;
  final EdgeInsets? scrollpadding;
  final String? obsecuringcharacter;

  const ReusableTextField(
      {super.key,
        required this.name,
        this.formkey,
        this.controller,
        this.label,
        this.hinttext,
        this.validator,
        this.prefixIcon,
        this.suffix,
        this.maxline,
        this.keyboardtype, this.obsecuringtext, this.scrollpadding, this.obsecuringcharacter});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: Form(
              key: formkey,
              child: TextFormField(
                obscureText: obsecuringtext ?? false ,
                obscuringCharacter: obsecuringcharacter ?? '*',

                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                  // label: Text(label ?? name),
                  hintText: hinttext ?? name,
                  border: OutlineInputBorder(),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffix,
                ),
                //maxLines: maxline,
                keyboardType: keyboardtype,
                scrollPadding: scrollpadding ?? EdgeInsets.zero,
              )),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
