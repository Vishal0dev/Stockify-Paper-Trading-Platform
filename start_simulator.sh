#!/bin/bash
echo "Starting Stock Market Simulator..."

echo "1. Starting Node.js Backend..."
cd backend
npm install
node server.js &
NODE_PID=$!
cd ..

echo "2. Starting Python yfinance Microservice..."
cd data-service
source venv/bin/activate
python app.py &
PYTHON_PID=$!
cd ..

echo "3. Starting React Frontend..."
npm run dev &
VITE_PID=$!

echo "Services started!"
echo "Node API: http://localhost:5001"
echo "Frontend: http://localhost:5173"

# Keep the script running
wait $NODE_PID $PYTHON_PID $VITE_PID
