from flask import Flask, jsonify
import sqlite3

app = Flask(__name__)

def get_tracking_data():
    """Fetch the latest tracking data from the database."""
    conn = sqlite3.connect('hand_tracking.db')
    cursor = conn.cursor()
    cursor.execute('SELECT vertical_shakes, horizontal_shakes, total_shakes, clicks FROM tracking_data ORDER BY timestamp DESC LIMIT 10')
    data = cursor.fetchall()
    conn.close()
    # Convert query result to a list of dictionaries
    columns = ['vertical_shakes', 'horizontal_shakes', 'total_shakes', 'clicks']
    result = [dict(zip(columns, row)) for row in data]
    return result

@app.route('/data', methods=['GET'])
def data():
    """Route to fetch and return tracking data."""
    tracking_data = get_tracking_data()
    return jsonify(tracking_data)

if __name__ == '__main__':
    app.run(debug=True)
