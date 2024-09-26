#! /bin/python3

import subprocess
from time import sleep

# previous text to match with so that no duplicates
prev = subprocess.check_output("xsel -o -b", shell=True, text=True)

while True:
    # current clipboard text
    clip = subprocess.check_output("xsel -o -b", shell=True, text=True)

    if clip == "q":
        break
    elif clip == "n":
        print()
    elif not clip == prev:
        print(clip)
        prev = clip
    sleep(0.5)

