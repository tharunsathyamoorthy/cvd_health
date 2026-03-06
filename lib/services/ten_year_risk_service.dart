class TenYearRiskService {
  static Map<String, dynamic> calculate({
    required int age,
    required int systolicBP,
    required int cholesterol,
    required bool smoker,
    required bool diabetic,
    required bool active,
  }) {
    int score = 0;

    // Age
    if (age > 60) {
      score += 4;
    } else if (age > 45) {
      score += 2;
    }

    // Blood pressure
    if (systolicBP > 140) score += 2;

    // Cholesterol
    if (cholesterol > 240) score += 2;

    // Smoking
    if (smoker) score += 2;

    // Diabetes
    if (diabetic) score += 3;

    // Physical activity
    if (!active) score += 1;

    // Risk classification
    String riskLevel;
    if (score >= 8) {
      riskLevel = "High Risk";
    } else if (score >= 4) {
      riskLevel = "Moderate Risk";
    } else {
      riskLevel = "Low Risk";
    }

    return {
      "risk_level": riskLevel,
      "risk_score": score,
      "model_type": "Rule-based 10-year risk model",
    };
  }
}
