# Python Virtual Environment Commands

## 1. Create a Virtual Environment
```bash
python3 -m venv venv
```

## 2. Activate the Virtual Environment
```bash
source venv/bin/activate
```

## 3. Save Installed Packages to requirements.txt
```bash
pip freeze > requirements.txt
```
## 4. install Packages from requirements.txt
```bash
pip install -r requirements.txt
```
## 5. Deactivate the Virtual Environment
```bash
deactivate
```