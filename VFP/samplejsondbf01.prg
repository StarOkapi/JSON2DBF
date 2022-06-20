CLEAR

loJson2DBF=newobject("ClassJson2DBF","ClassJson2DBF.prg")

*-Api Publicas--
*-https://mixedanalytics.com/blog/list-actually-free-open-no-auth-needed-apis/
lcRest=loJson2DBF.process("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false","TmpCoin")

?lcRest

IF USED("TmpCoin")

	BROWSE 

ENDIF 

lcRest=loJson2DBF.process("http://www.7timer.info/bin/api.pl?lon=113.17&lat=23.09&product=astro&output=json","Tmp7timer")
?lcRest

IF USED("Tmp7timer")

	BROWSE 

ENDIF 


lcRest=loJson2DBF.process("https://datausa.io/api/data?drilldowns=Nation&measures=Population","TmpDataUSA")
?lcRest

IF USED("TmpDataUSA")

	BROWSE 

ENDIF 

lcRest=loJson2DBF.process("https://api.openbrewerydb.org/breweries","TmpOpen")
?lcRest

IF USED("TmpOpen")

	BROWSE 

ENDIF 


lcRest=loJson2DBF.process("http://api.zippopotam.us/us/90210","TmpZIP")
?lcRest

IF USED("TmpZIP")

	BROWSE 

ENDIF 


lcRest=loJson2DBF.process("https://date.nager.at/api/v2/publicholidays/2022/US","TmpHoliday")
?lcRest

IF USED("TmpHoliday")

	BROWSE 

ENDIF 

lcRest=loJson2DBF.process("https://rickandmortyapi.com/api/character/?page=20","Tmprickandmorty")
?lcRest
*https://rickandmortyapi.com/api/character/avatar/1.jpeg
IF USED("Tmprickandmorty")

	BROWSE 

ENDIF 



**--Más de 14.000 Reg---
lcRest=loJson2DBF.process("https://house-stock-watcher-data.s3-us-west-2.amazonaws.com/data/all_transactions.json","TmpStock")
?lcRest

IF USED("TmpStock")

	BROWSE 

ENDIF 