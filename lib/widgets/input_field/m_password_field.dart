import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:book_store_apps/widgets/input_field/m_text_field.dart';
import 'package:flutter/material.dart';

class MPasswordField extends StatefulWidget {
  const MPasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.placeHolderText,
    this.isRequired = false,
    this.helperText,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.errorText,
    this.prefixIcon,
    this.enabled,
    this.onChanged,
    this.onSubmitted,
    this.autoFocus = false,
    this.onTap,
  });

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool? enabled;

  final bool autoFocus;

  /// The label to display.
  ///
  /// If null, this widget will not show.
  final String? labelText;

  /// The placeh holder to display.
  ///
  /// If null, this widget will not show.
  final String? placeHolderText;

  /// {@macro flutter.widgets.editableText.isRequired}
  final bool isRequired;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// The helper text to display.
  ///
  /// If null, this widget will not show.
  final String? helperText;

  /// The error text to display.
  ///
  /// If null, this widget will not show.
  final String? errorText;

  /// The prefix icon to display.
  ///
  /// If null, this widget will not show.
  final Widget? prefixIcon;

  /// To listen to arbitrary pointer events without competing with the
  /// text field's internal gesture detector, use a [Listener].
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  @override
  State<MPasswordField> createState() => _MPasswordFieldState();
}

class _MPasswordFieldState extends State<MPasswordField> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return MTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      labelText: widget.labelText,
      placeHolderText: widget.placeHolderText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      isRequired: widget.isRequired,
      obscureText: !visibility,
      enableSuggestions: false,
      enabled: widget.enabled,
      scrollPadding: widget.scrollPadding,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      autofocus: widget.autoFocus,
      onTap: widget.onTap,
      suffixIcon: IconButton(
        icon: visibility
            ? const MIcon(Icons.remove_red_eye_outlined, color: MColors.p3)
            : const MIcon(Icons.remove_red_eye, color: MColors.n2),
        highlightColor: Colors.transparent,
        onPressed: () {
          setState(() {
            visibility = !visibility;
          });
        },
      ),
    );
  }
}
