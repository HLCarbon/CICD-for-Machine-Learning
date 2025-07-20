# Drug Classification MLOps Project

## Overview
This project demonstrates a complete MLOps workflow for a drug classification model. The goal is to predict the type of drug suitable for a patient based on their features using a machine learning pipeline, and to automate the process of training, evaluation, and deployment using CI/CD.

## Technologies Used

- **scikit-learn**: Used for building the machine learning pipeline, including preprocessing and model training (RandomForestClassifier).
- **skops**: For serializing and deserializing the scikit-learn pipeline in a secure and portable way.
- **Gradio**: Provides a user-friendly web interface for model inference, allowing users to interact with the trained model.
- **pandas**: For data manipulation and loading the dataset.
- **matplotlib**: For generating evaluation plots (e.g., confusion matrix).
- **black**: For code formatting to ensure code quality and consistency.

## Project Structure

- `App/app.py`: Gradio app for serving the trained model.
- `train.py`: Script for training the model, evaluating it, saving metrics and plots, and serializing the pipeline.
- `Data/drug200.csv`: Dataset used for training and evaluation.
- `Model/drug_pipeline.skops`: Serialized machine learning pipeline.
- `Results/metrics.txt` and `Results/model_results.png`: Evaluation results and plots.
- `requirements.txt` and `App/requirements.txt`: Python dependencies for development and deployment.
- `Makefile`: Automation of common tasks (install, format, train, eval, deploy, etc.).

## CI/CD Pipeline

The project uses **GitHub Actions** for Continuous Integration (CI) and Continuous Deployment (CD):

### Continuous Integration (`.github/workflows/ci.yml`)
- **Triggers**: On push or pull request to the `main` branch, or manually.
- **Steps**:
  1. Checkout the code.
  2. Set up CML (Continuous Machine Learning) for reporting.
  3. Install dependencies using `make install`.
  4. Format code with `make format`.
  5. Train the model with `make train`.
  6. Evaluate the model and generate a report with `make eval`.
  7. Update the branch with new results using `make update-branch` (commits and pushes evaluation results).

### Continuous Deployment (`.github/workflows/cd.yml`)
- **Triggers**: When the CI workflow completes successfully, or manually.
- **Steps**:
  1. Checkout the code.
  2. Deploy the app and model to Hugging Face Spaces using `make deploy`, which:
     - Logs in to Hugging Face using a secret token.
     - Uploads the app, model, and results to the specified Hugging Face Space.

## Deployment

The application is deployed to [Hugging Face Spaces](https://huggingface.co/spaces), making it accessible via a web interface for real-time predictions.

## How to Run Locally

1. Install dependencies:
   ```sh
   pip install -r requirements.txt
   pip install -r App/requirements.txt
   ```
2. Train the model:
   ```sh
   make train
   ```
3. Run the Gradio app:
   ```sh
   python App/app.py
   ```

## Automation with Makefile
Common tasks are automated using the `Makefile` for convenience and reproducibility:
- `make install` – Install dependencies
- `make format` – Format code
- `make train` – Train the model
- `make eval` – Evaluate and report
- `make update-branch` – Commit and push results
- `make deploy` – Deploy to Hugging Face Spaces

## Summary
This project is a practical example of MLOps, combining machine learning, reproducible pipelines, automated testing, and cloud deployment. The CI/CD setup ensures that every code change is automatically tested, evaluated, and, if successful, deployed to production. 