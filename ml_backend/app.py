from flask import Flask, request, jsonify
from flask_cors import CORS
import pickle
import pandas as pd

app = Flask(__name__)
CORS(app)

model = pickle.load(open("model.pkl", "rb"))
scaler = pickle.load(open("scaler.pkl", "rb"))
imputer = pickle.load(open("imputer.pkl", "rb"))
best_model_info = pickle.load(open("best_model_info.pkl", "rb"))

@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "CVD Risk Prediction API is running"})

@app.route("/predict", methods=["POST"])
def predict():
    try:
        if not request.is_json:
            return jsonify({"error": "Request must be JSON"}), 400

        data = request.get_json()

        required_fields = [
            "age",
            "gender",
            "systolic_bp",
            "diastolic_bp",
            "cholesterol",
            "glucose",
            "smoking",
            "activity"
        ]

        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing field: {field}"}), 400
       
        input_df = pd.DataFrame([{
            "Age": float(data["age"]),
            "Sex": 1 if data["gender"] == 1 else 0,
            "Systolic BP": float(data["systolic_bp"]),
            "Diastolic BP": float(data["diastolic_bp"]),
            "Total Cholesterol (mg/dL)": float(data["cholesterol"]),
            "Fasting Blood Sugar (mg/dL)": float(data["glucose"]),
            "Smoking Status": 1 if data["smoking"] == 1 else 0,
            "Physical Activity Level": int(data["activity"])
        }])

        X_imputed = imputer.transform(input_df)
        X_scaled = scaler.transform(X_imputed)

        probability = model.predict_proba(X_scaled)[0][1]
        prediction = "High Risk" if probability >= 0.5 else "Low Risk"

        return jsonify({
            "prediction": prediction,
            "risk_probability": round(probability * 100, 2),
            "model_accuracy": round(best_model_info["accuracy"] * 100, 2),
            "best_model": best_model_info["model_name"]
        })

    except Exception as e:
        print("PREDICTION ERROR:", e)
        return jsonify({
            "error": "Prediction failed",
            "details": str(e)
        }), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
