set -e
echo "Setting OH version..." \
&& python2 ./change_oh_version.py  "$@" \
echo "Updating xml..." \
&& python2 ./update_xml.py \
echo "Updating param_pkg..." \
&& python2 ./update_param_pkg.py \
echo "Updating cluster packer..." \
&& python2 ./update_cluster_packer.py \
echo "Updating trig_pkg..." \
&& python2 ./update_trig_pkg.py \
echo "Updating channel to strip mapping..." \
&& python2 ./update_channel_to_strip.py \
echo "Updating optohybrid top..." \
&& python2 ./update_oh_top.py \
echo "Regenerating registers and documentation..." \
&& python2 generate_registers.py oh \
&& python2 update_latex_version.py oh \
echo "Regenerating pdf documentation..." \
&& cd ../doc/latex/ \
&& pdflatex address_table.tex \
&& cd - \
