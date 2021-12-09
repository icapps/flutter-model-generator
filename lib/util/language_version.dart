class LanguageVersion {
  final int major;
  final int minor;
  final int patch;

  LanguageVersion(this.major, this.minor, this.patch);

  bool isAtLeast(int major, [int? minor, int? patch]) {
    return (this.major >= major &&
        (minor == null || this.minor >= minor) &&
        (patch == null || this.patch >= patch));
  }

  @override
  String toString() {
    return '$major.$minor.$patch';
  }
}
