HUGGING_FACE_SPACE = "Drug-Classification-MLOps"

install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

format:	
	black *.py 

train:
	python train.py

eval:
	echo "## Model Metrics" > report.md
	cat ./Results/metrics.txt >> report.md
	
	echo '\n## Confusion Matrix Plot' >> report.md
	echo '![Confusion Matrix](./Results/model_results.png)' >> report.md
	
	cml comment create report.md
		
update-branch:
	git config --global user.name $(USER_NAME)
	git config --global user.email $(USER_EMAIL)
	git add .
	git commit -m "Update with new results"
	git push --force origin HEAD:update

hf-login:
	git config --global credential.helper store
	git pull origin update
	git switch update
	pip install -U "huggingface_hub[cli]"
	huggingface-cli login --token $(HUGGINGFACE_KEY) --add-to-git-credential

push-hub:
	huggingface-cli upload $(HUGGING_FACE_SPACE) ./App --repo-type=space --commit-message="Sync App files"
	huggingface-cli upload $(HUGGING_FACE_SPACE) ./Model /Model --repo-type=space --commit-message="Sync Model"
	huggingface-cli upload $(HUGGING_FACE_SPACE) ./Results /Metrics --repo-type=space --commit-message="Sync Model"

deploy: hf-login push-hub