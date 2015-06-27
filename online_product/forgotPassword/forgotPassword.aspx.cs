using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Text;

public partial class projects_forgotPassword : System.Web.UI.Page
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            captcha();
        }
        
    }

    private string RandomString(int size, bool lowerCase)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch, no;
        int cnt = 1;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            no = Convert.ToChar(Convert.ToInt32(Math.Floor(9 * random.NextDouble() + 48)));
            if (cnt == 1)
            {
                builder.Append(ch.ToString().ToLower());
                cnt = 0;
            }
            else
            {
                builder.Append(ch.ToString().ToUpper());
                cnt = 1;
            }
            builder.Append(no);
        }
        //if (lowerCase)
        //return builder.ToString().ToLower();
        builder = builder.Replace("0", "q");
        builder = builder.Replace("o", "q");
        builder = builder.Replace("O", "q");
        return builder.ToString();
    }


    private void captcha()
    {

        int ImageWidth = 103; // 150 with source text
        int ImageHeight = 33;
        //string alpha ="AbCdE"; 
        //int numbers =  ;
        //string[] Words = { "mJyUb5", "KiR6yJ", "z9dTY9", "hjUtY6", "HTnJy4", "hyK9bh", "u975hK", "45MhuF", "uytdH6", "p9R7g3", "utFKu8", "8f456K", "hJgYu5", "jIgRA5t", "rA78Je", "58yU4K", "HuLL3Y" };
        // Random MyRand = new Random();
        // int RandomMunber = MyRand.Next(0, Words.Length - 1);
        Session["cIaptTchaS"] = "";
        Session["cIaptTchaS"] = RandomString(3, true);
        string TextToCreate = Session["cIaptTchaS"].ToString();

        Brush ObjBrush = Brushes.Black;
        HatchBrush myBrush = new HatchBrush(HatchStyle.Percent05, Color.DarkGreen, Color.White);
        Pen myPen = new Pen(myBrush, 3);
        Font ObjFont = new Font("Bradley Hand ITC", 18, FontStyle.Bold);
        //Font ObjFontCopyright = new Font("Tahoma", 8, FontStyle.Regular);


        Bitmap ObjBitmap = new Bitmap(ImageWidth, ImageHeight);
        Graphics ObjGraphics = Graphics.FromImage(ObjBitmap);

        //ObjGraphics.Clear(Color.White);

        ObjGraphics.FillRectangle(myBrush, 0, 0, ImageWidth, ImageHeight);
        //ObjGraphics.DrawLine(myPen, 1, ImageHeight - 20, ImageWidth - 5, ImageHeight - 12);
        //ObjGraphics.DrawLine(myPen, 1, ImageHeight - 10, ImageWidth - 5, ImageHeight - 2);

        ObjGraphics.DrawString(TextToCreate, ObjFont, ObjBrush, 1, 1);
        //ObjGraphics.DrawString("source : mywebsitename.com", ObjFontCopyright, ObjBrush, 1, 29);
        ObjGraphics.SmoothingMode = SmoothingMode.AntiAlias;
        ObjGraphics.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAliasGridFit;
        //SizeF mySize = ObjGraphics.MeasureString(TextToCreate, ObjFont);

        //Response.ContentType = "image/Jpeg";
        //ObjBitmap.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        ObjBitmap.Save(Server.MapPath("Captcha\\captcha.Jpeg"), System.Drawing.Imaging.ImageFormat.Jpeg);
        
		Image1.ImageUrl = "Captcha\\captcha.Jpeg";
		
        ObjGraphics.Dispose();
        ObjBitmap.Dispose();
        myPen.Dispose();
        ObjFont.Dispose();
    }
	/** Checks User Category for eProjects enabled users not to send credentials. Returns bool. Added on 12/05/13 by Muthu **/
	public bool isEProjectsEnabled(String loginId){
		string strConn = ConfigurationManager.ConnectionStrings["cdcConnectionString"].ConnectionString;

        SqlConnection objConn  = null;		
		SqlCommand objCmd = null;
        SqlDataReader sreader = null;
		bool exist = false;
		String sql = null;
		try{
			objConn = new SqlConnection(strConn);
			objConn.Open();
			
			//Check User Category 
			sql = "SELECT  LOGIN_ID  FROM UC_FEATURES B"
				+" INNER JOIN UC_CATEGORY_FEATURE A ON  A.FEATURE_ID = B.FEATURE_ID "
				+" INNER JOIN USER_CATEGORY C ON A.CATEGORY_ID = C.CATEGORY_ID "
				+" AND B.FEATURE_TYPE='M' "
				+" AND B.FEATURE_NAME='EPROJECTS' "
				+" AND A.FEATURE_VALUE=1  "
				+" AND LOGIN_ID = '"+loginId+"'";
		
			objCmd  = new SqlCommand(sql, objConn);
			sreader = objCmd.ExecuteReader();
			if (sreader.Read())
			{
				exist = true;
			}
		}
		catch(Exception ex){
			exist = false;
			Response.Write(ex.Message);
		}
		finally{
			try{
				if(sreader!=null) sreader.Close();
				if(objConn!=null) objConn.Close();
			}
			catch(Exception ex){
				Response.Write(ex.Message);
			}
		}
		return exist;
	} //End of isEProjectsEnabled

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        //string strConn = "Data Source=209.92.70.195;Initial Catalog=cdc;User ID=cdc1;Password=sailing";
        string strConn = ConfigurationManager.ConnectionStrings["cdcConnectionString"].ConnectionString;

        SqlConnection objConn = new SqlConnection(strConn);
        objConn.Open();
		string Psw,first_name,login_id1 = "",shipto_number = "";
		string vCode = "";
        string BFormatt = "";
        string Mailformatt = "",email="";
        SqlCommand objCmd,objCmd1;
		DataSet ds = null;	//Added by Muthu to find rowCount on 12/05/13.
		SqlDataAdapter adapter = null;
        SqlDataReader sreader1;
        string mailfrom = "";
        string mailto = "";
        try
        {

            //bool val = Captchaa.Validate(tbCaptcha.Value.Trim());
            if (Session["cIaptTchaS"].ToString().ToLower() != tbCaptcha.Value.ToLower())
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('You did not match the image text. Please enter correct text');</script>");
                tbCaptcha.Value = "";
                //captcha();
            }
            else
            {          
         
                string Email = tbEmail.Value.Trim();
                string sql = "";
                
				sql = "Select login_id, password, email, first_name, subscriber_type, shipto_number,email_flag FROM  subscriber where email = '" + tbEmail.Value + "' ";

				ds = new DataSet ();
				adapter = new SqlDataAdapter(sql,objConn );
				adapter.Fill(ds);
                //objCmd  = new SqlCommand(sql, objConn);
                //sreader = objCmd.ExecuteReader();
                vCode = "none"; 
                if (ds.Tables[0].Rows.Count > 0)
                {
					//Reads First Row
					DataRow sreader = ds.Tables[0].Rows[0];			
					if(ds.Tables[0].Rows.Count > 1)
                        vCode = "more";
					else if(isEProjectsEnabled(sreader["login_id"].ToString()) && Convert.ToBoolean(sreader["email_flag"])==false)	//Added on 12/03/13 for eData.
						vCode = "none";						
                    else if(sreader["subscriber_type"].ToString() == "emp" || sreader["subscriber_type"].ToString() == "sample" || sreader["subscriber_type"].ToString() == "trial" || sreader["subscriber_type"].ToString() == "icn_trial")
                        vCode = "type";
                    else
                    {
                        vCode = "yes";
                        
                        BFormatt = BFormatt + "<TABLE border='0' cellspacing='0' cellpadding='5' style='font-size:small;font-family:MS Sans Serif' >";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Dear&nbsp;&nbsp;" + sreader["first_name"].ToString() + ",</TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Here is the password you requested   </TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Password &nbsp;&nbsp;         :&nbsp;&nbsp;" + sreader["password"].ToString() + " </TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Your Login id is &nbsp;&nbsp; :&nbsp;&nbsp;" + sreader["login_id"].ToString() + ", &nbsp;&nbsp;your customer number is &nbsp;&nbsp;" + sreader["shipto_number"].ToString() + "</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='4' >&nbsp;&nbsp;If you would like to see additional territories call your sales associate at 800-652-0008. </TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Thank you for using CDCNews.com. </TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Sincerely,</TD><td>&nbsp;</td></TR>";
                        BFormatt = BFormatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;CDC News. </TD><td>&nbsp;</td></TR>";

						login_id1 = sreader["login_id"].ToString();
						Psw = sreader["password"].ToString();
						shipto_number = sreader["shipto_number"].ToString();
						first_name = sreader["first_name"].ToString();
                        email = sreader["email"].ToString();

                        mailfrom  = ConfigurationSettings.AppSettings["postmaster_mail"].Trim();
                        //postmaster_mail - frm web config key value
                        EmailClass.eClass(email, mailfrom, "Password Request", BFormatt);
                        //EmailClass.eClass("murali@tentsoftware.com", mailfrom, "Password Request", BFormatt);
						//sreader.Close();
						
			sql = "select emp.email as ac_mail,emp.first_name as emp_name, sub.first_name, sub.last_name,sub.email as mail_to from subscriber emp, subscriber sub, emp_states es, emp_class ec, emp_alpha_range ea  where emp.login_id = es.emp_id and emp.login_id = ec.emp_id and emp.login_id = ea.emp_id and emp.company_name = 'cdc' and emp.subscriber_type = 'emp' and emp.enable = 'yes' and  sub.subscriber_type in ('normal','icn_trial','icn_plans','icn_news','icn_all') and sub.enable = 'yes' and left(sub.company_name,ea.from_alpha_size) >= ea.from_alpha and  left(sub.company_name,ea.to_alpha_size)  <= ea.to_alpha  and sub.state = es.state and ec.emp_class = 'AM' and sub.login_id ='" + login_id1 + "'";
                        
                        
                        objCmd1 = new SqlCommand(sql, objConn);
                        sreader1 = objCmd1.ExecuteReader();   
					       
					 if (sreader1.Read())
					 {
                         mailto = sreader1["ac_mail"].ToString();
                        Mailformatt = Mailformatt + "<TABLE border='0'cellspacing='0' cellpadding='5' style='font-size:small;font-family:MS Sans Serif' >";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >Dear&nbsp;&nbsp;" + sreader1["emp_name"].ToString() + "</TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;The subscriber in your account has requested for password using Forgot Password section of the website.  </TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Here are the details of the subscriber: </TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Name&nbsp;&nbsp;:  &nbsp;&nbsp;" + first_name + " </TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Login Id&nbsp;&nbsp;:  &nbsp;&nbsp;" + login_id1 + " </TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Password&nbsp;&nbsp;:   &nbsp;&nbsp;" + Psw + " </TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Email&nbsp;&nbsp;: &nbsp;&nbsp;" + sreader1["mail_to"].ToString() + " </td><td>&nbsp;</td></tr>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Customer number&nbsp;&nbsp;:&nbsp;&nbsp;" + shipto_number + " </td><td>&nbsp;</td></tr>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Sincerely,</TD><td>&nbsp;</td></TR>";
                        Mailformatt = Mailformatt + "<TR ><TD  colspan='1' >&nbsp;&nbsp;Postmaster, CDCNews.com</TD><td>&nbsp;</td></TR>";

                        //EmailClass.eClass("preethi@tentsoftware.com", mailfrom, "Subscriber Requested Password", Mailformatt);
                        EmailClass.eClass(mailto, mailfrom,"Subscriber Requested Password", Mailformatt);
                        
                     }
                     sreader1.Close();

    				} 
                   
                 
                    tbEmail.Value = "";
                }	// sreader.read
                
                //sreader.Close();
               
                captcha();

                Response.Redirect("ForgotPasswordMessage.aspx?verifyCode="+vCode);

            }	//	val == false
        }

        catch (Exception ex)
        { 
			Response.Write(ex.Message);
        }

    }
}
