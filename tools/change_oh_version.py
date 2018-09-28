from insert_code import *
import sys

OH_SETTINGS_FILE = './oh_settings.py'
MARKER_START     = '# START: OH_VERSION'
MARKER_END       = '# END: OH_VERSION'


def main():

    if (len(sys.argv) < 6):
        print('Arguments: <gem_station> <oh_version> <geb_version> <geb_length> <firmware_version>')
        sys.exit(1)

    def write_oh_version (file_handle):

        f = file_handle

        f.write ('gem_version = "%s"\n' % (gem_version))
        f.write ('oh_version  = "%s"\n' % (oh_version ))
        f.write ('geb_version = "%s"\n' % (geb_version))
        f.write ('geb_length  = "%s"\n' % (geb_length ))
        f.write ('firmware_version_major   = "%s"\n' % (firmware_version_major   ))
        f.write ('firmware_version_minor   = "%s"\n' % (firmware_version_minor   ))
        f.write ('firmware_release_version = "%s"\n' % (firmware_release_version ))

    gem_version              = sys.argv[1]
    oh_version               = sys.argv[2]
    geb_version              = sys.argv[3]
    geb_length               = sys.argv[4]

    version = sys.argv[5].split('.')
    if (len(version) != 3):
        print ("Problem with OH version in change_oh_version.py")
        sys.exit(1)

    firmware_version_major   = version[0]
    firmware_version_minor   = version[1]
    firmware_release_version = version[2]

    insert_code (OH_SETTINGS_FILE, OH_SETTINGS_FILE, MARKER_START, MARKER_END, write_oh_version)


if __name__ == '__main__':
    main()

