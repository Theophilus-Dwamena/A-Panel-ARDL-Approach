# A-Panel-ARDL-Approach [^1]
We aim to examine the effects of CO2 emissions, agricultural advancements, and food availability on economic growth in West Africa from 1990 to 2020,  using a panel ARDL approach with data from 14 countries. [R Programming](Theophilus-Dwamena/A-Panel-ARDL-Approach/RCode) language was used to explore the data and Stata was used for the panel ARDL analysis. The analysis evaluates both long- and short-term effects. The data utilized for this study is secondary data for fourteen West African countries and was sourced from the World Bank’s Climate Change Knowledge Portal(CCKP) [^2] and World Development Indicators (WDI) database [^3]. The dependent variable is the GDPC. The natural logarithm transformation was applied to the variables using the formula y = ln(x) , where x is the original variable value and y is the transformed value. This transformation controlled the influence of extreme values [^4].

[here](myLib/README.md)
https://github.com/Theophilus-Dwamena/A-Panel-ARDL-Approach
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


/* Panel Unit Root Test*/
xtunitroot llc variable            /* LLC */
xtunitroot llc variable, trend     /* LLC  with trend*/
xtunitroot ips variable            /* IPS */ 
xtunitroot ips variable, trend     /* IPS with trend */



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
