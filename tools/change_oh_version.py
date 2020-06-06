#/usr/env python2
from __future__ import unicode_literals
from insert_code import *
import sys
import datetime


OH_SETTINGS_FILE = './oh_settings.py'
MARKER_START     = '# START: OH_VERSION'
MARKER_END       = '# END: OH_VERSION'


def main():

    if (len(sys.argv) < 6):
        print('Arguments: <gem_station> <oh_version> <geb_version> <geb_length> <firmware_version> [<date>]')
        print('e.g.: sh update_oh_firmware.sh ge21 v3c v3c short 03.02.04')
        sys.exit(1)
    else:
        print('%d arguments received'%len(sys.argv))

    gem_version              = sys.argv[1]
    oh_version               = sys.argv[2]
    geb_version              = sys.argv[3]
    geb_length               = sys.argv[4]

    now = datetime.datetime.now()
    #firmware_year            = (now.year)
    #firmware_month           = (now.month)
    #firmware_day             = (now.day)
    firmware_year            = (now.year)
    firmware_month           = (now.month)
    firmware_day             = (now.day)

    if (len(sys.argv)>8):

        date           = sys.argv[6].split('.')
        firmware_year  = int(date[0])
        firmware_month = int(date[1])
        firmware_day   = int(date[2])

    print ("Date:")
    print ("\tyear =%d" % firmware_year)
    print ("\tmonth=%d" % firmware_month)
    print ("\tday  =%d" % firmware_day)


    version = sys.argv[5].split('.')
    if (len(version) != 3):
        print ("Problem with OH version in change_oh_version.py")
        sys.exit(1)

    firmware_version_major   = version[0]
    firmware_version_minor   = version[1]
    firmware_release_version = version[2]

    def write_oh_version (file_handle):

        f = file_handle

        f.write ('gem_version = "%s"\n' % (gem_version))
        f.write ('oh_version  = "%s"\n' % (oh_version ))
        f.write ('geb_version = "%s"\n' % (geb_version))
        f.write ('geb_length  = "%s"\n' % (geb_length ))
        f.write ('firmware_version_major   = "%s"\n' % (firmware_version_major   ))
        f.write ('firmware_version_minor   = "%s"\n' % (firmware_version_minor   ))
        f.write ('firmware_release_version = "%s"\n' % (firmware_release_version ))
        f.write ('firmware_year            = %d\n' % (firmware_year ))
        f.write ('firmware_month           = %d\n' % (firmware_month))
        f.write ('firmware_day             = %d\n' % (firmware_day  ))


    insert_code (OH_SETTINGS_FILE, OH_SETTINGS_FILE, MARKER_START, MARKER_END, write_oh_version)


if __name__ == '__main__':
    main()


