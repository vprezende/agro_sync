part of presenters;

void errorSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: .center,
        style: AppTypography
          .roboto
          .medium
          .base
          .color
          .white
          .value
      ),
      backgroundColor: AppPallete.redAccent,
      duration: const Duration(seconds: 3),
    )
  );
}

void warningSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: .center,
        style: AppTypography
          .roboto
          .medium
          .base
          .color
          .white
          .value
      ),
      backgroundColor: AppPallete.orange,
      duration: const Duration(seconds: 3),
    ),
  );
}