@echo off
echo Starting local development server for Farm & Rental Tracker...
echo (Keep this window open while using the tracker)
start "" "http://localhost:8000/index.html"
python -m http.server 8000
