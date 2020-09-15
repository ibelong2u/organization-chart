<html>

<head> <title> Updating table... </title> 



</head>

<body>
       Info for <%Response.Write(Request.Form("cname"))%><br>

<%
   
    Dim savecode
    
	Dim adoCon    
	Dim rs
	Dim rs1
	Dim strSQL	
	Set adoCon = Server.CreateObject("ADODB.Connection")
	adoCon.Open "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"
	Set rs = Server.CreateObject("ADODB.Recordset")
	Set rs1 = Server.CreateObject("ADODB.Recordset")
	
	strSQL = "SELECT * FROM "&Request.Form("projects")&" WHERE Name = '"&Request.Form("cname")&"';"
	rs.Open strSQL, adoCon
	
	strSQL = "SELECT * FROM "&Request.Form("projects")&";"
	rs1.Open strSQL, adoCon	
	
	
%>

<form name="form" action="updating.asp" method="post" ID="Form1">
				  <input maxlength="10" value=<%Response.Write(Request.Form("projects"))%> name="projects" READONLY="true" type="hidden"/> 
				  <input maxlength="20" value=<%Response.Write(rs("name"))%>               name="name" ID="name" type="hidden"/> 
Project Position: 
	<% If rs("projectposition")="Manager" then %>
				  <input maxlength="10" value=<%Response.Write(rs("projectposition"))%>    name="projectPosition" ID="projectPosition" readonly=true/>
	<% Else %>
				  <input maxlength="10" value=<%Response.Write(rs("projectposition"))%>    name="projectPosition" ID="projectPosition"/>
    <% End If %>
	   
<br/>Job Title:   <input maxlength="10" value=<%Response.Write(rs("jobTitle"))%>           name="jobtitle" ID="jobTitle"/> 

	<% If rs("supervisor")<>"null" then %>
<br/>Current Supervisor:  <input value=<%Response.Write(rs("supervisor"))%>                name="supervisor" id="supervisor" readonly="true"/>   To change supervisor, select the new supervisor here: 

<select ID="mySelect"> <% rs1.MoveFirst %> <br> <% Do While not rs1.EOF %> <br> <% If rs1("name")<>rs("name") then %> <option> <%Response.Write (rs1("name")) %> </option> <% End If %> <br> <% rs1.MoveNext %> <br> <% Loop %> </select>			

 <input type=button value="Change" onclick="javascript: document.getElementById('supervisor').value = document.getElementById('mySelect').options[document.getElementById('mySelect').selectedIndex].text">

	<% Else %>
	
	<input maxlength="10" value=<%Response.Write(rs("supervisor"))%>  name="supervisor" type="hidden"/> 

	<% End If %>
	
<br/>Phone:       <input maxlength="15" value=<%Response.Write(rs("phone"))%>  name="phone" ID="phone"/>
<br/>Office:      <input maxlength="4"  value=<%Response.Write(rs("office"))%> name="office" ID="office"/> 
<br/>E-Mail:      <input maxlength="40" value=<%Response.Write(rs("email"))%>  name="email" ID="mail"/> 

<br/><br/>
	
<input type="submit" value="Update Changes" name="Submit" ID="Submit3"/> 
<input id="Reset2" type="reset" value="Reset to original values" name="Reset1"/> 

</form>		


	
<%		
	rs.Close
    Set rs = Nothing
    Set adoCon = Nothing	

%>

<input type="button" value="Go Back without updating any values" onclick="javascript: history.back();"/>

</body>
</html>
