<html>

	<head>
		
		<title> Viewing Table </title>
	</head>

	<body bgcolor="white" text="black">	<div align=center>
	
		<font face="Verdana" size="3"> <B> Organization Chart for <% Response.Write(Request.Form("projects")) %> </B> </font> <br>
		
		<%
			Dim adoCon     
			Dim rs
			Dim rs1
			Dim strSQL

			Set adoCon = Server.CreateObject("ADODB.Connection")
			adoCon.Open "DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431"
			Set rs = Server.CreateObject("ADODB.Recordset")
			Set rs1 = Server.CreateObject("ADODB.Recordset") 
			adoCon.execute("UPDATE projects SET tag='"&Request.Form("projects")&"' WHERE PROJECTNAME='myinfo'")
			strSQL = "SELECT * FROM "&Request.Form("projects")&";"
			rs.Open strSQL, adoCon
			rs1.Open strSQL, adoCon
		%>

	<br> <img src="graphics.aspx" border="0" alt="Organization Chart"> <br> <br>
	<font face="verdana" size=2>
	
	<input type=button value="Add a new Entry" onclick="javascript: document.getElementById('addentry').innerHTML = save_addentry; document.getElementById('addbutton').disabled = true;" id="addbutton"/>
	<p id="addentry"> 
		<form name="form" action="add_to_table.asp" method="post" ID="Form2">
			<input maxlength="10" value=<%Response.Write(Request.Form("projects"))%> name="projects" READONLY="true" ID="Text2" type="hidden"/> 
			Name: <input maxlength="20" name="name" ID="Text3"/> 
			<br/>Project Position: <input maxlength="10" name="projectPosition" ID="Text4"/>
			<br/>Job Title: <input type="text" maxlength="10" name="jobtitle" ID="Text5"/> 
			<br/>Supervisor:  <select name="supervisor" ID="Select2">
				<%	rs.MoveFirst
					Do While not rs.EOF %>
						<option> <% Response.Write (rs("name")) %> </option>
								 <% rs.MoveNext
					Loop                          
				%>
							</select> 
			<br/>Phone: <input maxlength="15" name="phone" ID="Text6"/> 
			<br/>Office: <input maxlength="4" name="office" ID="Text7"/> 
			<br/>E-Mail: <input maxlength="40" name="email" ID="Text8"/> 
			<br/><br/>
			<input type="submit" value="Submit" name="Submit" ID="Submit2"/> 
			<input id="Reset1" type="reset" value="Reset" name="Reset1"/> 
		</form>
	</p>

	<script language="javascript">
	save_addentry = document.getElementById('addentry').innerHTML
	document.getElementById('addentry').innerHTML = ' '
	</script>
	
	<b> Select Name to View/Update: </b>
	<form name="form" action="update_table.asp" method="post">
	<input maxlength="10" value=<%Response.Write(Request.Form("projects"))%> name="projects" READONLY="true" ID="Hidden1" type="hidden"/> 
	<select id="cname" name="cname">
		<% rs.MoveFirst
		   Do While not rs.EOF %>
			<option> <% Response.Write (rs("name")) %> </option>
			         <% rs.MoveNext
		   Loop
		%>	
	</select>
	<input type="submit" value="Submit">
	</form>
	

<p>
<form name="form_d" action="delete_from_table.asp" method="post" ID="Form1">
<B> Select a name to be deleted from the Database: </B>
<input maxlength="10" value=<%Response.Write(Request.Form("projects"))%> name="projects" READONLY="true" type="hidden" ID="Text1"/> 
<select name="supervisor" ID="Select1">
                       <% rs.MoveFirst
                          rs.MoveNext 'to skip manager				  
                          
                          Do While not rs.EOF
								
					rs1.MoveFirst
					rs1.MoveNext								
					
					tag = false
				
					Do While not rs1.EOF
						if rs("name") = rs1("supervisor") then
							tag = true
						end if
						rs1.MoveNext
					Loop			
								
					if tag = false then
					%> <option> <% Response.Write (rs("name")) %> </option>  <%
					End if
					
					rs.MoveNext								
                          Loop

                          rs.Close
                          rs1.Close
                          Set rs = Nothing
                          Set rs1 = Nothing
                          Set adoCon = Nothing   %>
                  </select> 

<input type="submit" value="Delete Selected" name="Submit" ID="Submit1"/> 
</form>
</p>

</font>
<input onclick="javascript: history.back();" type="button" value="Go back" ID="resetb" NAME="resetb"/> 
</div> </body>
</html>
