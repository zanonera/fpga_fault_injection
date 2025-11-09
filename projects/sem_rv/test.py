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

frameRangeFile = 'frameRange.txt'
#frameRangeFile = 'frameRangeError.txt'
#frameRangeFile = 'frameRangeNoError.txt'
#frameRangeFile = 'frameRange4.txt'

testReport = open("testReport.txt",mode="w+",encoding="utf-8")

idle = 'I'
observation = 'O'
reset = "R 00"

print('Error Injection will start... \n')

with tqdm(total=os.path.getsize(frameRangeFile)) as pbar:
    with open(frameRangeFile) as frameRange:
        for line in frameRange:
            #pbar.update(len(line.encode('utf-8')))
            ##for line in frameRange:
            #sem.write(idle.encode())
            ##print(idle.encode())
            ##time.sleep(0.2)
            #injection = 'N' + ' ' + str(line)
            ##print(injection.encode())
            ##time.sleep(0.2)
            #sem.write(injection.encode())
            ##time.sleep(0.2)
            ##sem.write(observation.encode())
            #sem.write(reset.encode())
            ##print(observation.encode())
            #time.sleep(0.2)
            #chk = dut.read()
            #chks = chk.decode('utf-8')
            #result = 'Frame: ' + str(line.rstrip()) + ' | ' + 'DUT Checker: ' + str(chks) + '\n'
            #testReport.write(result) 

            pbar.update(len(line.encode('utf-8')))
            sem.write(idle.encode())
            #print(idle.encode())
            time.sleep(0.1)
            injection = 'N' + ' ' + str(line)
            #print(injection.encode())
            sem.write(injection.encode())
            time.sleep(0.1)
            #print(result_dut.encode())
            #dut.write(result_dut.encode())
            chk = dut.read_until(b'\r')
            chks = chk.decode('utf-8')
            result = 'Frame: ' + str(line.rstrip()) + ' | ' + 'DUT Checker: ' + str(chks.rstrip()) + '\n'
            testReport.write(result)
            sem.write(reset.encode())
            time.sleep(0.1)
            #time.sleep(0.5)
            #print(observation.encode()) 
            sem.write(observation.encode()) 

print('Error Injection ended... \n')

sem.close()
dut.close()
frameRange.close()
testReport.close()

#exec(open("testResult.py").read())

frameCount = 0
with open(frameRangeFile) as frameRange:
    for line in frameRange:
        frameCount+=1

injectCount = 0
nonError = 0
error = 0
empty = 0
addrError = []
with open('testReport.txt') as frameRange:
    for line in frameRange:
        injectCount+=1
        if (line[33] == '0'):
            nonError+=1
        elif (line[33] == '1'):
            error+=1
            addrError.append(line[7:17])
        else:
            empty+=1

print("********** Test Report Statistics **********")
print("Total of Essential bits in pblock: " + str(frameCount))
print("Total of address/bits injected: " + str(injectCount))

print("Injection without error: " + str(nonError))
print("Injection with error: " + str(error))
print("Injection without answer: " + str(empty))
print("List of Address that caused Errors: ")
print(addrError)
