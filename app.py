import cv2
import mediapipe as mp
import numpy as np
import torch

# Initialize MediaPipe Hand module.
mp_drawing = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands

# Load the YOLO model
model = torch.hub.load('ultralytics/yolov8', 'custom', path_or_model='best.pt')  # Ensure this matches your file path

cap = cv2.VideoCapture(0)
cv2.namedWindow('Integrated Detection', cv2.WINDOW_NORMAL)
cv2.setWindowProperty('Integrated Detection', cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)

with mp_hands.Hands(min_detection_confidence=0.8, min_tracking_confidence=0.5) as hands:
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break
        
        # Flip frame and convert color for MediaPipe
        image = cv2.cvtColor(cv2.flip(frame, 1), cv2.COLOR_BGR2RGB)
        # Perform hand tracking with MediaPipe
        results = hands.process(image)
        # Convert back to BGR for OpenCV
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        # Draw MediaPipe hand landmarks
        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                mp_drawing.draw_landmarks(image, hand_landmarks, mp_hands.HAND_CONNECTIONS)

        # YOLO detection expects BGR images
        results = model(frame)

        # Render YOLO detections
        results.render()  # This modifies 'frame' in-place to add the bounding box, label, and confidence

        # Since we have already drawn on 'image', let's draw the YOLO detections on 'image' as well
        yolo_detections = np.squeeze(results.render())
        if yolo_detections is not None:
            image = cv2.addWeighted(image, 1, yolo_detections, 1, 0)

        cv2.imshow('Integrated Detection', image)

        if cv2.waitKey(5) & 0xFF == ord('q'):
            break

cap.release()
cv2.destroyAllWindows()
