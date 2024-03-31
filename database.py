import sqlite3

# Connect to SQLite database (or create if it doesn't exist)
conn = sqlite3.connect('hand_tracking.db')
cursor = conn.cursor()

# Create a table to store the counts
cursor.execute('''
CREATE TABLE IF NOT EXISTS tracking_data (
    id INTEGER PRIMARY KEY,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    vertical_shakes INTEGER,
    horizontal_shakes INTEGER,
    total_shakes INTEGER,
    clicks INTEGER
)
''')

conn.commit()
conn.close()
