"""Set the full path to the flow executable and flags"""
${flow} --enable-tuning=true --enable-opm-rst-file=true --linear-solver=cprw --relaxed-max-pv-fraction=0

"""Set the model parameters"""
co2store base   #Model (co2store/h2store)
cake 60    #Grid type (radial/cake/cartesian2d/cartesian/cave) and size (theta/theta/width/- [in degrees])
1000 60       #Reservoir dimensions [m] (Lenght and height)
200 30 2      #Number of x- and z-cells [-] and exponential factor for the telescopic x-gridding (0 to use an equidistance partition)
0.1 0 0      #Well diameter [m], well transmiscibility (0 to use the computed one internally in Flow), and remove the smaller cells than the well diameter
1e6 40 0     #Pressure [Pa] on the top, uniform temperature [°], and initial phase in the reservoir (0 wetting, 1 non-wetting)
1e5 0        #Pore volume multiplier on the boundary [-] (0 to use well producers instead) and deactivate cross flow within the wellbore (see XFLOW in OPM Manual)
0 5 6        #Activate perforations [-], number of well perforations [-], and lenght [m]
4 1 0        #Number of layers [-], hysteresis (1 to activate), and econ for the producer (for h2 models)
0 0 0 0 0 0 0 #Ini salt conc [kg/m3], salt sol lim [kg/m3], prec salt den [kg/m3], gamma [-], phi_r [-], npoints [-], and threshold [-]  (all entries for saltprec)
20-20*mt.cos((2*mt.pi*x/250)) + 200*(x/1000)**2 #The function for the reservoir surface

"""Set the saturation functions"""
krw * ((sw - swi) / (1.0 - sni -swi)) ** nkrw             #Wetting rel perm saturation function [-]
krn * ((1.0 - sw - sni) / (1.0 - sni - swi)) ** nkrn      #Non-wetting rel perm saturation function [-]
pec * ((sw - swi) / (1.0 - sni - swi)) ** (-(1.0 / npe)) #Capillary pressure saturation function [Pa]

"""Properties saturation functions"""
"""swi [-], sni [-], krn [-], krw [-], pec [Pa], nkrw [-], nkrn [-], npe [-], threshold cP evaluation, ignore swi for cP"""
SWI2  0.14 SNI2  0.1 KRW2  1 KRN2  1 PRE2  8655 NNKRW2 2 NNKRN2 2 HNPE2 2 THRE2  1e-4 IGN1 0
SWI3  0.12 SNI3  0.1 KRW3  1 KRN3  1 PRE3  6120 NNKRW3 2 NNKRN3 2 HNPE3 2 THRE3  1e-4 IGN1 0
SWI4  0.12 SNI4  0.1 KRW4  1 KRN4  1 PRE4  3871 NNKRW4 2 NNKRN4 2 HNPE4 2 THRE4  1e-4 IGN1 0
SWI5  0.12 SNI5  0.1 KRW5  1 KRN5  1 PRE5  3060 NNKRW5 2 NNKRN5 2 HNPE5 2 THRE5  1e-4 IGN1 0
HSWI2 0.28 HSNI2 0.2 HKRW2 1 HKRN2 1 HPRE2 8655 HNKRW2 2 HNKRN2 2 HNPE2 2 HTHRE2 1e-4 IGN1 0
HSWI3 0.24 HSNI3 0.2 HKRW3 1 HKRN3 1 HPRE3 6120 HNKRW3 2 HNKRN3 2 HNPE3 2 HTHRE3 1e-4 IGN1 0
HSWI4 0.24 HSNI4 0.2 HKRW4 1 HKRN4 1 HPRE4 3871 HNKRW4 2 HNKRN4 2 HNPE4 2 HTHRE4 1e-4 IGN1 0
HSWI5 0.24 HSNI5 0.2 HKRW5 1 HKRN5 1 HPRE5 3060 HNKRW5 2 HNKRN5 2 HNPE5 2 HTHRE5 1e-4 IGN1 0

"""Properties rock"""
"""Kxy [mD], Kz [mD], phi [-], thickness [m]"""
PERMXY2 101.324 PERMZ2 10.1324 PORO2 0.20 THIC2 15
PERMXY3 202.650 PERMZ3 20.2650 PORO3 0.20 THIC3 15
PERMXY4 506.625 PERMZ4 50.6625 PORO4 0.20 THIC4 15
PERMXY5 1013.25 PERMZ5 101.325 PORO5 0.25 THIC5 15

"""Define the injection values""" 
"""injection time [d], time step size to write results [d], maximum time step [d], fluid (0 wetting, 1 non-wetting), injection rates [kg/day]"""
% for _,control in enumerate(schedule):
${tperiod} ${tperiod} 1 ${control} 1440000
% endfor