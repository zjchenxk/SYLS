using System;
using System.Drawing;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.ViewModels;

namespace SYLS.Controllers
{
    /// <summary>
    /// 登录管理控制器
    /// </summary>
    public class LogOnController : BaseController
    {
        public IFormsAuthenticationService FormsService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null)
            {
                FormsService = new FormsAuthenticationService();
            }

            base.Initialize(requestContext);
        }

        /// <summary>
        /// GET登录页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// POST登录页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index(LogOnViewModel model)
        {
            if (ModelState.IsValid)
            {
                //校验验证码
                string strIndentifyCode = string.Empty;
                if (Session["IndentifyCode"] != null)
                {
                    strIndentifyCode = Session["IndentifyCode"].ToString();
                }
                if (model.IndentifyCode.ToLower() == strIndentifyCode)
                {
                    //检查是否已用其它用户登录
                    for (int i = 0; i < Session.Keys.Count; i++)
                    {
                        if (Session.Keys[i] == "LoginAccountId")
                        {
                            return Json(InnoSoft.LS.Resources.Strings.SystemIsInUse);
                        }
                    }

                    //校验帐户名与密码
                    string strErrText;
                    AuthenticateSystem auth = new AuthenticateSystem();
                    Account data = auth.StaffLogin(model.LoginAccount, model.Password, out strErrText);
                    if (data != null)
                    {
                        FormsService.SignIn(model.LoginAccount, false);

                        LoginAccountId = data.Id;
                        LoginStaffName = data.Name;
                        LoginAccountType = data.AccountType;
                        LoginOrganId = data.OrganId;
                        LoginOrganName = data.OrganFullName;
                        LoginStaffId = data.StaffId;
                        LoginStaffName = data.StaffName;

                        return Json(string.Empty);
                    }
                    else
                    {
                        return Json(strErrText);
                    }
                }
                else
                {
                    return Json(InnoSoft.LS.Resources.Strings.WrongIndentifyCode);
                }
            }
            return View(model);
        }

        /// <summary>
        /// GET退出页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult Exit()
        {
            ClearLoginAccount();
            FormsService.SignOut();

            return RedirectToAction("Index", "LogOn");
        }

        #region 校验码图片代码

        private int _length = 4;//验证码长度
        private int _fontSize = 25;//验证码字体大小(为了显示扭曲效果，默认40像素，可以自行修改)
        private int _padding = 2;//边框补(默认1像素)
        private bool _chaos = true;//是否输出燥点(默认不输出)
        private Color _chaosColor = Color.LightGray;//输出燥点的颜色(默认灰色)
        private Color _backgroundColor = Color.White;//自定义背景色(默认白色)
        private Color[] _colors = { Color.Black, Color.Red, Color.DarkBlue, Color.Green, Color.Orange, Color.Brown, Color.DarkCyan, Color.Purple };//自定义随机颜色数组
        private string[] _fonts = { "Arial", "Georgia" };//自定义字体数组
        private string _codeSerial = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";//自定义随机码字符串序列(使用逗号分隔)
        private const double PI = 3.1415926535897932384626433832795;
        private const double PI2 = 6.283185307179586476925286766559;

        /// <summary>
        /// 创建校验码图片
        /// </summary>
        /// <returns></returns>
        public FileContentResult CreateImageCode()
        {
            string code = CreateVerifyCode(4);
            Session["IndentifyCode"] = code.ToLower();
            int fSize = _fontSize;
            int fWidth = fSize + _padding;
            int imageWidth = (int)(code.Length * fWidth) + 4 + _padding * 2;
            int imageHeight = fSize * 2 + _padding;

            System.Drawing.Bitmap image = new System.Drawing.Bitmap(imageWidth, imageHeight);
            Graphics g = Graphics.FromImage(image);
            g.Clear(_backgroundColor);
            Random rand = new Random();

            //给背景添加随机生成的燥点
            if (this._chaos)
            {
                Pen pen = new Pen(_chaosColor, 0);
                int c = _length * 10;

                for (int i = 0; i < c; i++)
                {
                    int x = rand.Next(image.Width);
                    int y = rand.Next(image.Height);

                    g.DrawRectangle(pen, x, y, 1, 1);
                }
            }

            int left = 0, top = 0, top1 = 1, top2 = 1;

            int n1 = (imageHeight - _fontSize - _padding * 2);
            int n2 = n1 / 4;
            top1 = n2;
            top2 = n2 * 2;

            Font f;
            Brush b;
            int cindex, findex;

            //随机字体和颜色的验证码字符
            for (int i = 0; i < code.Length; i++)
            {
                cindex = rand.Next(_colors.Length - 1);
                findex = rand.Next(_fonts.Length - 1);

                f = new System.Drawing.Font(_fonts[findex], fSize, System.Drawing.FontStyle.Bold);
                b = new System.Drawing.SolidBrush(_colors[cindex]);

                if (i % 2 == 1)
                {
                    top = top2;
                }
                else
                {
                    top = top1;
                }

                left = i * fWidth;

                g.DrawString(code.Substring(i, 1), f, b, left, top);
            }

            //画一个边框 边框颜色为Color.Gainsboro
            g.DrawRectangle(new Pen(Color.Gainsboro, 0), 0, 0, image.Width - 1, image.Height - 1);
            g.Dispose();

            //产生波形
            image = TwistImage(image, true, 0, 4);
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            //将图像保存到指定的流
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            return File(ms.GetBuffer(), "image/JPEG");
        }

        /// <summary>
        /// 正弦曲线Wave扭曲图片（Edit By 51aspx.com）
        /// </summary>
        /// <param name="srcBmp">图片路径</param>
        /// <param name="bXDir">如果扭曲则选择为True</param>
        /// <param name="nMultValue">波形的幅度倍数，越大扭曲的程度越高，一般为3</param>
        /// <param name="dPhase">波形的起始相位，取值区间[0-2*PI)</param>
        /// <returns></returns>
        private System.Drawing.Bitmap TwistImage(Bitmap srcBmp, bool bXDir, double dMultValue, double dPhase)
        {
            System.Drawing.Bitmap destBmp = new Bitmap(srcBmp.Width, srcBmp.Height);

            // 将位图背景填充为白色
            System.Drawing.Graphics graph = System.Drawing.Graphics.FromImage(destBmp);
            graph.FillRectangle(new SolidBrush(System.Drawing.Color.White), 0, 0, destBmp.Width, destBmp.Height);
            graph.Dispose();

            double dBaseAxisLen = bXDir ? (double)destBmp.Height : (double)destBmp.Width;

            for (int i = 0; i < destBmp.Width; i++)
            {
                for (int j = 0; j < destBmp.Height; j++)
                {
                    double dx = 0;
                    dx = bXDir ? (PI2 * (double)j) / dBaseAxisLen : (PI2 * (double)i) / dBaseAxisLen;
                    dx += dPhase;
                    double dy = Math.Sin(dx);

                    // 取得当前点的颜色
                    int nOldX = 0, nOldY = 0;
                    nOldX = bXDir ? i + (int)(dy * dMultValue) : i;
                    nOldY = bXDir ? j : j + (int)(dy * dMultValue);

                    System.Drawing.Color color = srcBmp.GetPixel(i, j);
                    if (nOldX >= 0 && nOldX < destBmp.Width
                     && nOldY >= 0 && nOldY < destBmp.Height)
                    {
                        destBmp.SetPixel(nOldX, nOldY, color);
                    }
                }
            }

            return destBmp;
        }

        /// <summary>
        /// 生成随机字符码
        /// </summary>
        /// <param name="codeLen"></param>
        /// <returns></returns>
        private string CreateVerifyCode(int codeLen)
        {
            if (codeLen == 0)
            {
                codeLen = _length;
            }

            string[] arr = _codeSerial.Split(',');

            string code = "";

            int randValue = -1;

            Random rand = new Random(unchecked((int)DateTime.Now.Ticks));

            for (int i = 0; i < codeLen; i++)
            {
                randValue = rand.Next(0, arr.Length - 1);

                code += arr[randValue];
            }

            return code;
        }

        /// <summary>
        /// 生成随机字符码
        /// </summary>
        /// <returns></returns>
        private string CreateVerifyCode()
        {
            return CreateVerifyCode(0);
        }

        #endregion
    }

    #region Services

    public interface IFormsAuthenticationService
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthenticationService
    {
        public void SignIn(string userName, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }

        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    #endregion

}
