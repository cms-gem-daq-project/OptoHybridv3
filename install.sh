echo ""
echo "--------------------------------------------------------"
echo "-- Installation script for the OptoHybrid v2 firmware"
echo "--"
echo "-- This script will download all required third-party"
echo "-- firmware/software"
echo "--------------------------------------------------------"
echo ""

# GBT-FPGA

if [ -d "vendors/gbt-fpga" ]; then
    echo "GBT-FPGA is present, skipping..."
else
    echo "GBT-FPGA not found, checking out the source..."
    mkdir -p vendors/gbt-fpga
    cd vendors/gbt-fpga
    svn co https://svn.cern.ch/reps/ph-ese/be/gbt_fpga/tags
fi

echo ""