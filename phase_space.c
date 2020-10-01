#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>

// Declare some functions
void print_usage(void);
int strings_equal (char *string1, char *string2);
int get_args(int argc, char** argv, int* all, int* psr, int* rrat, int* frb, int* sun, int* slow, int* TB, int* cryopaf, int* ps_output, int* png_output);

// Main Function
int main ( int argc, char* argv[])
{
  FILE *gnuplot = popen("/usr/local/bin/gnuplot -persist","w");
  char path[]="./gach_rud/";
  int check=0;
  int psr,rrat,frb,sun,agn,gw,fast,slow,galactic,extragal;
  int TB,cryopaf;
  int top,bottom,request;
  int all, ps_output, png_output;
  char psr_name[10];

  check=get_args(argc,argv,&all,&psr,&rrat,&frb,&sun,&slow,&TB,&cryopaf,&ps_output,&png_output);
  //  check=get_args(argc,argv,&psr,&magnetar,&xdins,&binary,&rrat,&nuller,&fermi,&glitch,&E,&B,&T,&BQC,&death,&top,&bottom,&request,psr_name);
  if (check !=0) return(1);

  /* Set up axes */
  //fprintf(gnuplot, "set title \"Radio Transient Phase Space\"\n");
  fprintf(gnuplot, "set xlabel \"{/Symbol n}.W (GHz s)\"\n");
  fprintf(gnuplot, "set ylabel \"L_{/Symbol n} (Jy kpc^{2})\"\n");
  fprintf(gnuplot, "set logscale xy\n");
  fprintf(gnuplot, "set logscale y2\n");
  fprintf(gnuplot, "set format x \"10^{%%L}\"\n");
  fprintf(gnuplot, "set format y \"10^{%%L}\"\n");
  fprintf(gnuplot, "set xtic out\n");
  fprintf(gnuplot, "set ytic out nomirror\n");
  fprintf(gnuplot, "set format y2 \"10^{\%%L}\"\n");
  fprintf(gnuplot, "set y2tic out nomirror\n");
  fprintf(gnuplot, "set xrange[1.0e-10:1.0e+10]\n");
  fprintf(gnuplot, "set yrange[1.0e-10:1.0e+16]\n");
  fprintf(gnuplot, "set y2range[1.0e+10:1.0e+36]\n");
  fprintf(gnuplot, "set y2label \"L_{/Symbol n} (ergs s^{-1} Hz^{-1})\"\n");

  /* 
   * Define lines of constant brighness temperature  *
   *                                                 *
   * T_B = L/(2k(nu.W)**2)                           *
   *     = (3.621e+22)*L/(nu.W)**2    
   *     = (         )*L/y**2                        *
   * --> L = T_B*y**2*(2.761e-23)    Watts/Hz        *
   *
   *      = [ ]*(1.05025e-11)  Jy,kpc^2              *
   *
   *
   * NB. 1 W.Hz^{-1} == 1.05026*10^{-11} Jy.kpc^2    *
   */
  
  fprintf(gnuplot, "L4(x)=1.0e+4*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L8(x)=1.0e+8*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L12(x)=1.0e+12*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L16(x)=1.0e+16*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L20(x)=1.0e+20*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L24(x)=1.0e+24*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L28(x)=1.0e+28*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L32(x)=1.0e+32*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L36(x)=1.0e+36*2.761*1.05025e-18*x**2\n");
  fprintf(gnuplot, "L40(x)=1.0e+40*2.761*1.05025e-18*x**2\n");

  fprintf(gnuplot, "unset key\n");

  /* Set line styles */
  fprintf(gnuplot, "if (GPVAL_VERSION < 5.0) set termoption dash\n");
  //fprintf(gnuplot, "set style line 1 lc -1 lw 1 dashtype 2\n");
  fprintf(gnuplot, "if (GPVAL_VERSION >= 5.0) set style line 1 lc -1 lw 1 dashtype 2\n");
  fprintf(gnuplot, "if (GPVAL_VERSION < 5.0) set style line 1 lc -1 lw 1\n");
  fprintf(gnuplot, "set style line 2 lc -1 lw 1\n");
  //  fprintf(gnuplot, "set style line 3 lc rgb \"#66CDAA\" dashtype 2 lw 1\n");
  fprintf(gnuplot, "if (GPVAL_VERSION >= 5.0) set style line 3 lc rgb \"#66CDAA\" lw 1 dashtype 2\n");
  fprintf(gnuplot, "if (GPVAL_VERSION < 5.0) set style line 3 lc rgb \"#66CDAA\" lw 1\n");
  fprintf(gnuplot, "set style line 4 lc rgb \"#66CDAA\" lw 1\n");
  //  fprintf(gnuplot, "set style line 5 lc rgb \"#FA8072\" dashtype 2 lw 1\n");
  fprintf(gnuplot, "if (GPVAL_VERSION >= 5.0) set style line 5 lc rgb \"#FA8072\" lw 1 dashtype 2\n");
  fprintf(gnuplot, "if (GPVAL_VERSION < 5.0) set style line 5 lc rgb \"#FA8072\" lw 1\n");
  fprintf(gnuplot, "set style line 6 lc rgb \"#FA8072\" lw 1\n");

  /* Uncertainty Principle */
  fprintf(gnuplot, "set object rectangle from 1.0e-10,1.0e-10 to 1.0e-9,1.0e16 back fc rgb '#808080' fs solid\n");
  fprintf(gnuplot, "set label \"Uncertainty Principle\" front at 3.16225e-10,1.0e-3 rotate by 90\n");

  /* Label Sources */
  fprintf(gnuplot, "set label \"GCRT 1745\" front at 10,8.0e2 textcolor rgb '#8B4513'\n");
  //fprintf(gnuplot, "set label \"UV Ceti\" front at 5,3.0e-8 textcolor lt -1\n");
  //fprintf(gnuplot, "set label \"AD Leo\" front at 300,5.0e-6 textcolor lt -1\n");
  //fprintf(gnuplot, "set label \"BD LP944\" front at 200,8.0e-9 textcolor lt -1\n");
  //fprintf(gnuplot, "set label \"TVLM 513\" front at 4.0e3,5.0e-7 textcolor lt -1\n");
  fprintf(gnuplot, "set label \"SGR 1935+2154\" front at 1.0e-4,3.0e7 textcolor rgb '#78B3A7'\n");
  fprintf(gnuplot, "set label \"Flare Stars/Brown Dwarves\" front at 10,8.0e-9 textcolor rgb '#8B4513'\n");
  fprintf(gnuplot, "set label \"Jupiter DAM\" front at 4.0e-5,8.0e-10 textcolor lt -1\n");
  //fprintf(gnuplot, "set label \"X-ray Binaries\" front at 1.0e6,2.0e-1 textcolor rgb '#CD853F'\n");
  fprintf(gnuplot, "set label \"XRBs\" front at 3.0e4,2.0e-1 textcolor rgb '#CD853F'\n");
  fprintf(gnuplot, "set label \"MKT J1704\" front at 5.0e6,1.0e-1 textcolor rgb '#78B3A7'\n");
  fprintf(gnuplot, "set label \"AGN/Blazar/QSO\" front at 4.0e3,1.0e+14 textcolor rgb '#0000FF'\n");
  //fprintf(gnuplot, "set label \"QSO/TDE\" front at 5.0e2,1.0e+12 textcolor lt 3\n");
  fprintf(gnuplot, "set label \"GRBs\" front at 3.0e5,1.0e+11 textcolor lt 1\n");
  fprintf(gnuplot, "set label \"Supernovae\" front at 1.0e7,4.0e+5 textcolor rgb '#808080'\n");
  fprintf(gnuplot, "set label \"GW170817\" front at 1.0e7,3.0e+4 textcolor lt 1\n");
  fprintf(gnuplot, "set label \"RSCVn\" front at 1.0e6,5.0e-3 textcolor lt -1\n");
  fprintf(gnuplot, "set label \"Novae\" front at 1.0e8,1.0 textcolor lt 6\n");
  fprintf(gnuplot, "set label \"Magnetic CV\" front at 1.0e4,5.0e-5 textcolor rgb '#228B22'\n");

  /* Plot stuff */
  fprintf(gnuplot, "plot 1.0e-11\n"); // Basically make an empty plot 
  if (TB==1){
    /* Temperature Labels */
    fprintf(gnuplot, "set label \"10^{4} K\" front at 4e+8,4e+2 rotate by 50\n");
    fprintf(gnuplot, "set label \"10^{12} K\" front at 1.5e+6,8e+5 rotate by 50\n");
    fprintf(gnuplot, "set label \"10^{20} K\" front at 1.5e+3,8e+7 rotate by 50\n");
    fprintf(gnuplot, "set label \"10^{28} K\" front at 4,4e+10 rotate by 50\n");

    /* Coherent - Incoherent boundaries */
    fprintf(gnuplot, "set label \"Coherent Emission\" front at 1.0e3,20 rotate by 50\n");
    fprintf(gnuplot, "set label \"Incoherent Emission\" front at 1.5e+3,1.0e0 rotate by 50\n");
    fprintf(gnuplot, "set arrow from 2.0e4,1.0e5 to 1.0e2,8.0e7 lt -1 lw 2 front\n");
    fprintf(gnuplot, "set arrow from 2.0e5,4.0e3 to 2.0e7,10 lt -1 lw 2 front\n");

    /* Constant Brightness Temperature Lines */
    fprintf(gnuplot, "replot L12(x) notitle w filledcurve x2=1e10 lt rgb '#87CEFA', L4(x) notitle lt 0 lw 2, L8(x) notitle lt 0 lw 2, L12(x) notitle lt 0 lw 2, L16(x) notitle lt 0 lw 2, L20(x) notitle lt 0 lw 2, L24(x) notitle lt 0 lw 2, L28(x) notitle lt 0 lw 2, L32(x) notitle lt 0 lw 2, L36(x) notitle lt 0 lw 2, L40(x) notitle lt 0 lw 2\n");
  }
  if (psr==1){
    fprintf(gnuplot, "set label \"Pulsars\" front at 1.0e-7,1.0e-2 textcolor rgb '#0000FF'\n");
    fprintf(gnuplot, "set label \"Crab nano-shots\" front at 2.0e-9,5.0e2 textcolor lt -1\n");
    fprintf(gnuplot, "set label \"Pulsar GRPs\" at 1.0e-8,4.0e5 textcolor rgb '#6A5ACD' front\n");
    fprintf(gnuplot, "replot '%spsrs_2' using 5:6 pt 7 ps 1 lt rgb '#0000FF' notitle\n",path);
    fprintf(gnuplot, "replot '%scrab_nanogiant' pt 7 ps 1 lt -1 notitle, '%scrab_GRP' using 6:5 pt 7 ps 1 lt rgb '#6A5ACD' notitle\n",path,path);
    fprintf(gnuplot, "replot '%sGRPs_vals' every ::1 using 7:8 pt 7 ps 1 lt rgb '#6A5ACD' notitle\n",path); 
  }
  if (rrat==1){
     fprintf(gnuplot, "set label \"RRATs\" front at 0.02,100 textcolor rgb '#FF0000'\n");
     fprintf(gnuplot, "replot '%srrats_nohead' using 5:6 pt 7 ps 1 lt rgb '#FF0000' notitle\n",path);
  }
  if (frb==1){
    fprintf(gnuplot, "set label \"Fast Radio Bursts\" front at 0.0001,1.0e15 textcolor lt -1\n");
    fprintf(gnuplot, "replot '%sfrbs_vals_to_plot' u 2:1 pt 7 ps 0.8 lt -1 notitle\n",path);
  }
  if (sun==1){
    fprintf(gnuplot, "set label \"Solar Bursts\" front at 1.0e0,5.0e-6 textcolor rgb '#FFA500'\n");
    fprintf(gnuplot, "replot '%ssolar_vals' every ::1 using 5:6 pt 7 ps 1 lt rgb '#FFA500' notitle\n",path);
  }
  if (slow==1){
    fprintf(gnuplot, "set arrow from 0.0014,141135000.00 to 0.0014,14113500000.0 lt rgb '#78B3A7' lw 2 front\n"); // SGR 1935+2154 lower limit
    fprintf(gnuplot, "replot '%sSGR1935+2154' using ($3*$4):($1*$2*$2) pt 7 ps 1 lt rgb '#78B3A7' notitle, '%sflarey_boi' using 1:2 pt 7 ps 1 lt rgb '#78B3A7' notitle, '%smisc' using 1:2 pt 7 ps 1 lt rgb '#8B4513' notitle, 'gach_rud/Gosia_AGN_QSO_Blazar_TDE2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#0000FF' notitle, 'gach_rud/Gosia_XRB2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#CD853F' notitle, 'gach_rud/Gosia_GRB2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt 1 notitle, 'gach_rud/Gosia_SN2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#808080' notitle, 'gach_rud/Gosia_RSCVn2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt -1 notitle, 'gach_rud/Gosia_flare_stars2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#8B4513' notitle, 'gach_rud/Gosia_Novae2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt 6 notitle, 'gach_rud/Gosia_MagCV2' using ($2*86400.0*$9):($7*1.05026e-20) pt 7 ps 1 lt rgb '#228B22' notitle, 'gach_rud/gw170817' pt 7 ps 1 lt 1 notitle\n",path,path,path);
  }

  /* Parkes CryoPAF */
  if (cryopaf==1){
    /* Parkes Cryo-PAF sensitivities */
    // z = 0.1
    fprintf(gnuplot, "cryo_point1(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (0.46)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); //64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // z = 1
    fprintf(gnuplot, "cryo1(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (6.7)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // z = 2
    fprintf(gnuplot, "cryo2(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (15.8)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // z = 3
    fprintf(gnuplot, "cryo3(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (25.9)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // z = 4
    fprintf(gnuplot, "cryo4(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (36.6)**2*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // Label FRB limits
    fprintf(gnuplot, "set label \"z=0.1\" front at (0.7*0.000064*0.1),(1.5*(0.46)**2*8e10*(1000*0.000064)**(-0.5)) textcolor lt 6 font \",10\"\n"); // 0.1 and 1.5 factors are for labelling finesse
    fprintf(gnuplot, "set label \"z=4.0\" front at (0.7*0.000064*0.1),(1.5*(36.6)**2*8e10*(1000*0.000064)**(-0.5)) textcolor lt 6 font \",10\"\n"); // 0.1 and 1.5 factors are for labelling finesse
    // D = 0.1 kpc
    fprintf(gnuplot, "cryo_point1kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (0.1)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // D = 1 kpc
    fprintf(gnuplot, "cryo_1kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (1)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // D = 10 kpc
    fprintf(gnuplot, "cryo_10kpc(x) = x>(0.7*0.000064) ? (x<(2.0*1.0) ? (10)**2*(1e-12)*8e10*(1000*x)**(-0.5) : 1/0) : 1/0\n"); // 64 us to 1 second, 0.7 - 2.0 GHz, sqrt(W) in between
    // Label PSR limits
    fprintf(gnuplot, "set label \"D=0.1 kpc\" front at (0.1*2.0*1.0),(5*(0.1)**2*(1e-12)*8e10*(1000*1.0)**(-0.5)) textcolor lt 6 font \",10\"\n"); // 0.1 and 2 factors are for labelling finesse
    fprintf(gnuplot, "set label \"D=10 kpc\" front at (0.1*2.0*1.0),(5*(10)**2*(1e-12)*8e10*(1000*1.0)**(-0.5)) textcolor lt 6 font \",10\"\n"); // 0.1 and 2 factors are for labelling finesse
    
    fprintf(gnuplot, "replot cryo_point1(x) lt 6, cryo1(x) lt 6, cryo2(x) lt 6, cryo3(x) lt 6, cryo4(x) lt 6, cryo_point1kpc(x) lt 6, cryo_1kpc(x) lt 6, cryo_10kpc(x) lt 6\n");
  }
  

  /* Output plot to file if requested */
  if (ps_output==1){ // POSTSCRIPT
    fprintf(gnuplot,"set output \"phase_space.ps\"\n");
    fprintf(gnuplot,"set terminal postscript enhanced color solid\n");
    fprintf(gnuplot,"replot\n");
  } 
  if (png_output==1){ // PNG
    fprintf(gnuplot,"set terminal png color\n");
    fprintf(gnuplot,"set output \"phase_space.png\"\n");
    fprintf(gnuplot,"replot\n");
  }
  //fprintf(gnuplot,"set terminal pdf color\n");
  //fprintf(gnuplot,"set output \"ppdot.pdf\"\n");

  /* Close GNUPLOT */
  fprintf(gnuplot,"exit \n");
  pclose(gnuplot);
  
  /* EXIT C */
  return(0);
}

/* FUNCTION DEFINITIONS */
int strings_equal (char *string1, char *string2)
{
  if (!strcmp(string1,string2)) {
    return 1;
  } else {
    return 0;
  }
}

int get_args(int argc, char** argv, int* all, int* psr, int* rrat, int* frb, int* sun, int* slow, int* TB, int* cryopaf, int* ps_output, int* png_output)
{
  int ret,compipe[2];

  /* Set default values */
  *all=0;
  *psr=0;
  *rrat=0;
  *frb=0;
  *sun=0;
  *slow=0;
  *TB=0;
  *cryopaf=0;
  *ps_output=0;
  *png_output=0;    

/* Cycle through all the command line arguments */
  int i=1;
  while (i<argc){
    /*    if (strings_equal(argv[i],"-m")){
      *magnetar=1;
      }else*/
    if (strings_equal(argv[i],"-h")){
      print_usage();
    }else if (strings_equal(argv[i],"--help")){
      print_usage();
    }else if (strings_equal(argv[i],"-all")){
      *all=*psr=*rrat=*frb=*sun=*slow=*TB=*cryopaf=1;
    }else if (strings_equal(argv[i],"-frb")){
      *frb=1;
    }else if (strings_equal(argv[i],"-ps")){
      *ps_output=1;
    }else if (strings_equal(argv[i],"-psr")){
      *psr=1;
    }else if (strings_equal(argv[i],"-png")){
      *png_output=1;
    }else if (strings_equal(argv[i],"-rrat")){
      *rrat=1;
    }else if (strings_equal(argv[i],"-slow")){
      *slow=1;
    }else if (strings_equal(argv[i],"-sun")){
      *sun=1;
    }else if (strings_equal(argv[i],"-TB")){
      *TB=1;
    }else if (strings_equal(argv[i],"-cryopaf")){
      *cryopaf=1;
    }
    i++;
  }

  return(0);

}

void print_usage(void)
{
  fprintf(stdout,"\nphase_space - plots radio transient phase space \n\n");
  /*  fprintf(stdout,"\nppdot - plots a period - period derivative diagram highlighting \nwhatever you specify \n\n");
  fprintf(stdout,"usage: ppdot -{options}\n\n");
  fprintf(stdout,"options:\n\n");*/
  fprintf(stdout,"-all          - plot everything\n");
  fprintf(stdout,"-cryopaf      - plot Parkes CryoPAF sensitivity curves\n");
  fprintf(stdout,"-frb          - plot fast radio bursts\n");/*
  fprintf(stdout,"-m            - magnetars\n");
  fprintf(stdout,"-n            - nullers\n");*/
  fprintf(stdout,"-ps           - output postscript file\n");
  fprintf(stdout,"-psr          - plot pulsars\n");
  fprintf(stdout,"-png          - output png file\n");
  fprintf(stdout,"-rrat         - plot \"RRRATs\"\n");
  fprintf(stdout,"-slow         - plot all 'slow' transients\n");/*
  fprintf(stdout,"-bottom       - plot the bottom half only\n");
  fprintf(stdout,"-top          - plot the top half only\n");
  fprintf(stdout,"-E            - constant Edot lines\n");
  fprintf(stdout,"-B            - constant B lines\n");*/
  fprintf(stdout,"-TB           - plot brightness temperature lines\n");/*
  fprintf(stdout,"-BQC          - quantum critical B line\n");
  fprintf(stdout,"-death        - death line\n");
  fprintf(stdout,"-psr {name}   - highlights pulsar {name} on plot\n");*/
  fprintf(stdout,"\n-h,--help     - prints this usage message\n");
  fprintf(stdout,"\n");

  exit(0);
}
