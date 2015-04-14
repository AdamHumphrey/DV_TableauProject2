require("RCurl")
require("jsonlite")
require("plyr")
require("dplyr")
require("tidyr")


df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT AIRFCRAFT_QUANTITY, AIRCRAFT_COMM_CODE, rank() 
OVER (PARTITION BY AIRFCRAFT_QUANTITY order by AIRCRAFT_TRADE_USD) Trade_USD_RANK 
FROM AIRCRAFT_REVISED"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)


df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select AL_COUNTRY_AREA, al_flow, last_value(sal_sum) OVER (PARTITION BY al_flow, al_country_area 
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
"select empno, deptno, sal, nth_value(max_sal, 2) 
OVER (PARTITION BY deptno order by sal
rows between unbounded preceding and unbounded following) max_sal
from
(SELECT empno, deptno, sal, max(sal)
OVER (PARTITION BY deptno order by sal) max_sal 
FROM emp) 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select empno, deptno, sal, cume_dist() 
OVER (PARTITION BY deptno order by sal) cume_dist
from
(SELECT empno, deptno, sal, max(sal)
OVER (PARTITION BY deptno order by sal) max_sal 
FROM emp) 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_das3734', PASS='orcl_das3734', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)