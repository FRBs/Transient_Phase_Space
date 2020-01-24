#!/bin/csh

# Evan Keane
# 14/06/2018
# Run this to make an up to date FRB file to plot

# Get name, Speak, Dist, width
awk 'NR>1{if ($12!="--" && $13!="--" && $14!="--") print $1,$13,$12,$14}' rratalog_14062018.txt | awk '{print $0,$4*0.001*1.4, $2*0.001*$3*$3}' > rrats_nohead
