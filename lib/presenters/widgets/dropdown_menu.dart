part of presenters;

class DropdownMenu<T> extends StatelessWidget {

  final T? value;
  final Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final String hintText;

  const DropdownMenu({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        iconColor: AppPallete.grey
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      menuItemStyleData:MenuItemStyleData(
        overlayColor: WidgetStateProperty.all(Colors.grey.shade300),
      ),
      value: value,
      hint: Center(
        child: Text(
          hintText,
          style: TextStyle(
            color: AppPallete.grey500
          ),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}