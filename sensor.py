#!/usr/bin/python

# Based on Adafruit Example by Tony DiCola
# Leon Wright <techman@cpan.org> - 2015-07-05

sensor = 11
pin = 4

import sys
import Adafruit_DHT

humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)


if humidity is not None and temperature is not None:
	print '{0:0.1f},{1:0.1f}'.format(temperature, humidity)
else:
	print 'Failed'
