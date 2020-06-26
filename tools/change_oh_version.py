#/usr/env python2
from __future__ import unicode_literals
from insert_code import *
import sys
import datetime
import oh_settings

OH_SETTINGS_FILE = './oh_settings.py'
MARKER_START     = '# START: OH_VERSION'
MARKER_END       = '# END: OH_VERSION'

def main():

    print (sys.argv[0])
    print (sys.argv[1])

    if (len(sys.argv) != 6 and len(sys.argv) != 5 and len(sys.argv) != 2 and len(sys.argv) != 3):
        print('Arguments: <gem_station> <oh_version> <geb_version> <geb_length> <firmware_version> [<date>]')
        print('e.g.: for GE11: sh update_oh_firmware.sh ge11 v3c v3c short <03.02.04>')
        print('      for GE21: sh update_oh_firmware.sh ge21 <03.02.04>')
        print('The version code is optional.')
        print('If omitted the script will not update the date or version... ')
        print('useful for just switching between hardwares')
        sys.exit(1)
    else:
        print('%d arguments received'%len(sys.argv))

    new_version=False
    gem_version = sys.argv[1].lower()
    geb_version = ""
    geb_length = ""
    oh_version=""
    version=["","",""]
    firmware_year               = 0
    firmware_month              = 0
    firmware_day                = 0
    firmware_version_major      = 0
    firmware_version_minor      = 0
    firmware_release_version    = 0

    if (gem_version=="ge11"):
        print ("Chamber type = GE11")
        oh_version               = sys.argv[1]
        geb_version              = sys.argv[3]
        geb_length               = sys.argv[4]
        if (len(sys.argv)==6):
            print ("Bumping version number...")
            new_version=True
            version = sys.argv[5].split('.')
    elif (gem_version=="ge21"):
        print ("Chamber type = GE21")
        if (len(sys.argv)==3):
            new_version=True
            version = sys.argv[2].split('.')
        oh_version               = sys.argv[1]
        geb_version              = ""
        geb_length               = ""
    else:
        print ("Unknown Chamber type %s" % gem_version)
        return sys.exit(1)

    if (new_version):
        now = datetime.datetime.now()
        firmware_year            = (now.year)
        firmware_month           = (now.month)
        firmware_day             = (now.day)
        firmware_version_major   = int(version[0],16)
        firmware_version_minor   = int(version[1],16)
        firmware_release_version = int(version[2],16)
    else:
        firmware_year            = oh_settings.firmware_year
        firmware_month           = oh_settings.firmware_month
        firmware_day             = oh_settings.firmware_day
        firmware_version_major   = int(oh_settings.firmware_version_major)
        firmware_version_minor   = int(oh_settings.firmware_version_minor)
        firmware_release_version = int(oh_settings.firmware_release_version)

    print(version)
    if (len(version) != 3):
        print ("Problem with OH version in change_oh_version.py")
        sys.exit(1)

    def write_oh_version (file_handle):

        f = file_handle

        f.write ('gem_version = "%s"\n' % (gem_version))

        f.write ('oh_version  = "%s"\n' % (oh_version ))
        f.write ('geb_version = "%s"\n' % (geb_version))
        f.write ('geb_length  = "%s"\n' % (geb_length ))

        f.write ('firmware_version_major   = %d\n' % (firmware_version_major   ))
        f.write ('firmware_version_minor   = %d\n' % (firmware_version_minor   ))
        f.write ('firmware_release_version = %d\n' % (firmware_release_version ))
        f.write ('firmware_year            = %d\n' % (firmware_year ))
        f.write ('firmware_month           = %d\n' % (firmware_month))
        f.write ('firmware_day             = %d\n' % (firmware_day  ))

    insert_code (OH_SETTINGS_FILE, OH_SETTINGS_FILE, MARKER_START, MARKER_END, write_oh_version)

if __name__ == '__main__':
    main()


