using System;
using System.Drawing;
using System.IO;
using GT.Common.Drawing;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages.AnimatedGif
{
    [Serializable]
    public class CaptchaImage : TextImage, IAnimatedImage
    {
        public CaptchaImage() : base()
        {
            base.Cache = false;
        }

        public override int UniqueID
        {
            get { return 8; }
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
            if (!string.IsNullOrEmpty(Text))
            {
                AnimatedTextImage[] letters = new AnimatedTextImage[Text.Length];
                int[] xCoords = new int[Text.Length];
                Width = 0;
                Height = 0;
                Random rnd = new Random();
                for (int i = 0; i < Text.Length; i++)
                {
                    AnimatedTextImage img = new AnimatedTextImage();
                    img.Text = new string(Text[i], 1);
                    img.BackColor = BackColor;
                    img.ForeColor = ForeColor;
                    img.Cache = false;
                    img.MoveType = (MoveType) rnd.Next((int) MoveType.VerticalUp, (int) MoveType.VerticalDown + 1);
                    img.FontSize = rnd.Next(20, 25);
                    img.FontStyle = FontRandomizer.Next();
                    img.Reset();
                    img.YCoord = rnd.Next(-5, 0);
                    img.FrameCount = img.Height;
                    xCoords[i] = i == 0 ? 0 : xCoords[i - 1] + img.Width;
                    if (img.Height > Height)
                        Height = img.Height;
                    Width += img.Width;
                    letters[i] = img;
                }

                using (MemoryStream ms = new MemoryStream())
                {
                    AnimatedGifEncoder e = new AnimatedGifEncoder();
                    e.Start(ms);
                    if (Transparent)
                        e.SetTransparent(BackColor);
                    e.SetDelay(200);
                    e.SetRepeat(0);
                    bool bStop = false;
                    while (!bStop)
                    {
                        using (Bitmap frame = new Bitmap(Width, Height))
                        {
                            int iGeneratedCount = 0;
                            using (Graphics g = Graphics.FromImage(frame))
                            {
                                g.Clear(BackColor);
                                for (int i = 0; i < letters.Length; i++)
                                {
                                    using (Image frm = letters[i].GetFrame())
                                    {
                                        if (frm != null)
                                        {
                                            g.DrawImage(frm, xCoords[i], letters[i].CurrentPoint.Y);
                                            iGeneratedCount++;
                                        }
                                        else
                                            using (Image frm2 = letters[i].ForceGetFrame())
                                            {
                                                g.DrawImage(frm2, xCoords[i], letters[i].CurrentPoint.Y);
                                            }
                                    }
                                }
                            }
                            bStop = iGeneratedCount == 0;
                            if (!bStop &&
                                !AnimatedTextImage.IsEmptyFrame(frame))
                                lock (e)
                                {
                                    e.AddFrame(frame);
                                }
                        }
                    }
                    e.Finish();

                    foreach (AnimatedTextImage letter in letters)
                    {
                        letter.Reset();
                        letter.Dispose();
                    }

                    _image = Image.FromStream(ms);
                }
            }
        }

        #region Nested type: FontRandomizer

        private static class FontRandomizer
        {
            private static readonly FontStyle[] m_styles =
                new FontStyle[] {FontStyle.Regular, FontStyle.Italic, FontStyle.Bold, FontStyle.Italic | FontStyle.Bold};

            private static Random rnd = new Random();

            public static FontStyle Next()
            {
                return m_styles[rnd.Next(0, m_styles.Length)];
            }
        }

        #endregion
    }
}