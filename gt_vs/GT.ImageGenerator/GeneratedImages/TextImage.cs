using System;
using System.Drawing;
using System.Windows.Forms;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages
{
    [Serializable]
    public class TextImage : SizedImageBase
    {
        public const string TEXT_PROPERTY_NAME = "tx";

        private FontStyle m_FontStyle = FontStyle.Regular;
        private Color m_ForeColor = Color.Black;

        private TextFormatFlags m_FormatFlags = TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter |
                                                TextFormatFlags.EndEllipsis;

        private int m_iFontSize = 12;
        private string m_sFontFamily = "Arial";
        private string m_sText = string.Empty;

        public TextImage() : base()
        {
            Width = 1;
            Height = 1;
        }

        [QueryStringSerializable(TEXT_PROPERTY_NAME)]
        public string Text
        {
            get { return m_sText; }
            set { m_sText = value; }
        }

        [QueryStringSerializable("ff")]
        public string FontFamily
        {
            get { return m_sFontFamily; }
            set { m_sFontFamily = value; }
        }

        [QueryStringSerializable("fmt")]
        public TextFormatFlags FormatFlags
        {
            get { return m_FormatFlags; }
            set { m_FormatFlags = value; }
        }

        [QueryStringSerializable("fs")]
        public FontStyle FontStyle
        {
            get { return m_FontStyle; }
            set { m_FontStyle = value; }
        }

        [QueryStringSerializable("sz")]
        public int FontSize
        {
            get { return m_iFontSize; }
            set { m_iFontSize = value; }
        }

        [QueryStringSerializable("fc")]
        public Color ForeColor
        {
            get { return m_ForeColor; }
            set { m_ForeColor = value; }
        }

        public override int UniqueID
        {
            get { return 6; }
        }

        protected override void Generate()
        {
            using (Font font = new Font(FontFamily, FontSize, FontStyle, GraphicsUnit.Pixel))
            {
                Size proposedSize = Size.Empty;
                if (Width > 1 &&
                    Height > 1)
                    proposedSize = new Size(Width, Height);
                Size size = proposedSize.IsEmpty
                                ? TextRenderer.MeasureText(Text, font)
                                : TextRenderer.MeasureText(Text, font, proposedSize);
                Width = proposedSize.IsEmpty ? size.Width : proposedSize.Width;
                Height = proposedSize.IsEmpty ? size.Height : proposedSize.Height;
                _image = new Bitmap(Width, Height);
                using (Graphics graph = Graphics.FromImage(_image))
                {
                    SetupGraphics(graph);
                    graph.Clear(BackColor);
                    TextRenderer.DrawText(graph, Text,
                                          font, new Rectangle(0, 0, Width, Height), ForeColor, FormatFlags);
                }
            }
        }
    }
}