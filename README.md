# A-Panel-ARDL-Approach [^1]
We aim to examine the effects of CO2 emissions, agricultural advancements, and food availability on economic growth in West Africa from 1990 to 2020,  using a panel ARDL approach with data from 14 countries. [R Programming](R_Code_for_Data_Exploration.R) language was used to explore the data and [Stata](Stata_Codes.txt) was used for the panel ARDL analysis. The analysis evaluates both long- and short-term effects. The data utilized for this study is secondary data for fourteen West African countries and was sourced from the World Bank’s Climate Change Knowledge Portal(CCKP) [^2] and World Development Indicators (WDI) database [^3]. The dependent variable is the GDPC. The natural logarithm transformation was applied to the variables using the formula y = ln(x) , where x is the original variable value and y is the transformed value. This transformation controlled the influence of extreme values [^4].

## Empirical model
The model specification is: 
```math 
\ell\text{GDPC}_{it} = f(\ell\text{CO$_2$}_{it},\ell\text{FP}_{it},\ell\text{AVA}_{it},\ell\text{PGR}_{it})+\epsilon_{it}
```
where the variables:
```math
\begin{align*}
	\ell\text{GDPC}_{it} &= \text{ $\log$ of GDPC in year $t$ and country $i$.}\\
	\ell\text{CO$_2$}_{it} &= \text{ $\log$ of CO$_2$ in year $t$ and country $i$.}\\
	\ell\text{FP}_{it} &= \text{ $\log$ of FP in year $t$ and country $i$.}\\
	\ell\text{AVA}_{it} &= \text{ $\log$ of AVA in year $t$ and country $i$.}\\
	\ell\text{PGR}_{it} &= \text{ $\log$ of PGR in year $t$ and country $i$.}\\ 
	\epsilon_{it} &= \text{ unobserved variables in country $i$.}
\end{align*}
```
The population growth rate was added as a control variable to account for the potential impact of population on the indicators over time. 

## Panel unit root test
Testing for stationarity in the time dimension in panel data analysis is crucial in determining whether the panel is dynamic or static. Unlike simple time series analysis, which employs standard unit root tests for stationarity, more advanced approaches have been developed to check for stationarity in panel data. This study employed the first-generation panel unit root tests, which assume cross-sectional independence and are generally derived from the augmented Dickey-Fuller 
(ADF) test proposed by [^5] for a single cross-section series, modified for multiple cross-sectional units to obtain the panel unit root regression [^6] given as:
```math
\Delta y_{it} = \alpha_{i}\beta_{i}t + \rho_i \ y_{i,t-1} + \mu_{it},
```
where for $i=1,\ldots,N$ number of countries,  and year $t=1,\ldots,T$, $\alpha_i$ is the fixed effects(constant) for country $i$, $\beta_{i}$ is the coefficient of time trend, $\rho_i$ is the auto-regressive coefficients of cross-section $i$, $\ \ (\alpha_i\beta_{i}t)$ is the deterministic component (may be 0, 1, $\alpha_i$, $\{\alpha_i, \beta_{i}t\}$) and $\mu_{it}$ is a stationary process.

The general test hypotheses are series has a unit root or is non-stationary (null hypothesis) and series has a no unit root or is stationary (alternative hypothesis).  The panel unit root tests employed in this study are Levin, Lin and Chu (LLC) test [^7] and Im, Pesaran and Shin (IPS) test [^8]. Refer to [^1] for detailed explanation of the types of panel unit root tests used.
The following Stata Codes were used:
```Stata
/* Panel Unit Root Test*/
/* xtunitroot llc variable (LLC) */
xtunitroot llc lGDPC 
xtunitroot llc lCO2 
xtunitroot llc lFP 
xtunitroot llc lAVA 
xtunitroot llc lPGR

/* xtunitroot llc variable, trend (LLC  with trend)*/
xtunitroot llc lGDPC, trend 
xtunitroot llc lCO2, trend 
xtunitroot llc lFP, trend 
xtunitroot llc lAVA, trend 
xtunitroot llc lPGR, trend

/*xtunitroot ips variable (IPS) */
xtunitroot ips lGDPC 
xtunitroot ips lCO2 
xtunitroot ips lFP 
xtunitroot ips lAVA 
xtunitroot ips lPGR
 
/*xtunitroot ips variable, trend (IPS with trend) */
xtunitroot ips lGDPC, trend 
xtunitroot ips lCO2, trend 
xtunitroot ips lFP, trend 
xtunitroot ips lAVA, trend 
xtunitroot ips lPGR, trend
```

