echo ""
echo "--------------------------------------------------------"
echo "-- Installation script for the OptoHybrid v2 firmware"
echo "--"
echo "-- This script will download all required third-party"
echo "-- firmware/software"
echo "--------------------------------------------------------"
echo ""

# Go to root directory of repository

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

# GBT-FPGA

if [ -d "${DIR}/vendors/gbt-fpga" ]; then
    echo "GBT-FPGA is present, updating..."
    cd ${DIR}/vendors/gbt-fpga/tags
    svn up
    cd ${DIR}
else
    echo "GBT-FPGA not found, checking out the source..."
    mkdir -p vendors/gbt-fpga
    cd ${DIR}/vendors/gbt-fpga
    svn co https://svn.cern.ch/reps/ph-ese/be/gbt_fpga/tags
    cd ${DIR}
fi

#

echo ""