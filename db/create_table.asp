<html> <head> <title> Creating a New Table </title> </head>

<body>  creating a new table <br>

<%   
   Dim adoCon   
   Dim strSQL
   
   Set adoCon = Server.CreateObject("ADODB.Connection")

   'sConnection = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
    '          "Data Source=\\genfs2\www40\cpsc431\db\team2.mdb" & ";" & _
    '          "Persist Security Info=False"
   
   sConnection = "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"
   
   adoCon.Mode = 3
   adoCon.Open(sConnection)

   strSQL = "CREATE TABLE "&Request.Form("pName")&" (empID integer not null generated always as identity (start with 0, increment by 1, no cache) primary key, Name varchar(20), projectPosition varchar(10), jobTitle varchar(10), supervisor varchar(20), phone varchar(15), office varchar(5), email varchar(20), tag varchar(10));"
   adoCon.execute(strSQL)

   strSQL = "INSERT INTO projects (projectName) VALUES ('"&Request.Form("pname")&"');"
   adoCon.execute(strSQL)

   strSQL = "INSERT INTO "&Request.Form("pName")&" (Name, projectPosition, jobTitle, supervisor, phone, office, email) VALUES ('"&Request.Form("name")&"','Manager','"&Request.Form("jobTitle")&"','null','"&Request.Form("phone")&"', '"&Request.Form("office")&"', '"&Request.Form("email")&"');"
   adoCon.execute(strsql)
 
   Set adoCon = Nothing
 %>

<br> <br> ...Done!

<% Response.Redirect("http://iis.cs.tamu.edu/cpsc431/default.asp") %>

</body>
</html>

