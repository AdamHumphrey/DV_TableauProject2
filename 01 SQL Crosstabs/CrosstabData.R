require("RCurl")
require("jsonlite")
require("plyr")
require("dplyr")
require("tidyr")


df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT DISTINCT AIRFCRAFT_QUANTITY, AIRCRAFT_COMM_CODE, TRADE_SUM, rank() 
OVER (PARTITION BY AIRFCRAFT_QUANTITY order by TRADE_SUM DESC) Trade_USD_RANK 
FROM (SELECT DISTINCT AIRFCRAFT_QUANTITY, AIRCRAFT_COMM_CODE, SUM(AIRCRAFT_TRADE_USD) OVER 
(PARTITION BY AIRFCRAFT_QUANTITY,AIRCRAFT_COMM_CODE ORDER BY AIRCRAFT_COMM_CODE ) 
TRADE_SUM from AIRCRAFT_REVISED) ORDER BY CAST(AIRFCRAFT_QUANTITY AS INT),2 ASC"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)


df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select distinct AL_COUNTRY_AREA, al_flow, last_value(sal_sum) OVER (PARTITION BY al_flow, al_country_area 
ORDER BY al_trade_usd rows between unbounded preceding and unbounded following) sal_sum, last_value(max_sal) 
OVER (PARTITION BY AL_COUNTRY_AREA, al_flow order by al_trade_usd
rows between unbounded preceding and unbounded following) max_sal, sal_sum - last_value(max_sal) 
OVER (PARTITION BY AL_COUNTRY_AREA, al_flow order by al_trade_usd
rows between unbounded preceding and unbounded following)  sal_diff
from (SELECT AL_COUNTRY_AREA, al_flow, al_trade_usd, Sum(al_trade_usd) 
OVER (PARTITION BY al_flow, al_country_area ORDER BY al_trade_usd 
rows between unbounded preceding and unbounded following) sal_sum, max(AL_TRADE_USD)
OVER (PARTITION BY AL_COUNTRY_AREA, al_flow order by al_trade_usd) max_sal 
FROM ARTICLELEATHER_REVISED) 
order by 1,2"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select AMMO_COUNTRY_AREA, AMMO_YEAR, sal, nth_value(max_sal, 2) 
OVER (PARTITION BY AMMO_YEAR order by sal
rows between unbounded preceding and unbounded following) max_sal
from
(SELECT AMMO_COUNTRY_AREA, deptno, sal, max(sal)
OVER (PARTITION BY deptno order by sal) max_sal 
FROM AMMO_REVISED) 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

# Nth Value with correct SQL from SQL Developer
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT AMMO_COUNTRY_AREA, AMMO_YEAR, AMMO_QUANTITY, nth_value(AMMO_QUANTITY, 2)
OVER (PARTITION BY AMMO_YEAR) max_AMMO_QUANTITY 
FROM AMMO_REVISED
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select distinct ammo_comm_code, ammo_commodity, ammo_flow, sum_trade, cume_dist() 
OVER (Partition By ammo_comm_code order by sum_trade) cume_dist
from
(SELECT ammo_comm_code, ammo_commodity, ammo_flow, sum(ammo_trade_usd)
OVER (PARTITION BY ammo_commodity order by ammo_flow) sum_trade 
FROM ammo_revised) 
order by 1,3,4"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)