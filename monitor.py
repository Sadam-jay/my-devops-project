import requests

try:
    response = requests.get('http://localhost:3000/health')
    if response.status_code == 200:
        print("✅ App is healthy!")
    else:
        print("❌ App is throwing errors!")
except:
    print("🚨 App is down!")