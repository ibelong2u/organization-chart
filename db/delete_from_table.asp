<html>

<head> <title> Deleting from table... </title> </head>

<body>
       deleting an employee <br>

<%
   
   Dim adoCon   
   Dim strSQL
   
   Set adoCon = Server.CreateObject("ADODB.Connection")

   'sConnection = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
    '          "Data Source=\\genfs2\www40\cpsc431\db\team2.mdb" & ";" & _
     '         "Persist Security Info=False"

	sConnection = "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"

   'adoCon.Open "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("team2.mdb")
   adoCon.Mode = 3
   adoCon.Open(sConnection)


   strSQL = "DELETE FROM "&Request.Form("projects")&" WHERE Name = '"&Request.Form("supervisor")&"';" 
    
   adoCon.execute(strsql)
   Set adoCon = Nothing
 %>

<br> <br> ...Done! 

<% Response.Redirect("http://iis.cs.tamu.edu/cpsc431/default.asp") %>
</body>
</html>
