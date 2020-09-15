<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Odbc" %>

<%@ Page Language = "C#" Debug="true" %>

<script runat="server">

	static string table;
	static int width = 1000, height=500;
	static Bitmap canvas = new Bitmap(width, height);
	static Graphics chart = Graphics.FromImage(canvas);	
	static Pen blackPen = new Pen(Color.Black, 3);
	static OdbcCommand query;
	static OdbcConnection db;
	static OdbcDataReader rs;	
	static int level=0;    // depth of boxes
	static int mlevel=0;
	static int bcount=0;   // sno. of boxes
	static int[] pos = new int[10];   // box count at level
	
	class box                  
	{
		int x, y, level_box, boxno, babycount=0;
		string name, position;
		int[] destination = new int[5]; 
		public box(int level, int bn, String n, String p)
		{
			level_box=level;
			boxno = bn;
			y = level*100;
			name = n;
			position = p;
		}
		
		public void draw()
		{
			x = (width/2) - (pos[level_box]*220/2) + ((boxno-1)*220);			
			chart.FillRectangle(new SolidBrush(Color.Black), x, y, 200, 50);
			chart.FillRectangle(new SolidBrush(Color.LightYellow),x+4, y+4, 200-8, 50-8);
			Font fontBanner = new Font("Verdana", 10, FontStyle.Bold);
			StringFormat stringFormat = new StringFormat();
			stringFormat.Alignment = StringAlignment.Center; 
			stringFormat.LineAlignment = StringAlignment.Center;
			chart.DrawString(name + "\n("+position+")",fontBanner,new SolidBrush(Color.Black),new Rectangle(x,y,200,50),stringFormat);		
		}
		public void drawConnect(box[] bpp)
		{
				for(int c=0; c<babycount; c++)
				chart.DrawLine(blackPen, x+100, y+50, bpp[destination[c]].getPoint().X, bpp[destination[c]].getPoint().Y);
		}
				
		public Point getPoint()
		{
			return new Point(x+100, y);
		}
		public void connect() 
		{			
			destination[babycount++] = bcount;
		}
		~box()
		{
			//destructor
		}			
	}
	
	int rsCount(string head)
	{
		SQL(head);
		int count = 0;
		while(rs.Read()) count++;
		rs.Close();
		return count;
	}

	void SQL(string head)
	{
		rs.Close();
		string sql = "SELECT * FROM " + table + " WHERE supervisor = \'" + head + "\'" ;
		query = new OdbcCommand(sql,db);
		rs = query.ExecuteReader(); 
	}

    void newLevel(string p, box[] b, box tmp_b)
	{
		int count = rsCount(p);  // no of babies
		int k=0;
		SQL(p);
		string[] baby = new string[count]; // to store names of babies
		string[] job = new string[count];  // to store position of babies
		if(count>0)                          
		{
			for(k=0; k<count; k++)
			{
				rs.Read();
				baby[k] = rs.GetString(1);   // storing baby names
				job[k] = rs.GetString(2);    // storing baby positions
			}
			rs.Close();

			for(k=0; k<count; k++)   // to make boxes for babies
			{
				pos[level]++;	// incrementing box count at this level
				b[bcount] = new box(level,pos[level],baby[k],job[k]);  // creating the box
				tmp_b.connect();  // link baby to parent
				bcount++;
				level++;
				if(mlevel<level)
					mlevel=level;
				newLevel(baby[k],b,b[bcount-1]);
				level--;
			}
		}
	}

	void Page_Load(Object sender, EventArgs e)
	{
		ini();
		db = new OdbcConnection("DRIVER={IBM DB2 ODBC DRIVER}; DATABASE=cpsc431; HOSTNAME=ssi4.cs.tamu.edu; PORT=50000; PROTOCOL=TCPIP; UID=db2admin; PWD=cpsc431");
		db.Open();
	
		string sql = "SELECT * FROM projects WHERE PROJECTNAME=\'myinfo\'";
		query = new OdbcCommand(sql,db);
		rs = query.ExecuteReader();
		rs.Read();
		table=rs.GetString(2);
		rs.Close();
	
		sql = "SELECT * FROM " + table;
		query = new OdbcCommand(sql,db);
		rs = query.ExecuteReader();
        int num=0;   // total number of boxes
		while(rs.Read()) num++;
		rs.Close();
		box[] b = new box[num];
		box tmp = new box(-1,1,"null","null");
		newLevel("null",b,tmp);	

		int max=0;
		for(int m=0; m<10; m++)		
			if(max<pos[m])
				max=pos[m];

		width = max*220;
		height = mlevel*100-50;
		canvas = new Bitmap(width, height);
		chart = Graphics.FromImage(canvas);
		chart.FillRectangle(new SolidBrush(Color.White), 0, 0, width, height);
		
		for(int loop=0; loop<num; loop++)
			b[loop].draw();

		for(int loop=0; loop<num; loop++)
			b[loop].drawConnect(b);
		
		canvas.Save(Response.OutputStream, ImageFormat.Jpeg);  
		chart.Dispose();
		canvas.Dispose();
		db.Close();
	}
	
	void ini()
	{
		level=0;
		mlevel=0;
		bcount=0;
		for(int j=0;j<10;j++)
			pos[j]=0;
	}
		
</script>
