#!venv/bin/python3
import serial
import re
import time
import math

gps_regex = r'^GPGGA,(?P<gmt_h>[0-2][0-9])(?P<gmt_m>[0-5][0-9])(?P<gmt_s>[0-5][0-9](\.\d*)*),(?P<lat_deg>\d*)(?P<lat_dmin>\d{2}\.\d*),(?P<lat_hemi>[NS])*,(?P<long_deg>\d*)(?P<long_dmin>\d{2}\.\d*),(?P<long_hemi>[EW])*,(?P<fix>[012]),(?P<num_sats>\d*),(?P<horz_prec>\d*\.\d*)*,(?P<alti>\d*\.\d*)*,(?P<alti_unit>M)*,(?P<geoidal_sep>-{0,1}\d*\.\d*)*,(?P<geoidal_sep_unit>M)*,(?P<age>\d*\.\d*)*,(?P<station_id>\d*)$'

#port = '/dev/ptyp0'
#ser = serial.Serial(port)
#print(ser.name)


def cvt_dmin_to_degrees(dmin):
    degrees = dmin/60
    return degrees


def cvt_dmin_to_ms(dmin):
    """Convert decimal minutes to minutes and seconds"""
    minutes = math.floor(dmin)
    seconds = (dmin - minutes)*60

    return minutes, seconds


def compute_checksum(sentence):
    """Compute checksum of NMEA sentence"""
    sum = 0
    for c in sentence:
        sum = sum ^ ord(c)
    
    return sum


if __name__ == '__main__':
    with open('fake_gps_data.txt', 'r') as f:
        while True:
            line = f.readline().lstrip('$').rstrip('\r\n')
            split = line.split('*')
            checksum = int(split[-1], 16)
            sentence = split[0]

            if not checksum == compute_checksum(sentence):
                print(f'Checksum failed for sentence:\n{sentence}\n')

            if match := re.match(gps_regex, sentence):
                print(sentence)

                gmt_h = int(match.group('gmt_h'))
                gmt_m = int(match.group('gmt_m'))
                gmt_s = int(match.group('gmt_s'))
                print(f'Time: {gmt_h:02}:{gmt_m:02}:{gmt_s:02}')

                lat_deg = int(match.group('lat_deg'))
                lat_dmin = float(match.group('lat_dmin'))
                lat_hemi = match.group('lat_hemi')
                lat_min, lat_sec = cvt_dmin_to_ms(lat_dmin)
                print(f'Latitude: {lat_deg}\u00b0{lat_min}\'{lat_sec:0.3}" {lat_hemi} = {lat_deg+cvt_dmin_to_degrees(lat_dmin):0.6}\u00b0 {lat_hemi}')

                long_deg = int(match.group('long_deg'))
                long_dmin = float(match.group('long_dmin'))
                long_hemi = match.group('long_hemi')
                long_min, long_sec = cvt_dmin_to_ms(long_dmin)
                print(f'Longitude: {long_deg}\u00b0{long_min}\'{long_sec:0.3}" {long_hemi} = {long_deg+cvt_dmin_to_degrees(long_dmin):0.6}\u00b0 {long_hemi}')

                fix = int(match.group('fix'))
                status = 'GPS Fix' if fix else 'No GPS Fix'
                print(f'Status: {status}') 

                num_sats = int(match.group('num_sats'))
                print(f'# Sats: {num_sats}')

                horz_prec = float(match.group('horz_prec'))
                print(f'Horiz. error: {horz_prec}%')

                altitude = float(match.group('alti'))
                alti_unit = match.group('alti_unit').lower()
                print(f'Altitude: {altitude} {alti_unit}')

                print('\n')

            time.sleep(1)
