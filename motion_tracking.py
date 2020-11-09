#!venv/bin/python3
import numpy as np
import cv2 as cv 
import time

# Create window
cv.namedWindow('frame', cv.WINDOW_AUTOSIZE)

# Load video or webcam
cap = cv.VideoCapture('footage/crowded_park.mp4')
framebg = cv.bgsegm.createBackgroundSubtractorMOG(history=100, nmixtures=2, backgroundRatio=0.6, noiseSigma=0)
kernel = cv.getStructuringElement(shape=cv.MORPH_ELLIPSE, ksize=(3,3))

while(cap.isOpened()):
    start = time.time()

    # Capture frame-by-frame
    ret, frame = cap.read()
    if not ret:
        break

    frame = cv.resize(frame, (int(frame.shape[1]*0.3), int(frame.shape[0]*0.3)), interpolation=cv.INTER_AREA)

    # Remove background
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    fgmask = framebg.apply(gray)
    fgmask = cv.morphologyEx(fgmask, 
                             op=cv.MORPH_OPEN, 
                             kernel=kernel)

    # Apply mask to both grayscale and original frames
    gray = cv.bitwise_and(gray, gray, mask=fgmask)
    frame = cv.bitwise_and(frame, frame, mask=fgmask)

    # Initiate STAR detector
    orb = cv.ORB_create()

    # Find keypoints with ORB
    kp = orb.detect(gray, None)

    # Compute descriptors with ORB
    kp, des = orb.compute(gray, kp)

    cv.drawKeypoints(frame, kp, frame, color=(0,255,0), flags=0)
    cv.putText(frame, 
               text='{:3.1f} fps'.format(1/(time.time() - start)), 
               org=(10,30),
               fontFace=cv.FONT_HERSHEY_SIMPLEX,
               fontScale=1.0,
               color=(0,0,255),
               thickness=2)
    cv.imshow('frame', frame)

    # Continue or press q to quit
    if cv.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv.destroyAllWindows()
