part of typography;

class MonospaceTypography {
  AppTypographyFamilyPreset get regular => .new(
    fontName: 'Monospace',
    fontWeight: .w400
  );

  AppTypographyFamilyPreset get medium => .new(
    fontName: 'Monospace',
    fontWeight: .w500
  );

  AppTypographyFamilyPreset get bold => .new(
    fontName: 'Monospace',
    fontWeight: .w700
  );
}