#########################################################
#							#
# This is the plot of the transient phase space 	#
# for the introduction to my thesis			#
#							#
# 	Last updated: 01/04/2009 - original version	#
#				 - have PSRs+T_B lines	#
#							#
#########################################################

set term x11
#set terminal postscript enhanced color solid
#set output "phase_space_ewass.ps"

#set title "Radio Transient Phase Space"
set xlabel "{/Symbol n}.W (GHz s)"
set ylabel "L_{/Symbol n} (Jy kpc^{2})
set logscale xy
set logscale y2
set format y "10^{%L}"
set format x "10^{%L}"
set xtic out
set ytic out nomirror

## 						##
# Draw lines of constant brighness temperature 	 #
#						 #
# T_B = L/(2k(nu.W)**2)				 #
#     = (3.621e+22)*L/(nu.W)**2		   	 # 
#     = (         )*L/y**2			 #
# --> L = T_B*y**2*(2.761e-23)    Watts/Hz 	 #
# 						 #
#       = [ ]*(1.05025e-11)	  Jy,kpc^2	 #
#						 #
##						##

## NB. 1 W.Hz^{-1} == 1.05026*10^{-11} Jy.kpc^2 ##

L4(x)=1.0e+4*2.761*1.05025e-18*x**2
L8(x)=1.0e+8*2.761*1.05025e-18*x**2
L12(x)=1.0e+12*2.761*1.05025e-18*x**2
L16(x)=1.0e+16*2.761*1.05025e-18*x**2
L20(x)=1.0e+20*2.761*1.05025e-18*x**2
L24(x)=1.0e+24*2.761*1.05025e-18*x**2
L28(x)=1.0e+28*2.761*1.05025e-18*x**2
L32(x)=1.0e+32*2.761*1.05025e-18*x**2
L36(x)=1.0e+36*2.761*1.05025e-18*x**2
L40(x)=1.0e+40*2.761*1.05025e-18*x**2
set xrange[1.0e-10:1.0e+10]
set yrange[1.0e-10:1.0e+16]
set y2range[1.0e+10:1.0e+36]
set y2label "L_{/Symbol n} (ergs s^{-1} Hz^{-1})"
set format y2 "10^{%L}"
set y2tic out nomirror

unset key

set termoption dash
#set style line 1 lt 2 lc -1 lw 3
#set style line 2 lt 1 lc -1 lw 3
#set style line 3 lt 2 lc rgb "#66CDAA" lw 3
#set style line 4 lt 1 lc rgb "#66CDAA" lw 3
#set style line 5 lt 2 lc rgb "#FA8072" lw 3
#set style line 6 lt 1 lc rgb "#FA8072" lw 3
set style line 1 lc -1 lw 1 dashtype 2
set style line 2 lc -1 lw 1
set style line 3 lc rgb "#66CDAA" dashtype 2 lw 1
set style line 4 lc rgb "#66CDAA" lw 1
set style line 5 lc rgb "#FA8072" dashtype 2 lw 1
set style line 6 lc rgb "#FA8072" lw 1

