#/usr/env python2
from __future__ import unicode_literals
import sys
import datetime
import argparse
import oh_settings
import insert_code as ins

OH_SETTINGS_FILE = './oh_settings.py'
MARKER_START     = '# START: OH_VERSION'
MARKER_END       = '# END: OH_VERSION'

def main():

    parser = argparse.ArgumentParser()

    parser.add_argument('-l',
                        '--length',
                        dest='length',
                        help="GEB length for GE1/1 (long or short)")

    parser.add_argument('station',
                        help="GEM station (ge11 or ge21)")

    parser.add_argument('-g',
                        '--generation',
                        dest='generation',
                        help="GEB generation (v3a or v3b or v3c)")

    parser.add_argument('-v',
                        '--version',
                        dest='version',
                        help="Optohybrid firmware version (e.g. 03.02.04)")

    #parser.add_argument('station', help="")

    args = parser.parse_args()

    print(args)
    new_version=False
    gem_version = args.station.lower()
    geb_version = "v3c"
    geb_length = ""
    oh_version="v3c"
    version=["", "", ""]
    firmware_year               = 0
    firmware_month              = 0
    firmware_day                = 0
    firmware_version_major      = 0
    firmware_version_minor      = 0
    firmware_release_version    = 0

    if args.length != None:
        print ("Geb length:")
        geb_length = args.length
        print (geb_length)
    if args.generation != None:
        print ("Geb version:")
        geb_version = args.generation
        print (geb_version)
    if args.version != None:
        print ("Bumping version number...")
        new_version=True
        version = args.version.split('.')

    if gem_version not in ("ge21", "ge11"):
        print("Unknown GEM station %s" % gem_version)
        return sys.exit(1)
    if (gem_version == "ge11" and geb_length == ""):
        print("Please specify a length for the GEB (-l long or -l short)")
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
        print ("Problem with OH version formatting in change_oh_version.py")
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

    ins.insert_code (OH_SETTINGS_FILE, OH_SETTINGS_FILE, MARKER_START, MARKER_END, write_oh_version)

if __name__ == '__main__':
    main()


