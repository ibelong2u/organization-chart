<html>
	
	<head> <title> Making changes </title></head>

	<body>
		<%
			Dim adoCon     
			Dim strSQL
			Set adoCon = Server.CreateObject("ADODB.Connection")
			adoCon.Open "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET PROJECTPOSITION='"&Request.Form("projectposition")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET JOBTITLE='"&Request.Form("jobtitle")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET SUPERVISOR='"&Request.Form("supervisor")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET PHONE='"&Request.Form("phone")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET OFFICE='"&Request.Form("office")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			strSQL = "UPDATE "&Request.Form("projects")&" SET EMAIL='"&Request.Form("email")&"' WHERE Name='"&Request.Form("name")&"'"
			Response.Write strSQL + "<br>"
			adoCon.execute strSQL
			
			Set adoCon = Nothing
			
			Response.Redirect("http://iis.cs.tamu.edu/cpsc431/default.asp")
			
		%>


	</body>



</html>