# Parkes Cryo-PAF sensitivities
# z = 0.1
cryo_point1(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (0.46)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# z = 1
cryo1(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (6.7)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# z = 2
cryo2(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (15.8)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# z = 3
cryo3(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (25.9)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# z = 4
cryo4(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (36.6)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between

# Label FRB limits
set label "z=0.1" front at (0.7*0.000064*0.1),(1.5*(0.46)**2*8e10*(1000*0.000064)**(-0.5)) textcolor lt 6 font ",10" # 0.1 and 1.5 factors are for labelling finesse
set label "z=4.0" front at (0.7*0.000064*0.1),(1.5*(36.6)**2*8e10*(1000*0.000064)**(-0.5)) textcolor lt 6 font ",10" # 0.1 and 1.5 factors are for labelling finesse

# D = 0.1 kpc
cryo_point1kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (0.1)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# D = 1 kpc
cryo_1kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (1)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
# D = 10 kpc
cryo_10kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (10)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0 # 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between

# Label PSR limits
set label "D=0.1 kpc" front at (0.1*2.0*1.0),(5*(0.1)**2*(1e-12)*8e10*(1000*1.0)**(-0.5)) textcolor lt 6 font ",10" # 0.1 and 2 factors are for labelling finesse
set label "D=10 kpc" front at (0.1*2.0*1.0),(5*(10)**2*(1e-12)*8e10*(1000*1.0)**(-0.5)) textcolor lt 6 font ",10" # 0.1 and 2 factors are for labelling finesse


# MeerKAT UHF Incoherent
## at 1 kpc
#set arrow from 0.0000384,1.0e16 to 0.0000384,0.375 nohead ls 1 front         # 0.064 ms edge
#set arrow from 1.0,1.0e16 to 1.0,0.003 nohead ls 1 front                     # 1.0 s edge
#set arrow from 0.0000384,0.375 to 1.0,0.003 nohead ls 1 front                # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0000384,1.0e16 to 0.0000384,0.375e12 nohead ls 1 front         # 0.064 ms edge
#set arrow from 1.0,1.0e16 to 1.0,0.003e12 nohead ls 1 front                     # 1.0 s edge
#set arrow from 0.0000384,0.375e12 to 1.0,0.003e12 nohead ls 1 front                # sqrt(W) bottom

# MeerKAT UHF Coherent
## at 1 kpc
#set arrow from 0.0000384,1.0e16 to 0.0000384,0.0625 nohead ls 2 front         # 0.064 ms edge
#set arrow from 1.0,1.0e16 to 1.0,0.0005 nohead ls 2 front                     # 1.0 s edge
#set arrow from 0.0000384,0.0625 to 1.0,0.0005 nohead ls 2 front                # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0000384,1.0e16 to 0.0000384,0.0625e12 nohead ls 2 front         # 0.064 ms edge
#set arrow from 1.0,1.0e16 to 1.0,0.0005e12 nohead ls 2 front                     # 1.0 s edge
#set arrow from 0.0000384,0.0625e12 to 1.0,0.0005e12 nohead ls 2 front                # sqrt(W) bottom

# MeerKAT Mid Incoherent
## at 1 kpc
#set arrow from 0.0001024,1.0e16 to 0.0001024,0.3 nohead ls 3 front         # 0.064 ms edge
#set arrow from 3.2,1.0e16 to 3.2,0.0024 nohead ls 3 front                  # 1.0 s edge
#set arrow from 0.0001024,0.3 to 3.2,0.0024 nohead ls 3 front              # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0001024,1.0e16 to 0.0001024,0.3e12 nohead ls 3 front         # 0.064 ms edge
#set arrow from 3.2,1.0e16 to 3.2,0.0024e12 nohead ls 3 front                  # 1.0 s edge
#set arrow from 0.0001024,0.3e12 to 3.2,0.0024e12 nohead ls 3 front               # sqrt(W) bottom

# MeerKAT Mid Coherent
## at 1 kpc
#set arrow from 0.0001024,1.0e16 to 0.0001024,0.05 nohead ls 4 front         # 0.064 ms edge
#set arrow from 3.2,1.0e16 to 3.2,0.0004 nohead ls 4 front                  # 1.0 s edge
#set arrow from 0.0001024,0.05 to 3.2,0.0004 nohead ls 4 front              # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0001024,1.0e16 to 0.0001024,0.05e12 nohead ls 4         # 0.064 ms edge
#set arrow from 3.2,1.0e16 to 3.2,0.0004e12 nohead ls 4                      # 1.0 s edge
#set arrow from 0.0001024,0.05e12 to 3.2,0.0004e12 nohead ls 4                # sqrt(W) bottom

# MeerKAT L-band Incoherent
## at 1 kpc
#set arrow from 0.0000576,1.0e16 to 0.0000576,0.3 nohead ls 5 front         # 0.064 ms edge
#set arrow from 1.65,1.0e16 to 1.65,0.0024 nohead ls 5 front                  # 1.0 s edge
#set arrow from 0.0000576,0.3 to 1.65,0.0024 nohead ls 5 front              # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0000576,1.0e16 to 0.0000576,0.3e12 nohead ls 5 front         # 0.064 ms edge
#set arrow from 1.65,1.0e16 to 1.65,0.0024e12 nohead ls 5 front                  # 1.0 s edge
#set arrow from 0.0000576,0.3e12 to 1.65,0.0024e12 nohead ls 5 front              # sqrt(W) bottom

# MeerKAT L-band Coherent
## at 1 kpc
#set arrow from 0.0000576,1.0e16 to 0.0000576,0.05 nohead ls 6 front         # 0.064 ms edge
#set arrow from 1.65,1.0e16 to 1.65,0.0004 nohead ls 6 front                  # 1.0 s edge
#set arrow from 0.0000576,0.05 to 1.65,0.0004 nohead ls 6 front              # sqrt(W) bottom
## at 1 Gpc
#set arrow from 0.0000576,1.0e16 to 0.0000576,0.05e12 nohead ls 6 front         # 0.064 ms edge
#set arrow from 1.65,1.0e16 to 1.65,0.0004e12 nohead ls 6 front                  # 1.0 s edge
#set arrow from 0.0000576,0.05e12 to 1.65,0.0004e12 nohead ls 6 front              # sqrt(W) bottom




# Temperature Lines
#set label "10^{4} K" front at 1.5e+9,8e+3 rotate by 50
set label "10^{4} K" front at 4e+8,4e+2 rotate by 50
set label "10^{12} K" front at 1.5e+6,8e+5 rotate by 50
set label "10^{20} K" front at 1.5e+3,8e+7 rotate by 50
#set label "10^{28} K" front at 1.5,8e+9 rotate by 50
set label "10^{28} K" front at 4,4e+10 rotate by 50

# Coherent - Incoherent boundaries
set label "Coherent Emission" front at 1.0e3,20 rotate by 50
set label "Incoherent Emission" front at 1.5e+3,1.0e0 rotate by 50
set arrow from 2.0e4,1.0e5 to 1.0e2,8.0e7 lt -1 lw 2 front
set arrow from 2.0e5,4.0e3 to 2.0e7,10 lt -1 lw 2 front

# Uncertainty Principle 
#set arrow from 3.16225e-10,1.1e-10 to 3.16225e-10,9.0e15 nohead lt 9 lw 55
#set arrow from 1.0e-9,1.0e-10 to 1.0e-9,1.0e16 nohead lt -1 lw 2 front
#set object rectangle from 1.0e-10,1.0e-10 to 1.0e-9,1.0e16 back fc lt 9 fs solid
set object rectangle from 1.0e-10,1.0e-10 to 1.0e-9,1.0e16 back fc rgb '#808080' fs solid
set label "Uncertainty Principle" front at 3.16225e-10,1.0e-3 rotate by 90

# Label Sources
set label "RRATs" front at 0.02,100 textcolor rgb '#FF0000'
set label "Pulsars" front at 1.0e-7,1.0e-2 textcolor rgb '#0000FF'
#set label "Lorimer Burst" front at 0.01,1.0e13 textcolor lt -1
set label "Fast Radio Bursts" front at 0.0001,1.0e15 textcolor lt -1
set label "Crab nano-shots" front at 2.0e-9,5.0e2 textcolor lt -1
set label "Pulsar GRPs" at 1.0e-8,4.0e5 textcolor rgb '#6A5ACD' front
set label "Solar Bursts" front at 1.0e0,5.0e-6 textcolor rgb '#FFA500'
#set arrow from 2520,4.41e-07 to 1,4.41e-07 lt -1 lw 2 front
set label "GCRT 1745" front at 10,8.0e2 textcolor rgb '#8B4513'
#set label "UV Ceti" front at 5,3.0e-8 textcolor lt -1
#set label "AD Leo" front at 300,5.0e-6 textcolor lt -1
#set label "BD LP944" front at 200,8.0e-9 textcolor lt -1
#set label "TVLM 513" front at 4.0e3,5.0e-7 textcolor lt -1
set label "Flare Stars/Brown Dwarves" front at 10,8.0e-9 textcolor rgb '#8B4513'
set label "Jupiter DAM" front at 4.0e-5,8.0e-10 textcolor lt -1
set label "X-ray Binaries" front at 1.0e6,2.0e-1 textcolor rgb '#CD853F'
set label "AGN/Blazar/QSO" front at 4.0e3,1.0e+14 textcolor rgb '#0000FF'
#set label "QSO/TDE" front at 5.0e2,1.0e+12 textcolor lt 3
set label "GRBs" front at 3.0e5,1.0e+11 textcolor lt 1
set label "Supernovae" front at 1.0e7,4.0e+5 textcolor rgb '#808080'
set label "GW170817" front at 1.0e7,3.0e+4 textcolor lt 1
set label "RSCVn" front at 1.0e6,5.0e-3 textcolor lt -1
set label "Novae" front at 1.0e8,1.0 textcolor lt 6
set label "Magnetic CV" front at 1.0e4,5.0e-5 textcolor rgb '#228B22'



# PLOT EVERYTHING
# With ALL FRBs
#plot L12(x) notitle w filledcurve x2=10 lt 5, L4(x) notitle lt 0 lw 2, L8(x) notitle lt 0 lw 2, L12(x) notitle lt 0 lw 2, L16(x) notitle lt 0 lw 2, L20(x) notitle lt 0 lw 2, L24(x) notitle lt 0 lw 2, L28(x) notitle lt 0 lw 2, L32(x) notitle lt 0 lw 2, L36(x) notitle lt 0 lw 2, L40(x) notitle lt 0 lw 2, 'psrs_2' using 5:6 pt 7 ps 1 title "Pulsars", 'crab_nanogiant' pt 7 ps 1 lt -1 title "Crab nanogaint", 'crab_GRP' using 6:5 pt 7 ps 1 lt 2 title "Crab GRPs",'FRBs' pt 7 ps 0.8 lt -1 title "FRBs", 'keane' pt 7 ps 0.8 lt -1 title "Keane", 'rrats_nohead' using 5:6 pt 7 ps 1 lt 1 title "RRATs", 'solar_vals' every ::1 using 5:6 pt 7 ps 1 lt 8 title "Sun", 'GRPs_vals' every ::1 using 7:8 pt 7 ps 1 lt 2 title "GRPs", 'BDs_vals' every ::1 using 6:7 pt 7 ps 1 lt -1 title "TVLM513", 'misc' using 1:2 pt 7 ps 1 lt -1 notitle

# With All FRBCAT FRBs
plot L12(x) notitle w filledcurve x2=10 lt rgb '#87CEFA', L4(x) notitle lt 0 lw 2, L8(x) notitle lt 0 lw 2, L12(x) notitle lt 0 lw 2, L16(x) notitle lt 0 lw 2, L20(x) notitle lt 0 lw 2, L24(x) notitle lt 0 lw 2, L28(x) notitle lt 0 lw 2, L32(x) notitle lt 0 lw 2, L36(x) notitle lt 0 lw 2, L40(x) notitle lt 0 lw 2, 'gach_rud/psrs_2' using 5:6 pt 7 ps 1 lt rgb '#0000FF' title "Pulsars", 'gach_rud/crab_nanogiant' pt 7 ps 1 lt -1 title "Crab nanogaint", 'gach_rud/crab_GRP' using 6:5 pt 7 ps 1 lt rgb '#6A5ACD' notitle,'gach_rud/frbs_vals_to_plot' u 2:1 pt 7 ps 0.8 lt -1 title "FRBs",'gach_rud/arecibo_frb' pt 7 ps 0.8 lt -1 title "FRBs",'gach_rud/rrats_nohead' using 5:6 pt 7 ps 1 lt rgb '#FF0000' title "RRATs", 'gach_rud/solar_vals' every ::1 using 5:6 pt 7 ps 1 lt rgb '#FFA500' title "Sun", 'gach_rud/GRPs_vals' every ::1 using 7:8 pt 7 ps 1 lt rgb '#6A5ACD' notitle, 'gach_rud/misc' using 1:2 pt 7 ps 1 lt rgb '#8B4513' notitle, 'gach_rud/Gosia_AGN_QSO_Blazar_TDE2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#0000FF' notitle, 'gach_rud/Gosia_XRB2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#CD853F' notitle, 'gach_rud/Gosia_GRB2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt 1 notitle, 'gach_rud/Gosia_SN2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#808080' notitle, 'gach_rud/Gosia_RSCVn2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt -1 notitle, 'gach_rud/Gosia_flare_stars2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#8B4513' notitle, 'gach_rud/Gosia_Novae2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt 6 notitle, 'gach_rud/Gosia_MagCV2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#228B22' notitle, 'gach_rud/gw170817' pt 7 ps 1 lt 1 notitle, cryo_point1(x) lt 6, cryo1(x) lt 6, cryo2(x) lt 6, cryo3(x) lt 6, cryo4(x) lt 6, cryo_point1kpc(x) lt 6, cryo_1kpc(x) lt 6, cryo_10kpc(x) lt 6

# NO FRBs
#plot L12(x) notitle w filledcurve x2=10 lt 5, L4(x) notitle lt 0 lw 2, L8(x) notitle lt 0 lw 2, L12(x) notitle lt 0 lw 2, L16(x) notitle lt 0 lw 2, L20(x) notitle lt 0 lw 2, L24(x) notitle lt 0 lw 2, L28(x) notitle lt 0 lw 2, L32(x) notitle lt 0 lw 2, L36(x) notitle lt 0 lw 2, L40(x) notitle lt 0 lw 2, 'psrs_2' using 5:6 pt 7 ps 1 title "Pulsars", 'crab_nanogiant' pt 7 ps 1 lt -1 title "Crab nanogaint", 'crab_GRP' using 6:5 pt 7 ps 1 lt 2 title "Crab GRPs", 'rrats_nohead' using 5:6 pt 7 ps 1 lt 1 title "RRATs", 'solar_vals' every ::1 using 5:6 pt 7 ps 1 lt 8 title "Sun", 'GRPs_vals' every ::1 using 7:8 pt 7 ps 1 lt 2 title "GRPs", 'BDs_vals' every ::1 using 6:7 pt 7 ps 1 lt -1 title "TVLM513", 'misc' using 1:2 pt 7 ps 1 lt -1 notitle


