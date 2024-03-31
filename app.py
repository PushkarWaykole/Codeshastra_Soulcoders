from flask import Flask, Response, render_template
import cv2
import mediapipe as mp
from math import sqrt
import time

app = Flask(__name__)

# Initialize MediaPipe Hand module.
mp_drawing = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands.Hands(min_detection_confidence=0.8, min_tracking_confidence=0.5)

def calculate_distance(landmark1, landmark2):
    return sqrt((landmark2.x - landmark1.x) ** 2 + (landmark2.y - landmark1.y) ** 2)

def determine_shake_direction(prev_pos, current_pos):
    dx = current_pos.x - prev_pos.x
    dy = current_pos.y - prev_pos.y
    return 'horizontal' if abs(dx) > abs(dy) else 'vertical'

def generate_frames():
    cap = cv2.VideoCapture(0)
    prev_wrist_pos = None
    shaking_threshold = 0.05
    vertical_shakes = 0
    horizontal_shakes = 0
    total_shakes = 0
    start_time = time.time()

    while True:
        success, frame = cap.read()
        if not success:
            break
        
        image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)
        results = mp_hands.process(image)
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                mp_drawing.draw_landmarks(
                image, hand_landmarks, mp.solutions.hands.HAND_CONNECTIONS,
                mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2)
            )


                wrist_pos = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]
                if prev_wrist_pos:
                    distance_moved = calculate_distance(wrist_pos, prev_wrist_pos)
                    if distance_moved > shaking_threshold:
                        shake_direction = determine_shake_direction(prev_wrist_pos, wrist_pos)
                        if shake_direction == 'vertical':
                            vertical_shakes += 1
                        else:
                            horizontal_shakes += 1
                        total_shakes += 1

                prev_wrist_pos = wrist_pos

        # Display shake detection information
        cv2.putText(image, f'Vertical Shakes: {vertical_shakes}', (10, 30),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)
        cv2.putText(image, f'Horizontal Shakes: {horizontal_shakes}', (10, 50),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)
        cv2.putText(image, f'Total Shakes: {total_shakes}', (10, 70),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)

        ret, buffer = cv2.imencode('.jpg', image)
        frame = buffer.tobytes()

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True, threaded=True)

if __name__ == '__main__':
    app.run(debug=True)
