#!/bin/csh

# Evan Keane
# 14/06/2018
# Run this to make an up to date FRB file to plot

# Get name, Speak, DM, width, freq
#awk -F, 'NR>1{print $1,$6,$4,$5,$3}' frbcat_20180614.csv | sed -e s:\"::g -e s:,:" ":g > frbs_temp_vals
awk -F, 'NR>1{print $1,$6,$4,$5,$3}' frbcat_20190617.csv | sed -e s:\"::g -e s:,:" ":g > frbs_temp_vals


if (-e frbs_temp_dms) then
    rm frbs_temp_dms
endif
touch frbs_temp_dms
foreach dm (`awk '{print $3}' frbs_temp_vals`)

    set z  = `echo $dm | awk '{print ($1-100)/1200}'`
    set DL = `python CC.py -v $z | grep "luminosity distance" | awk '{print $6*0.001}'`
    echo $z $DL >> frbs_temp_dms 

end

# name, Speak, DM, width, freq, z, D_L
# Output Speak*D_L^2 in Jy*kpc^2, nu*width in GHz*s
paste frbs_temp_vals frbs_temp_dms | awk '{print $2*$7*10^(12),$5*0.001*$4*0.001}' > frbs_vals_to_plot
