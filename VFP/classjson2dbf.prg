*------------------------------------------------------------------** 
* Funcion.......: ClassJson2DBF 
* Devuelve......: 
* Autor.........: ERIC ZBRUN 
* Fecha.........: 2022-06
* Version.......: 1.0 
* Parametros....:  
* Notas.........: Pasar de JSON a DBF
* Notas.........: Utilizo WinHttp.WinHttpRequest.5.1
* Notas.........: Utilizo ConvertJson2XML (hecho en C#)

DEFINE CLASS ClassJson2DBF as Custom 

	cCursor=""

	FUNCTION init 
		*--Nothing	
	ENDFUNC 

	FUNCTION Process(tcURL as String,tcCursor as String) 

		*SET STEP on 

		*--Var--
		LOCAL lnCant as Number,lcXMLTransfo as String,lnPos as Number,lcRet as String   
		STORE 0 TO lnCant,lnPos
		lcXMLTransfo=""
		lcRet="-"

		*--Ctrl--
		IF EMPTY(tcURL)
			RETURN("Falta URL "+tcURL)
		ENDIF 

		IF EMPTY(tcCursor)
			tcCursor="Tmp"+SYS(2015)
		ENDIF 
		this.cCursor=tcCursor
				
		*--Proc--
		WAIT WINDOW "Process..." NOWAIT 

		lcResult = this.QueryAPI(tcURL)

		*? lcResult 

		STRTOFILE('{"reg": ['+lcResult + ']}'  ,"file.json")
		*STRTOFILE(lcResult ,"file.json")

		*RUN /N ConvertJson2XML.exe
		
		THIS.RunExtAPP("ConvertJson2XML.exe")
		

		DO WHILE lnCant <=500
			
			lnCant=lnCant + 1
			
			IF FILE("Tmpfile.xml")
			
				lcXMLTransfo=FILETOSTR("Tmpfile.xml")
			
				lcXMLTransfo=STRTRAN(lcXMLTransfo,"<reg>","",1,1)
				
				lnPos=RAT("</reg>",lcXMLTransfo)
				
				 IF lnPos > 1
				 
				 	lcXMLTransfo=SUBSTR(lcXMLTransfo,1,lnPos-1)+"</VFPData>"
				 
				 ENDIF 
						
				STRTOFILE(lcXMLTransfo,"Tmpfile2.xml")
			
				XMLTOCURSOR("Tmpfile2.xml",tcCursor,512)
				
				lnCant=501
				
			ENDIF 

		ENDDO 

		IF USED(tcCursor)
			SELECT (tcCursor)
			*BROWSE 
			*USE 
			DELETE File "Tmpfile.xml"
			
			GO TOP 
			IF EOF()
				lcRet="Sin Datos -"+tcCursor
			ELSE
				lcRet="Hay Datos -"+tcCursor
			ENDIF 
		ENDIF 
		
		
		WAIT CLEAR 
		
		RETURN(lcRet)
	
	
	ENDFUNC 


	*--Buscar API---
	*--+info https://docs.microsoft.com/en-us/windows/win32/winhttp/what-s-new-in-winhttp-5-1
	FUNCTION QueryAPI(tcUrl, tcAcc)

		*--VAR--
		LOCAL loWinHttp as object,lcRet as String

		*---CTRLs--
		IF EMPTY(tcUrl) 
		   RETURN .F.
		ENDIF
		
		IF EMPTY(tcAcc)
		   tcAcc= "GET"
		ENDIF
		
		*--Proc---
		loWinHttp = CREATEOBJECT("WinHttp.WinHttpRequest.5.1")    

		loWinHttp.Open(tcAcc, tcUrl,.F.)

	  	loWinHttp.Send()	

		lcRet = loWinHttp.ResponseText

		loWinHttp = NULL

		*--Ret--
		RETURN lcRet 
		
	ENDFUNC

	*--Ejecutar APP externas--	
	FUNCTION RunExtAPP(tcFileAPP as String)

		*--Var--
		LOCAL loWShell AS Object 
		loWShell=NULL 
		
		*--Ctrl--
		IF !FILE(tcFileAPP)
			RETURN (.F.)
		ENDIF 

	    *--- Ejecuta APP ---
	    loWShell = createobject("WScript.Shell")
	    
	    loWShell.Run(tcFileAPP,0,.T.)
	    
	    RELEASE loWShell
	    
	    *-----
	    
		
	ENDFUNC 

ENDDEFINE 