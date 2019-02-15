set -e
echo "Setting OH version..." \
&& python ./change_oh_version.py  "$@" \
echo "Updating timing registers..." \
&& python ./update_timing_registers.py \
echo "Updating s-bit inversion registers..." \
&& python ./update_invert_registers.py \
echo "Updating vfat counters registers..." \
&& python ./update_vfat_counters.py \
echo "Updating tu_mask registers..." \
&& python ./update_tu_mask.py \
echo "Updating param_pkg..." \
&& python ./update_param_pkg.py \
echo "Updating cluster packer..." \
&& python ./update_cluster_packer.py \
echo "Updating trig_pkg..." \
&& python ./update_trig_pkg.py \
echo "Updating channel to strip mapping..." \
&& python ./update_channel_to_strip.py \
echo "Updating optohybrid top..." \
&& python ./update_oh_top.py \
echo "Regenerating registers and documentation..." \
&& python generate_registers.py oh \
&& python update_latex_version.py oh \
echo "Regenerating pdf documentation..." \
&& cd ../doc/latex/ \
&& pdflatex address_table.tex \
&& cd - \
