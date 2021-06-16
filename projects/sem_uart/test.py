# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 2021

Needs the following dependency:
    pip3 install pyserial
    pip3 install tqdm

@author: zanonera

Injects Frame Error in sem IP core using UART.
The frames for injection where previously generated 
with ACME (http://www.nebrija.es/aries/acme.htm)
"""
import serial
import time
from datetime import datetime
import os
from tqdm import tqdm

def timing(t):
    t_new = time.mktime(time.localtime())
    return t_new - t

# SEM IP Core Connection    
port = '/dev/ttyUSB0'
baudrate = 9600

print('Conecting to SEM IP Core... \n',end='')
sem = serial.Serial(port, baudrate, timeout=3)
print('Connected')

# DUT Checker Connection    
port = '/dev/ttyUSB1'
baudrate = 921600

print('Conecting to DUT Checker... \n',end='')
dut = serial.Serial(port, baudrate, timeout=3)
print('Connected')

#frameRange = open('frameRange.txt')

testReport = open("testReport.txt",mode="w+",encoding="utf-8")

idle = 'I'
observation = 'O'

print('Error Injection will start... \n')

with tqdm(total=os.path.getsize('frameRange.txt')) as pbar:
    with open('frameRange.txt') as frameRange:
        for line in frameRange:
            pbar.update(len(line.encode('utf-8')))
            #for line in frameRange:
            sem.write(idle.encode())
            #print(idle.encode())
            #time.sleep(0.1)
            injection = 'N' + ' ' + str(line)
            #print(injection.encode())
            sem.write(injection.encode())
            sem.write(observation.encode())
            #print(observation.encode())
            #time.sleep(0.1)
            chk = dut.read()
            chks = chk.decode('utf-8')
            result = 'Frame: ' + str(line.rstrip()) + ' | ' + 'DUT Checker: ' + str(chks) + '\n'
            testReport.write(result)    

print('Error Injection ended... \n')

sem.close()
dut.close()
frameRange.close()
testReport.close()
