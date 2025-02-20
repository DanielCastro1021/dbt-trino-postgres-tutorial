#!/bin/bash

echo "Creating Python virtual environment..."
# Create the Python virtual environment
python3 -m venv dbt_env
source dbt_env/bin/activate

echo "Upgrading pip..."
# Upgrade pip
python -m pip install --upgrade pip

echo "Installing requirements from requirements.txt..."
# Install requirements from requirements.txt
pip install -r requirements.txt

echo "Changing to the jaffle_shop directory..."
# Change to the jaffle_shop directory
cd jaffle_shop

echo "Running dbt debug..."
# Run dbt debug
dbt debug
if [ $? -ne 0 ]; then
    echo "dbt debug failed. Exiting script."
    exit 1
fi

echo "Running dbt run..."
# Run dbt run
dbt run
if [ $? -ne 0 ]; then
    echo "dbt run failed. Exiting script."
    exit 1
fi

echo "Running dbt test..."
# Run dbt test
dbt test
if [ $? -ne 0 ]; then
    echo "dbt test failed. Exiting script."
    exit 1
fi

echo "All dbt commands completed successfully."
