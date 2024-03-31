import cv2
import mediapipe as mp
from math import sqrt
import time
import sqlite3
import numpy as np
# Initialize MediaPipe Hand module.
mp_drawing = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands



cv2.namedWindow('MediaPipe Hands', cv2.WINDOW_NORMAL)
cv2.setWindowProperty('MediaPipe Hands', cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
def calculate_distance(landmark1, landmark2):
    return sqrt((landmark2.x - landmark1.x) ** 2 + (landmark2.y - landmark1.y) ** 2)

# Function to determine the direction of shake.
def determine_shake_direction(prev_pos, current_pos):
    dx = current_pos.x - prev_pos.x
    dy = current_pos.y - prev_pos.y
    
    if abs(dx) > abs(dy):
        return 'horizontal'
    else:
        return 'vertical'
# Start capturing video from the webcam.
cap = cv2.VideoCapture(0)
# Variables to track the click state and count
click = False
click_count = 0
prev_wrist_pos = None
shaking_threshold = 0.05
vertical_shakes = 0
horizontal_shakes = 0
total_shakes = 0
wrist_angle=0
def calculate_angle_with_horizontal(p1, p2):
    """
    Calculate the angle between the line formed by points p1 and p2 and a horizontal line.
    """
    # Vector from p1 to p2 (e.g., wrist to middle finger MCP)
    vector_p1_p2 = np.array([p2.x - p1.x, p2.y - p1.y])
    # Horizontal reference vector (1, 0 in screen coordinates)
    horizontal_vector = np.array([1, 0])
    
    # Calculate the angle using dot product and arccos
    cosine_angle = np.dot(vector_p1_p2, horizontal_vector) / (np.linalg.norm(vector_p1_p2) * np.linalg.norm(horizontal_vector))
    angle = np.arccos(cosine_angle)
    return np.degrees(angle)


def insert_data(vertical_shakes, horizontal_shakes, total_shakes, clicks):
    conn = sqlite3.connect('hand_tracking.db')
    cursor = conn.cursor()
    cursor.execute('''
    INSERT INTO tracking_data (vertical_shakes, horizontal_shakes, total_shakes, clicks)
    VALUES (?, ?, ?, ?)
    ''', (vertical_shakes, horizontal_shakes, total_shakes, clicks))
    conn.commit()
    conn.close()

# For shakes per second calculation
start_time = time.time()
shakes_last_second = 0
with mp_hands.Hands(min_detection_confidence=0.8, min_tracking_confidence=0.5) as hands:
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            print("Ignoring empty camera frame.")
            continue
        
        # Convert the BGR image to RGB, flip the image around y-axis for correct handedness output.
        image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)
        image.flags.writeable = False
        # Perform the hand tracking.
        results = hands.process(image)
        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
        
        # Initialize 'normalized_distance' for each frame to ensure it's always defined.
        normalized_distance = 0

        # Draw the hand annotations on the image.
        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                mp_drawing.draw_landmarks(
                    image, hand_landmarks, mp_hands.HAND_CONNECTIONS,
                    mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                    mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2)
                )

                thumb_tip = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP]
                index_finger_tip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                wrist = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]
                middle_finger_mcp = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_MCP]

                thumb_index_distance = calculate_distance(thumb_tip, index_finger_tip)
                reference_distance = calculate_distance(wrist, middle_finger_mcp)
                normalized_distance = thumb_index_distance / reference_distance if reference_distance else 0
                
                index_mcp = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_MCP]
                
                
                
                middle_mcp = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_MCP]

                # Calculate the angle of the wrist with respect to a horizontal line
                wrist_angle = calculate_angle_with_horizontal(wrist, middle_mcp)

                # Click detection logic
                if normalized_distance < 0.8 and not click:
                    click = True
                elif normalized_distance >= 0.8 and click:
                    click_count += 1
                    click = False

                # Display "Index" or "Thumb" based on the normalized distance
                finger_text = "Index" if normalized_distance > 0.8 else "Thumb"
                cv2.putText(image, finger_text, (10, 190), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)

        
                # Calculate elapsed time
        current_time = time.time()
        elapsed_time = current_time - start_time

        image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)
        image.flags.writeable = False
        results = hands.process(image)
        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                wrist_pos = hand_landmarks.landmark[mp_hands.HandLandmark.WRIST]

                if prev_wrist_pos:
                    distance_moved = calculate_distance(wrist_pos, prev_wrist_pos)
                    if distance_moved > shaking_threshold:
                        shake_direction = determine_shake_direction(prev_wrist_pos, wrist_pos)
                        if shake_direction == 'vertical':
                            vertical_shakes += 1
                        elif shake_direction == 'horizontal':
                            horizontal_shakes += 1
                        total_shakes += 1
                        shakes_last_second += 1

                prev_wrist_pos = wrist_pos

                mp_drawing.draw_landmarks(
                    image, hand_landmarks, mp_hands.HAND_CONNECTIONS,
                    mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                    mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2),
                )

        # Reset the shake counts every second and display shakes per second
        if elapsed_time >= 1.0:
            start_time = current_time
            shakes_last_second = 0

        # Adjusted vertical spacing
        vertical_start = 50  # Starting position for the first label
        vertical_gap = 20    # Reduced gap between labels
        insert_data(vertical_shakes, horizontal_shakes, total_shakes, click_count)
        # Display shake counts and shakes per second with smaller font size and reduced spacing.
        cv2.putText(image, f'Total Shakes: {total_shakes}', (10, vertical_start),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 255), 0, cv2.LINE_AA)
        cv2.putText(image, f'Vertical Shakes:  {vertical_shakes}', (10, vertical_start + vertical_gap * 1),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 0, cv2.LINE_AA)
        cv2.putText(image, f'Horizontal Shakes: {horizontal_shakes}', (10, vertical_start + vertical_gap * 2),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 0, cv2.LINE_AA)
        cv2.putText(image, f'Shakes/Sec: {shakes_last_second}', (10, vertical_start + vertical_gap * 3),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 100, 255), 0, cv2.LINE_AA)
        # Display the current normalized distance and click count
        cv2.putText(image, f'Norm Dist: {normalized_distance:.2f}', (10, vertical_start + vertical_gap * 4),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 0, cv2.LINE_AA)
        cv2.putText(image, f'Clicks: {click_count}', (10, vertical_start + vertical_gap * 5),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 0, cv2.LINE_AA)
        # Display the calculated wrist angle on the image
        cv2.putText(image, f'Wrist Angle: {wrist_angle:.2f}', (10, vertical_start + vertical_gap * 6),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 0, cv2.LINE_AA)

        cv2.imshow('MediaPipe Hands', image)
        

        if cv2.waitKey(5) & 0xFF == ord('q'):
            break


cap.release()
cv2.destroyAllWindows()




