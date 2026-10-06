/// What a floor element represents.
enum ElementKind { table, structure }

/// Table footprint.
enum TableShape {
  round('Round'),
  rectangle('Rectangle'),
  square('Square');

  const TableShape(this.label);
  final String label;
}

/// Non-seating structures used to describe the restaurant layout.
enum StructureType {
  kitchen('Kitchen', 220, 160),
  bar('Bar counter', 240, 70),
  register('Register', 120, 70),
  hostStand('Host stand', 96, 60),
  entrance('Entrance', 130, 24),
  restroom('Restroom', 120, 100),
  stage('Stage', 260, 140),
  buffet('Buffet', 220, 70),
  storage('Storage', 140, 100),
  stairs('Stairs', 110, 120),
  wall('Wall', 260, 12),
  window('Window', 200, 10),
  pillar('Pillar', 40, 40),
  plant('Plant', 48, 48),
  zone('Zone / Area', 320, 220);

  const StructureType(this.label, this.defaultWidth, this.defaultHeight);

  final String label;
  final double defaultWidth;
  final double defaultHeight;

  /// Thin elements (walls / windows) keep a fixed thickness while resizing.
  bool get isLinear => this == StructureType.wall || this == StructureType.window;

  /// Zones are painted behind everything else.
  bool get isBackground => this == StructureType.zone;

  bool get isRound => this == StructureType.plant || this == StructureType.pillar;
}
