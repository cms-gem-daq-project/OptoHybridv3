set -e
echo "Setting OH version..." \
    && python2 ./change_oh_version.py  "$@" \
&& echo "Updating xml..." \
    && python2 ./update_xml.py \
&& echo "Updating version_pkg..." \
    && python2 ./update_version_pkg.py \
&& echo "Regenerating registers and documentation..." \
    && python2 generate_registers.py oh \
    && python2 update_latex_version.py oh \
&& echo "Regenerating pdf documentation..." \
    && cd ../doc/latex/ \
    && pdflatex address_table.tex \
    && cd - \
