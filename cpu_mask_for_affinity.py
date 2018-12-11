#!/usr/bin/env python3
import sys

def cpu_range_split(s):
    """ str -> list

    Transform range of CPU like 9-12 to the list of integers
    >>>cpu_range_split("0-4")
    [0,1,2,3,4]
    >>>cpu_range_split("9-19")
    [9,10,11,12,13,14,15,16,17,8,19]
    >>>cpu_range_split("10")
    [10]
    """
    cpus=[]
    
    if "-" not in s:
        cpus.append(int(s))
    else:                    
        r=s.split('-')
        l=int(r[0])
        h=int(r[1])
        for x in range(l,h+1):
            cpus.append(x)

    return cpus


def str_to_cpus(s):
    """ 
    >>>str_to_cpus("1,10")
    [1,10]
    >>>str_to_cpus("1,10,15-16,30-34,19")
    [1, 10, 15, 16, 19, 30, 31, 32, 33, 34]
    """
    t=s.split(',')
    cpus=[]
    for e in t:
        for i in cpu_range_split(e):
            if i not  in cpus:
                cpus.append(i)
    cpus.sort()

    return cpus
    
def cpu_to_oct(i):
    """ int -> hex

    Convert decimal integer to corresponding hex value of CPU
    """
    d={0:0x1,1:0x2,2:0x4,3:0x8}
    l=(d[i%4])<<(4*(i//4))

    return l

def convert_cpus_to_hex(s):
    n=0
    for C in str_to_cpus(s):
        n = n | cpu_to_oct(C)

    a = "%x" % n
    print("%s" % a)

if len(sys.argv) > 1:
    s=str(sys.argv[1])
else:
    s=input("Enter list of CPUs: ")

convert_cpus_to_hex(s)

