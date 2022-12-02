#!/bin/env bash

# Evan Keane
# 14/06/2018
# Run this to make an up to date FRB file to plot

# Get name, Speak, Dist, width

(
	# sPeak = 140MHz
	awk 'NR>2{if ($12!="--" && $13!="--" && $16!="--") print $1,$13,$12,$16}' rratalog_14062018.txt | awk '{print $0,$4*0.001*0.14, $2*0.001*$3*$3}';
	# sPeak = 340MHz
	awk 'NR>2{if ($12!="--" && $14!="--" && $17!="--") print $1,$14,$12,$17}' rratalog_14062018.txt | awk '{print $0,$4*0.001*0.35, $2*0.001*$3*$3}';
	# sPeak = 1400MHz
	awk 'NR>2{if ($12!="--" && $15!="--" && $18!="--") print $1,$15,$12,$18}' rratalog_14062018.txt | awk '{print $0,$4*0.001*1.4, $2*0.001*$3*$3}';
) | sort -k 1 > rrats_nohead
