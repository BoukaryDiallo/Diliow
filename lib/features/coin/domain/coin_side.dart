enum CoinSide { heads, tails }

extension CoinSideX on CoinSide {
  String label(String headsLabel, String tailsLabel) {
    switch (this) {
      case CoinSide.heads:
        return headsLabel;
      case CoinSide.tails:
        return tailsLabel;
    }
  }

  String get letter => this == CoinSide.heads ? 'H' : 'T';
}
