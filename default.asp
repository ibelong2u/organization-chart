<html><head><title>Organization Chart by Team 2</title></head>
<body>
<div align="center"> <font face="Verdana" color="#336699" size="2"><strong>CPSC-431-504&nbsp;&nbsp; |&nbsp;&nbsp; Team-2&nbsp;&nbsp; |&nbsp;&nbsp; Aditya, Brian, Chris, Joe, Sahar</strong> </font>
<br/><br/>
<font color="#330099" size="6">Organization Charts </font>
<br/><br/>

<input type="submit" value="Create a New Project" name="new" onClick="javascript:document.location.href='db/new.htm'" ID="Submit1"/>
<br/><br/>

<font face="Verdana" color="#000000" size="4"><strong>OR </strong></font>
<br/><br/>


<% 

Dim adoCon        
Dim rs  
Dim strSQL   
Set adoCon = Server.CreateObject("ADODB.Connection")
cst = "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"
Set rs = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT * FROM projects;"
adoCon.Open cst
rs.Open strSQL, adoCon
rs.MoveNext
%>

<form name="Form" action="db/view.asp" method="post">
<select id="projects" name="projects" size=5 >

<% 
   Do While not rs.EOF %>
     <option>  
		<% Response.Write (rs("projectName")) %>
     </option>
     <% rs.MoveNext

   Loop			
%>

 </select> <br/><br/>
 <input type="submit" value="View Selected Project" name="Submit"/>
 </form> 

<br> <br>


<form name="Form1" action="db/delete_table.asp" method="post">
<font face="verdana" size="2"> Select the project to be removed: </font>
<select id="projects" name="projects" size=1 >

<% 
   rs.MoveFirst
   rs.MoveNext
   Do While not rs.EOF %>
     <option>  
		<% Response.Write (rs("projectName")) %>
     </option>
     <% rs.MoveNext

   Loop			
   
   rs.Close
   Set rs = Nothing
   Set adoCon = Nothing

%>

 </select>
 <input type="submit" value="Delete Selected" name="Submit"/>
 </form>


 </div>

</body>
</html>

