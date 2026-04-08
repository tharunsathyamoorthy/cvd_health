import pandas as pd
import pickle

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer
from sklearn.metrics import accuracy_score, f1_score, roc_auc_score

from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier

print("\nCARDIOVASCULAR DISEASE RISK PREDICTION")
print("=" * 55)

df = pd.read_csv("cardio_train.csv")

string_cols = ["Sex", "Smoking Status", "Physical Activity Level", "CVD Risk Level"]

for col in string_cols:
    df[col] = df[col].astype(str).str.strip().str.lower()

df["Smoking Status"] = df["Smoking Status"].replace(["nan", "none"], "no")
df["Physical Activity Level"] = df["Physical Activity Level"].replace(["nan", "none"], "medium")

df["Sex"] = df["Sex"].map({"m": 1, "f": 0})
df["Smoking Status"] = df["Smoking Status"].map({"yes": 1, "no": 0})
df["Physical Activity Level"] = df["Physical Activity Level"].map({
    "low": 0,
    "medium": 1,
    "high": 2
})

df["CVD Risk Level"] = df["CVD Risk Level"].map({
    "low": 0,
    "low risk": 0,
    "moderate": 0,
    "medium": 0,
    "medium risk": 0,
    "high": 1,
    "high risk": 1,
    "very high": 1,
    "very high risk": 1
})


feature_cols = [
    "Age",
    "Sex",
    "Systolic BP",
    "Diastolic BP",
    "Total Cholesterol (mg/dL)",
    "Fasting Blood Sugar (mg/dL)",
    "Smoking Status",
    "Physical Activity Level"
]

X = df[feature_cols]
y = df["CVD Risk Level"]

mask = y.notna()
X = X[mask]
y = y[mask]

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)


models = {
    "Logistic Regression": LogisticRegression(max_iter=1000),
    "Support Vector Machine": SVC(probability=True),
    "Random Forest": RandomForestClassifier(n_estimators=100, random_state=42),
    "Decision Tree": DecisionTreeClassifier(random_state=42),
    "K-Nearest Neighbor": KNeighborsClassifier(n_neighbors=5)
}

results = []

best_model = None
best_model_name = None
best_accuracy = 0
best_f1 = 0
best_auc = 0


for name, clf in models.items():

    pipe = Pipeline([
        ("imputer", SimpleImputer(strategy="median")),
        ("scaler", StandardScaler()),
        ("clf", clf)
    ])

    pipe.fit(X_train, y_train)

    y_pred = pipe.predict(X_test)
    y_prob = pipe.predict_proba(X_test)[:, 1]

    acc = accuracy_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)
    auc = roc_auc_score(y_test, y_prob)

    results.append({
        "Model": name,
        "Accuracy": round(acc, 4),
        "F1 Score": round(f1, 4),
        "AUC": round(auc, 4)
    })

    if acc > best_accuracy:
        best_model = pipe
        best_model_name = name
        best_accuracy = acc
        best_f1 = f1
        best_auc = auc


results_df = pd.DataFrame(results)

print("\nModel Performance Table\n")
print(results_df)


with open("model.pkl", "wb") as f:
    pickle.dump(best_model.named_steps["clf"], f)

with open("scaler.pkl", "wb") as f:
    pickle.dump(best_model.named_steps["scaler"], f)

with open("imputer.pkl", "wb") as f:
    pickle.dump(best_model.named_steps["imputer"], f)

best_model_info = {
    "model_name": best_model_name,
    "accuracy": float(best_accuracy),
    "f1_score": float(best_f1),
    "auc": float(best_auc)
}

with open("best_model_info.pkl", "wb") as f:
    pickle.dump(best_model_info, f)

print("\nBest Model Selected:", best_model_name)
print("Accuracy:", round(best_accuracy, 4))