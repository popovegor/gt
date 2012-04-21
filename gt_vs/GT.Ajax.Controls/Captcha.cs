using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using GT.Ajax.Controls.ControlBase;
using GT.Common;
using GT.Common.Cryptography;
using GT.Common.Exceptions;
using GT.Common.Web.JS;
using GT.ImageGenerator;
using GT.ImageGenerator.GeneratedImages;
using Image=System.Web.UI.WebControls.Image;

namespace GT.Ajax.Controls
{
    [ToolboxData("<{0}:Captcha runat=server></{0}:Captcha>")]
    public class Captcha : Panel, INamingContainer, IGTAjaxControl
    {
        public const string IMAGE_CONTROL_ID = "CaptchaImage";
        private const string JS_VALIDATION_FUNC = "ValidateCaptcha";
        public const string TEXTBOX_CONTROL_ID = "CaptchaSecretCode";
        public const string VALIDATOR_CONTROL_ID = "CaptchaValidator";
        private bool m_bEnableFilter = true;

        private ControlManager m_ctlManager;
        private FilteredTextBoxExtender m_filter;

        private HtmlInputHidden m_hdnHash;
        private Image m_image;
        private Color m_ImageBackColor = Color.LightGray;
        private Color m_ImageForeColor = Color.Black;
        private SimpleCaptcha m_imageObject = null;
        private TextBox m_txt;
        private CustomValidator m_val;

        public SimpleCaptcha ImageObject
        {
            get
            {
                if (m_imageObject == null)
                {
                    m_imageObject = new SimpleCaptcha();
                    m_imageObject.Text = new Random().Next(11111, 99999).ToString();
                    m_imageObject.BackColor = ColorTranslator.FromHtml("#ffffff");
                    m_imageObject.ForeColor = ColorTranslator.FromHtml("#666666");
                }
                return m_imageObject;
            }
            set { m_imageObject = null; }
        }

        public Color ImageBackColor
        {
            get { return m_ImageBackColor; }
            set { m_ImageBackColor = value; }
        }

        public Color ImageForeColor
        {
            get { return m_ImageForeColor; }
            set { m_ImageForeColor = value; }
        }

        public bool EnableFilter
        {
            get { return m_bEnableFilter; }

            set { m_bEnableFilter = value; }
        }

        public bool IsValid
        {
            get { return Validator.IsValid; }
        }

        #region Controls

        private HtmlInputHidden HashHidden
        {
            get
            {
                EnsureChildControls();
                return m_hdnHash;
            }
        }

        private Image CaptchaImage
        {
            get
            {
                EnsureChildControls();
                m_image = (Image) FindControl(IMAGE_CONTROL_ID);
                if (m_image == null)
                    throw new Exception(
                        string.Format("Cannot find required image control with ID '{0}'", IMAGE_CONTROL_ID));
                return m_image;
            }
        }

        private TextBox TextBox
        {
            get
            {
                EnsureChildControls();
                m_txt = (TextBox) FindControl(TEXTBOX_CONTROL_ID);
                if (m_txt == null)
                    throw new Exception(
                        string.Format("Cannot find required textbox control with ID '{0}'", TEXTBOX_CONTROL_ID));
                return m_txt;
            }
        }

        private CustomValidator Validator
        {
            get
            {
                EnsureChildControls();
                m_val = (CustomValidator) FindControl(VALIDATOR_CONTROL_ID);
                if (m_val == null)
                    throw new Exception(
                        string.Format("Cannot find required custom validator control with ID '{0}'",
                                      VALIDATOR_CONTROL_ID));
                return m_val;
            }
        }

        public FilteredTextBoxExtender Filter
        {
            get
            {
                EnsureChildControls();
                return m_filter;
            }
        }

        #endregion

        #region IATIAjaxControl Members

        public ControlManager Manager
        {
            get
            {
                if (m_ctlManager == null)
                    m_ctlManager = new ControlManager(this);
                return m_ctlManager;
            }
        }

        public string GetInitScriptCall()
        {
            JSBuilder jsb = new JSBuilder();
            jsb.Write(string.Format("function {0}(p_source, p_args)", JS_VALIDATION_FUNC));
            jsb.Begin();
            jsb.Write(string.Format("p_args.IsValid = document.getElementById('{0}').value == hex_md5(p_args.Value);",
                                    HashHidden.ClientID));
            jsb.End();
            return jsb.ToString();
        }

        public void DisableScriptControls()
        {
            Filter.Enabled = false;
        }

        #endregion

        protected override void CreateChildControls()
        {
            base.CreateChildControls();
            m_filter = new FilteredTextBoxExtender();
            m_filter.FilterType = FilterTypes.Numbers;
            Controls.Add(m_filter);
            m_hdnHash = new HtmlInputHidden();
            m_hdnHash.ID = "Hash";
            Controls.Add(m_hdnHash);
        }

        protected override void OnInit(EventArgs e)
        {
            InitializeControls();
            base.OnInit(e);
        }
        
        private void InitializeControls()
        {
            CaptchaImage.GenerateEmptyAlternateText = true;
            TextBox.AutoCompleteType = AutoCompleteType.Disabled;
            TextBox.MaxLength = ImageObject.Text.Length;
            TextBox.ReadOnly = false;
            TextBox.TextMode = TextBoxMode.SingleLine;
            Filter.TargetControlID = TextBox.UniqueID;
            Validator.ValidateEmptyText = true;
            Validator.ControlToValidate = TextBox.ID;
            Validator.ServerValidate += Validator_ServerValidate;
            Validator.ClientValidationFunction = JS_VALIDATION_FUNC;
        }

        protected override void OnLoad(EventArgs e)
        {
            Manager.RegisterClientScriptResource("Hash.js");
            base.OnLoad(e);
        }

        protected override void OnPreRender(EventArgs e)
        {
            PrepareValues();
            base.OnPreRender(e);
        }

        private void PrepareValues()
        {
            try
            {
                m_imageObject = null;
                CaptchaImage.ImageUrl = GeneratedImageManager.GetLink(ImageObject);
                HashHidden.Value = Hash.ReadableHash(Hash.MD5, ImageObject.Text);
            }
            catch(Exception e)
            {
                AssistLogger.Log<ExceptionHolder>(e);
            }
        }

        private void Validator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = false;
            if (args.Value != string.Empty)
            {
                SimpleCaptcha cpt =
                    (SimpleCaptcha) GeneratedImageManager.GetImageByLink(CaptchaImage.ImageUrl);
                args.IsValid = args.Value == cpt.Text;
            }
            TextBox.Text = string.Empty;
        }
    }
}