And the results is as shown in the [table](https://github.com/user-attachments/assets/e1136de7-15df-40af-8db7-37d128d45ec7) below which reveal a mix of stationary [I(0)] and non-stationary [I(1)] , with 
the dependent variable GDPC being integrated of order 1 [I(1)] . This indicates that the panel data is non-stationary, 
making the Panel ARDL method suitable for assessing both short-term and long-term effects.
![Screenshot 2024-11-22 171715](https://github.com/user-attachments/assets/e1136de7-15df-40af-8db7-37d128d45ec7)

## Co‑integration test
The panel ARDL method is a co-integration procedure in panel data analysis [^9]. A a detailed explanation of the Pedroni cointegration test for panel data is provided in [^10]. This test checks for the presence of a long-term dynamics in the [empirical model](README.md#empirical-model). Estimates of the long-run relationship are computed by the panel ARDL Error Correction Model (EMC). The panel ARDL ECM is given as
```math
\begin{align}
	\begin{split}
		\Delta \ell\text{GDPC}_{it} =& \alpha + \sum_{k=1}^{p}\beta_{1k}\Delta\ell\text{GDPC}_{i,t-k} + \sum_{k=0}^{p}\beta_{2k}\Delta\ell\text{CO2}_{i,t-k} + \sum_{k=0}^{p}\beta_{3k}\Delta\ell\text{FP}_{i,t-k}\\
		& + \sum_{k=0}^{p}\beta_{4k}\Delta\ell\text{AVA}_{i,t-k} + \sum_{k=0}^{p}\beta_{5k}\Delta\ell\text{PGR}_{i,t-k} + \delta_{1}\ell\text{GDPC}_{i,t-1}\\
		&+ \delta_{2}\ell\text{CO2}_{i,t-1} + \delta_{3}\ell\text{FP}_{i,t-1} + \delta_{4}\ell\text{AVA}_{i,t-1} + \delta_{5}\ell\text{PGR}_{i,t-1} + \mu_{it},
	\end{split}
\end{align}
```
where for $i=1,\ldots,N$ number of countries,  and year $t=1,\ldots,T$, $\alpha$ is the drift term (constant + trend), $\beta$ is the short-term dynamics, $\delta$, the long-term dynamics, $m$ is the number of lagged differences in dependent variable $\ell$GDPC and $\mu_{it}$ the white noise error. The statistical hypotheses of the Pedroni co-integration test are No co-integration (null hypothesis) and co-integration (alternative hypothesis). When the test is statistically significant, we conclude the presence of co-integration and reject the null hypothesis H$_0$, thus when the $p$-value is less than or equal to the significant level.

In the presence of co-integration, we can obtain the long-term coefficients $\beta_i$ from the model:
```math
\begin{align}
	\begin{split}
		\ell\text{GDPC}_{it} =& \alpha + \sum_{k=1}^{p}\beta_{1k}\ell\text{GDPC}_{i,t-k} + \sum_{k=0}^{p}\beta_{2k}\ell\text{CO2}_{i,t-k} + \sum_{k=0}^{p}\beta_{3k}\ell\text{FP}_{i,t-k}\\
		& + \sum_{k=0}^{p}\beta_{4k}\ell\text{AVA}_{i,t-k} + \sum_{k=0}^{p}\beta_{5k}\ell\text{PGR}_{i,t-k} +  \mu_{it}
	\end{split}
\end{align}
```
and for short-run relationship coefficients, we have:
```math
\begin{align}
	\begin{split}
		\Delta \ell\text{GDPC}_{it} =& \alpha + \sum_{k=1}^{p}\beta_{1k}\Delta\ell\text{GDPC}_{i,t-k} + \sum_{k=0}^{p}\beta_{2k}\Delta\ell\text{CO2}_{i,t-k} + \sum_{k=0}^{p}\beta_{3k}\Delta\ell\text{FP}_{i,t-k}\\
		& + \sum_{k=0}^{p}\beta_{4k}\Delta\ell\text{AVA}_{i,t-k} + \sum_{k=0}^{p}\beta_{5k}\Delta\ell\text{PGR}_{i,t-k} + \delta_{1}\ell\text{GDPC}_{i,t-1} + \lambda ECM_{it}
	\end{split}
\end{align}
```
where $\lambda$ is the error correction estimate, which estimates the speed of adjustment to long-run equilibrium and requires a negative statistically significant value for stability.

The following Stata Codes were used:
```Stata
/* Co-integration Analysis */
xtcointtest pedroni lGDPC lCO2 lFP lAVA lPGR
```

Results of ARDL bounds test to check for co-integration is showed in [table](https://github.com/user-attachments/assets/fc3d41aa-19f0-4106-87b2-f8e74157e2b7) below. With p - value less than 0.05 for the 
tests, it is sufficient to reject the null hypothesis in Co-integration test and conclude that there exists co-integration. 
In the presence of co-integration, the model can examine both the long- and short-run dynamics, enabling the esti
mation of long-term equilibrium relationships and short-term adjustments
![Screenshot 2024-11-22 173626](https://github.com/user-attachments/assets/fc3d41aa-19f0-4106-87b2-f8e74157e2b7)

##  ARDL individual lag selection
The unrestricted VectorAuto-Regressive(VAR) model indicate the optimal lag length order of each variable. See [^1] for detailed explanation.
```Stata
/* ARDL Individual Lag Selection */
forval i = 1/14{
ardl lGDPC lCO2 lFP lAVA lPGR if (country==`i'), maxlag ( 2 2 2 2 2 )
matrix list e(lags)
di
}
```
This was chosen based on the most frequently occurring lag order across the countries. The optimal lag for the panel was (1,1,0,0,0).

## Hausman MG tests
The Hausman MG test, proposed by [^11], is a statistical tool used to determine the appropriateness of using a Mean Group, Pooled Mean Group, or Dynamic Fixed Effects estimators in panel data analysis. The Hausman MG test is a comparison between a consistent estimator (MG) and an efficient estimator (PMG), with the null hypothesis that the efficient estimator (PMG) is appropriate. If the null hypothesis is rejected, another test is needed between MG (consistent) and DFE (efficient) with the new null hypothesis suggesting that the DFE model is more appropriate. The test works by comparing the variance of the panel ARDL models with a chi-square $\chi^{2}$ distributed test statistic H given as:
```math
H = (\beta_{con}-\beta_{eff})^{'}(V_{con}-V_{eff})(\beta_{con}-\beta_{eff})
```
where $\beta_{con}$ and $\beta_{eff}$ are the coefficient vectors from the consistent and efficient estimators, and $V_{con}$ and $V_{eff}$ are the covariance matrix of the consistent and efficient estimator, respectively.

The Hausman test results revealed the most robust estimator for the panel data analysis. The first test between MG and PMG revealed a significant p -value (0.0000)[^1] which lead to the rejection of homogeneity, making the PMG model unsuitable.
```Stata
/* Hausman MG Test */
xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace mg

xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace pmg

hausman mg pmg, sigmamore
```

The second Hausman test between MG and DFE revealed a p-value(0.7105) more than 0.05 , hence we fail to reject the null hypothesis and conclude that the DFE estimator is the most appropriate choice.
```Stata
/* Hausman MG Test */
xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace mg

xtpmg d.lGDPC d.lCO2 d.lFP d.lAVA d.lPGR, lr(l.lGDPC lAVA lFP lCO2 lPGR) 
ec(ECT) replace dfe

hausman mg DFE, sigmamore
```



 
## References
[^1]: Frimpong, T.D., Atchadé, M.N. & Tona Landu, T. Assessing the impact of CO2 emissions, food security and agriculture expansion on economic growth: a panel ARDL analysis. Discov Sustain 5, 424 (2024). https://doi.org/10.1007/s43621-024-00630-7
[^2]: World Bank, Climate Change Knowledge Portal(2024), 2024. https://climateknowledgeportal.worldbank.org/, Accessed 10 May 2024.
[^3]: World Bank, World Development Indicators (2024), World Bank, 2024. https:// datab ank. world bank. org/ source/ world- devel opment- indic 
ators. Accessed 11 May 2024.
[^4]: Feng C, Hongyue W, Lu N, Chen T, He H, Lu Y, Tu X. Log-transformation and its implications for data analysis. Shanghai Arch Psychiatr. 2014;26:105–9. https://doi.org/10.3969/j.issn.1002-0829.2014.02.009.
[^5]: Dickey D, Fuller W. Distribution of the estimators for autoregressive time series with a unit root, JASA. J Am Stat Assoc. 1979. https://doi. org/10.2307/2286348.
[^6]: Barbieri L. Panel unit root tests: a review, Serie Rossa: Economia - Quaderno N. 2005;43.
[^7]: Levin A, Lin C-F, Chu C-SJ. Unit root tests in panel data: asymptotic and finite-sample properties. J Econom. 2002;108(1):1–24.
[^8]: Im KS, Pesaran MH, Shin Y. Testing for unit roots in heterogeneous panels. J Econom. 2003;115(1):53–74.
[^9]: Muchapondwa E, Pimhidzai O. Modelling international tourism demand for zimbabwe. Int J Busand soc Sci. 2011;2(2):71.
[^10]: Pedroni P. Panel cointegration; asymptotic and finite sample properties of pooled time series tests, with an application to the ppp hypothesis. Econom Theory. 2004;20:597–625. https://doi.org/10.1017/S0266466604203073
[^11]: J. A. Hausman, Specification tests in econometrics, Econometrica: Journal of the econo
metric society (1978) 1251–1271
