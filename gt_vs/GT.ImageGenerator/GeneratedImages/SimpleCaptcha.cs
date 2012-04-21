using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages
{
    [Serializable]
    public class SimpleCaptcha : TextImage
    {
        public SimpleCaptcha()
            : base()
        {
            base.Cache = false;
            Width = 90;
            Height = 28;
            FontFamily = "Verdana";
            FontSize = 24;
            FontStyle = FontStyle.Bold;
        }

        public override int UniqueID
        {
            get { return 10; }
        }

        [QueryStringSerializable(TEXT_PROPERTY_NAME, true)]
        public new string Text
        {
            get
            {
                return base.Text;
            }

            set
            {
                base.Text = value;
            }
        }

        protected override void Generate()
        {
            Random random = new Random();
            int swidth = 12;
            int sheight = 20;
            int hspace = 3;
            int vspace = 3;
            
            _image = new Bitmap(Width,
                                 Height);

            using (Graphics graph = Graphics.FromImage(_image))
            {
                graph.SmoothingMode = SmoothingMode.HighQuality;
                graph.TextRenderingHint = TextRenderingHint.AntiAlias;

                Rectangle rect = new Rectangle(0, 0, Width, Height);

                graph.Clear(BackColor);
                using (HatchBrush hatchBrush = new HatchBrush(
                    HatchStyle.SmallConfetti, ForeColor,
                    BackColor))
                {
                    graph.FillRectangle(hatchBrush, rect);

                    StringFormat format = new StringFormat();
                    format.Alignment = StringAlignment.Center;
                    format.LineAlignment = StringAlignment.Near;

                    using (Font font = new Font(FontFamily, FontSize, FontStyle))
                    {
                        for (int i = 0; i < Text.Length; i++)
                        {
                            int dh = random.Next(0, 8);
                            Rectangle rect2 =
                                new Rectangle(i*(swidth + 2*hspace), dh, (swidth + 2*hspace), sheight + dh);

                            using (GraphicsPath path = new GraphicsPath())
                            {
                                path.AddString(Text[i].ToString(), font.FontFamily, 1, font.Size, rect2, format);

                                int h_offset1 = random.Next(-hspace, hspace);
                                int v_offset1 = random.Next(-vspace, vspace);
                                int h_offset2 = random.Next(-hspace, hspace);
                                int v_offset2 = random.Next(-vspace, vspace);
                                int h_offset3 = random.Next(-hspace, hspace);
                                int v_offset3 = random.Next(-vspace, vspace);
                                int h_offset4 = random.Next(-hspace, hspace);
                                int v_offset4 = random.Next(-vspace, vspace);

                                PointF[] points =
                                    {
                                        new PointF(
                                            i*(swidth + 2*hspace) + h_offset2,
                                            vspace + v_offset2),
                                        new PointF(
                                            (i + 1)*(swidth + 2*hspace) + h_offset4,
                                            vspace + v_offset4),
                                        new PointF(
                                            i*(swidth + 2*hspace) + h_offset1,
                                            sheight + v_offset1),
                                        new PointF(
                                            (i + 1)*(swidth + 2*hspace) + h_offset3,
                                            sheight + v_offset3)
                                    };

                                using (Matrix matrix = new Matrix())
                                {
                                    matrix.Translate(0F, 0F);
                                    path.Warp(points, rect2, matrix, WarpMode.Perspective, 1F);
                                }
                                using (HatchBrush hatchBrush2 = new HatchBrush(
                                    HatchStyle.Percent75, ForeColor, BackColor))
                                {
                                    graph.FillPath(hatchBrush2, path);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}