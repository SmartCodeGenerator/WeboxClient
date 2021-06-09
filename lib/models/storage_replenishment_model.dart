class StorageReplenishmentModel {
  int laptopsAmount;

  StorageReplenishmentModel(this.laptopsAmount);

  Map<String, dynamic> toJson() {
    return {
      'laptopsAmount': laptopsAmount,
    };
  }
}
