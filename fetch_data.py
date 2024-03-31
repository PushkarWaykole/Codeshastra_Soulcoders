from flask import Flask, jsonify
import sqlite3
from flask_cors import CORS
import requests
app = Flask(__name__)
CORS(app)

# Use a different variable name to avoid conflict with the `time` module
global_hits = 0
def telegram_notifier(message = ""):
    TOKEN = '6311706550:AAFXdDvZmvDkIigBfe5aTktu_6jgnCHyXEc'
    CHAT_ID = "819425153"
    url = f"https://api.telegram.org/bot{TOKEN}/sendMessage?chat_id={CHAT_ID}&text={message}"
    res2 = requests.post(url)
    
    
def get_tracking_data():
    """Fetch the latest tracking data from the database."""
    conn = sqlite3.connect('hand_tracking_2.db')
    cursor = conn.cursor()
    cursor.execute('SELECT vertical_shakes, horizontal_shakes, total_shakes, clicks, wrist_angle FROM tracking_data2 ORDER BY timestamp DESC LIMIT 10')
    data = cursor.fetchall()
    conn.close()
    # Convert query result to a list of dictionaries
    columns = ['vertical_shakes', 'horizontal_shakes', 'total_shakes', 'clicks', 'wrist_angle']
    
    result = [dict(zip(columns, row)) for row in data]
    last_record=result[-1]
    if(len(result)>60):
        diff=result[-1]['clicks']-result[0]['clicks']
        if(diff>10):
            telegram_notifier("Emergency alert from Aditya")
        print(last_record)
    
    return result

@app.route('/data', methods=['GET'])
def data():
    global global_hits  # Declare 'global_hits' as global to modify it
    global_hits += 1  # Increment the counter each time the endpoint is hit
    tracking_data = get_tracking_data()
    return jsonify({'tracking_data': tracking_data, 'hits': global_hits})

if __name__ == '__main__':
    app.run(debug=True)
