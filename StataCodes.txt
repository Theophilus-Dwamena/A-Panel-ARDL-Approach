/* Stata ado Command List */
/* Declare Panel data*/
egen country = group(Country)
xtset country Time, yearly

/* Summary Statistics */
sum lGDPC lAVA lFP lPGR lCO2

/* Panel Unit Root Test*/
xtunitroot llc variable            /* LLC */
xtunitroot llc variable, trend     /* LLC  with trend*/
xtunitroot ips variable            /* IPS */ 
xtunitroot ips variable, trend     /* IPS with trend */

/* Co-integration Analysis */
xtcointtest pedroni lGDPC lCO2 lFP lAVA lPGR

/* ARDL Individual Lag Selection */
forval i = 1/14{
ardl lGDPC lCO2 lFP lAVA lPGR if (country==`i'), maxlag ( 2 2 2 2 2 )
matrix list e(lags)
di
}

/* Hausman MG Test */
xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace mg

xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace pmg

hausman mg pmg, sigmamore

xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace dfe

hausman mg DFE, sigmamore
