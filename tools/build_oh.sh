echo "------------------------------------------------------------------------------------------------------------------------"
echo "BUILDING GE11 V3C SHORT FIRMWARE"
echo "------------------------------------------------------------------------------------------------------------------------"
echo "python change_oh_version.py ge11 v3c v3c short $1"
./genfirmware.bat
echo "sh ./tools/genproms.sh"

echo ""
echo "------------------------------------------------------------------------------------------------------------------------"
echo "BUILDING GE11 V3C LONG FIRMWARE"
echo "------------------------------------------------------------------------------------------------------------------------"
echo "python change_oh_version.py ge11 v3c v3c long  $1"
build_firmware
./genfirmware.bat
echo "sh ./tools/genproms.sh"


echo ""
echo "------------------------------------------------------------------------------------------------------------------------"
echo "BUILDING GE21 FIRMWARE"
echo "------------------------------------------------------------------------------------------------------------------------"
echo "python change_oh_version.py ge11 v3c v3c long  $1"
# need Vivado flow
#./genfirmware.bat
#echo "sh ./tools/genproms.sh"
