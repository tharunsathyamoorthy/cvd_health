import pandas as pd
import pickle
import numpy as np

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

print("\n CARDIOVASCULAR DISEASE RISK PREDICTION ")
print("=" * 55)

df = pd.read_csv("cardio_train.csv")

string_cols = [
    "Sex",
    "Smoking Status",
    "Physical Activity Level",
    "CVD Risk Level"
]

for col in string_cols:
    df[col] = df[col].astype(str).str.strip().str.lower()

df["Sex"] = df["Sex"].map({"m": 1, "f": 0})
df["Smoking Status"] = df["Smoking Status"].map({"yes": 1, "no": 0})
df["Physical Activity Level"] = df["Physical Activity Level"].map({
    "low": 0, "medium": 1, "high": 2
})

df["CVD Risk Level"] = df["CVD Risk Level"].map({
    "low": 0, "low risk": 0, "moderate": 0,
    "medium": 0, "medium risk": 0,
    "high": 1, "high risk": 1,
    "very high": 1, "very high risk": 1
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

X = df[feature_cols].apply(pd.to_numeric, errors="coerce")
y = pd.to_numeric(df["CVD Risk Level"], errors="coerce")

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

best_model = None
best_model_name = None
best_f1 = 0
best_accuracy = 0
best_auc = 0

for name, clf in models.items():
    print(f"\nTraining {name}...")

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

    print(" Accuracy:", acc)
    print(" F1:", f1)
    print(" AUC:", auc)

    if f1 > best_f1:
        best_model = pipe
        best_model_name = name
        best_f1 = f1
        best_accuracy = acc
        best_auc = auc

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

print("\n ✅ Best Model Selected:", best_model_name)
