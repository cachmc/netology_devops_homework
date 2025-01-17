#!/usr/bin/env python3

from datetime import datetime
import random
import time

message = [
    {"DEBUG": "Follow your heart"},
    {"INFO": "Knowledge is power"},
    {"WARNING": "То be or not to be"},
    {"ERROR": "Never look back"},
    {"CRITICAL": "Let your fears go"},
]

while True:

    num = random.randrange(0, 4)

    for key, value in message[num].items():
        print("{0} {1} {2}".format(datetime.now(), key, value))

    time.sleep(3)