
build_firmware () {
    echo 'xst -intstyle ise -ifn "../prj/optohybrid_top.xst" -ofn "../prj/optohybrid_top.syr"'
    echo 'map -intstyle ise -p xc6vlx130t-ff1156-1 -w -logic_opt off -ol std -t 28 -xt 0 -r 4 -global_opt speed -equivalent_register_removal on -mt 2 -detail -ir off -ignore_keep_hierarchy -pr b -lc off -power off -o optohybrid_top_map.ncd optohybrid_top.ngd optohybrid_top.pcf'
    echo 'par -w -intstyle ise -ol high -xe n -mt off optohybrid_top_map.ncd optohybrid_top.ncd optohybrid_top.pcf'
    echo 'trce -intstyle ise -e 3 -nodatasheet -s 3 -u 400 -n 3 -fastpaths -xml optohybrid_top.twx optohybrid_top.ncd -o optohybrid_top.twr optohybrid_top.pcf'
}

VERSION="030105"

echo "================================"
echo "BUILDING GE11 V3C SHORT FIRMWARE"
echo "================================"
python change_oh_version.py ge11 v3c v3c short $VERSION
build_firmware
echo "sh ./tools/genproms.sh"

echo "\n"
echo "======================"
echo "BUILDING GE21 FIRMWARE"
echo "======================"
python change_oh_version.py ge11 v3c v3c long  $VERSION
build_firmware
echo "sh ./tools/genproms.sh"

echo "\n"
echo "==============================="
echo "BUILDING GE11 V3C LONG FIRMWARE"
echo "==============================="
python change_oh_version.py ge11 v3c v3c long  $VERSION
build_firmware
echo "sh ./tools/genproms.sh"
