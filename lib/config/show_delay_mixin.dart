// Gecikme işlemlerini yöneten sınıf
class DelayHelper {
  DelayHelper({
    this.initialDelay = 300,
    this.differenceBetweenDelays = 100,
  });
  
  int initialDelay, differenceBetweenDelays;
  int order = 0;

  // Gecikme süresini hesaplayan metod
  Duration getDelayDuration() {
    return Duration(
      milliseconds: initialDelay + (differenceBetweenDelays * order++),
    );
  }
}

// Gecikme işlemlerini yöneten mixin
mixin DelayHelperMixin {
  final int initialDelay = 300, differenceBetweenDelays = 100;
  int order = 0;

  // Gecikme süresini hesaplayan metod
  Duration getDelayDuration() {
    order++;
    return Duration(
      milliseconds: initialDelay + (differenceBetweenDelays * order),
    );
  }
}
