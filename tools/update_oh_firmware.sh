set -e
echo "Setting OH version..." \
    && python2 ./change_oh_version.py  "$@" \
&& echo "Updating xml..." \
    && python2 ./update_xml.py \
&& echo "Updating version_pkg..." \
    && python2 ./update_version_pkg.py \
&& echo "Regenerating registers and documentation..." \
&& SUFFIX=$(grep -E "file_suffix\s+=" oh_settings.py | awk -F"\"" '{print $2}') \
    && python2 generate_registers.py oh -s $SUFFIX \
    && python2 update_latex_version.py oh \
&& echo "Regenerating pdf documentation..." \
    && cd ../doc/latex/ \
    && pdflatex address_table.tex $SUFFIX \
    && cd -
rm "*.pyc"
