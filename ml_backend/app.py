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



chat_data = pd.read_csv("cardio_qa_dataset_520.csv")


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


        age = max(0, float(data["age"]))
        gender = 1 if int(data["gender"]) == 1 else 0

        systolic_bp = max(0, float(data["systolic_bp"]))
        diastolic_bp = max(0, float(data["diastolic_bp"]))

        cholesterol = max(0, float(data["cholesterol"]))
        glucose = max(0, float(data["glucose"]))

        smoking = 1 if int(data["smoking"]) == 1 else 0
        activity = int(data["activity"])

        if activity not in [0, 1, 2]:
            activity = 1


        input_df = pd.DataFrame([{
            "Age": age,
            "Sex": gender,
            "Systolic BP": systolic_bp,
            "Diastolic BP": diastolic_bp,
            "Total Cholesterol (mg/dL)": cholesterol,
            "Fasting Blood Sugar (mg/dL)": glucose,
            "Smoking Status": smoking,
            "Physical Activity Level": activity
        }])

        input_df = input_df[[
            "Age",
            "Sex",
            "Systolic BP",
            "Diastolic BP",
            "Total Cholesterol (mg/dL)",
            "Fasting Blood Sugar (mg/dL)",
            "Smoking Status",
            "Physical Activity Level"
        ]]



        X_imputed = imputer.transform(input_df)
        X_scaled = scaler.transform(X_imputed)



        prediction_class = model.predict(X_scaled)[0]
        probability = model.predict_proba(X_scaled)[0][1]

        risk_percent = probability * 100

        if prediction_class == 0:
            prediction = "Less Risk"
        elif risk_percent >= 70:
            prediction = "High Risk"
        else:
            prediction = "Some Chance"


        return jsonify({
            "prediction": prediction,
            "risk_probability": round(risk_percent, 2),
            "model_accuracy": round(best_model_info["accuracy"] * 100, 2),
            "best_model": best_model_info["model_name"]
        })


    except Exception as e:

        print("PREDICTION ERROR:", e)

        return jsonify({
            "error": "Prediction failed",
            "details": str(e)
        }), 500


@app.route("/chat", methods=["POST"])
def chat():

    try:

        data = request.get_json()

        if not data or "message" not in data:
            return jsonify({"reply": "Please send a valid message."})

        user_message = data["message"].lower()


        for i, row in chat_data.iterrows():

            question = str(row["question"]).lower()

            if user_message in question or question in user_message:

                return jsonify({
                    "reply": row["answer"]
                })


        return jsonify({
            "reply": "Sorry, I can only answer cardiovascular related questions."
        })


    except Exception as e:

        print("CHATBOT ERROR:", e)

        return jsonify({
            "reply": "Chatbot server error"
        })



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)