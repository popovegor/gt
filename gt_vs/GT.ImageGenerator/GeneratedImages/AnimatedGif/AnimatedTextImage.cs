using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using GT.Common.Drawing;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages.AnimatedGif
{
    [Serializable]
    public class AnimatedTextImage : TextImage, IAnimatedImage
    {
        private Point beginPoint = Point.Empty;
        private Point currentPoint = Point.Empty;
        private Point endPoint = Point.Empty;
        private bool m_bNewTransparent = false;
        private bool m_bStop = false;
        private int m_iAddedFrames = 0;
        private int m_iDelay = 500;
        private int m_iFrameCount = 5;
        private int m_iXCoord = 0;
        private int m_iYCoord = 0;
        private MoveType m_MoveType = MoveType.VerticalDown;

        private Point startPoint = Point.Empty;
        private Size subtrahendSize = Size.Empty;

        public AnimatedTextImage()
            : base()
        {
            ForeColor = Color.Black;
            FontSize = 24;
            FontFamily = "Verdana";
            FontStyle = FontStyle.Bold;
            ContentType = "image/gif";
            base.Transparent = false;
        }

        public new int UniqueID
        {
            get { return 7; }
        }

        public override bool Transparent
        {
            get { return m_bNewTransparent; }
            set { m_bNewTransparent = value; }
        }

        [QueryStringSerializable("dl")]
        public int Delay
        {
            get { return m_iDelay; }
            set { m_iDelay = value; }
        }

        [QueryStringSerializable("mt")]
        public MoveType MoveType
        {
            get { return m_MoveType; }
            set { m_MoveType = value; }
        }

        [QueryStringSerializable("frc")]
        public int FrameCount
        {
            get { return m_iFrameCount; }
            set
            {
                if (value > 0)
                    m_iFrameCount = value;
            }
        }

        private bool IsVerticalMove
        {
            get
            {
                return MoveType == MoveType.VerticalUp ||
                       MoveType == MoveType.VerticalDown;
            }
        }

        private bool IsBackMove
        {
            get
            {
                return MoveType == MoveType.VerticalUp ||
                       MoveType == MoveType.HorisontalLeft;
            }
        }

        public Point CurrentPoint
        {
            get { return currentPoint; }
        }

        [QueryStringSerializable("x")]
        public int XCoord
        {
            get { return m_iXCoord; }
            set { m_iXCoord = value; }
        }

        [QueryStringSerializable("y")]
        public int YCoord
        {
            get { return m_iYCoord; }
            set { m_iYCoord = value; }
        }

        protected override void Generate()
        {
            using (MemoryStream ms = new MemoryStream())
            {
                AnimatedGifEncoder e = new AnimatedGifEncoder();
                e.Start(ms);
                if (Transparent)
                    e.SetTransparent(BackColor);
                e.SetDelay(Delay);
                e.SetRepeat(0);
                Reset();
                while (!m_bStop)
                {
                    using (Image frm = GetFrame())
                    {
                        if (frm != null)
                        {
                            lock (e)
                            {
                                e.AddFrame(frm);
                            }
                        }
                    }
                }
                e.Finish();
                _image = Image.FromStream(ms);
            }
        }

        public Image GetFrame()
        {
            empty_frame:
            m_bStop = IncrementCurrentPoint();
            if (!m_bStop)
            {
                Bitmap bmp = new Bitmap(_image.Width, _image.Height);
                using (Graphics graph = Graphics.FromImage(bmp))
                {
                    graph.Clear(BackColor);
                    graph.DrawImage(_image, CurrentPoint);
                }
                if (IsEmptyFrame(bmp))
                    goto empty_frame;
                m_iAddedFrames++;
                return bmp;
            }
            return null;
        }

        public Image ForceGetFrame()
        {
            endPoint = new Point(IsVerticalMove ? 0 : IsBackMove ? -_image.Width : _image.Width,
                                              IsVerticalMove ? IsBackMove ? -_image.Height : _image.Height : 0);
            Image img = GetFrame();

            endPoint = Point.Empty;

            return img;
        }

        public void Reset()
        {
            FormatFlags = TextFormatFlags.Default;
            base.Generate();
            currentPoint = Point.Empty;
            beginPoint = Point.Empty;
            endPoint = Point.Empty;
            startPoint = Point.Empty;
            m_bStop = false;
            m_iAddedFrames = 0;
        }

        public static bool IsEmptyFrame(Bitmap p_frame)
        {
            FastBitmap bmp = new FastBitmap(p_frame);
            Color clr = Color.Empty;
            for (int x = 0; x < p_frame.Width; ++x)
                for (int y = 0; y < p_frame.Height; ++y)
                {
                    Color c = bmp.GetPixel(x, y);
                    if (clr.IsEmpty)
                    {
                        clr = c;
                        continue;
                    }
                    if (clr != c)
                    {
                        bmp.Release();
                        return false;
                    }
                }
            bmp.Release();
            return true;
        }

        private bool IncrementCurrentPoint()
        {
            bool bStopMove = false;
            if (m_iAddedFrames == 0)
            {
                int iDirecton = IsBackMove ? -1 : 1;
                subtrahendSize = new Size(IsVerticalMove ? 0 : _image.Width/FrameCount*iDirecton,
                                          IsVerticalMove ? _image.Height/FrameCount*iDirecton : 0);
                beginPoint = new Point(IsVerticalMove ? 0 : IsBackMove ? _image.Width : -_image.Width,
                                       IsVerticalMove ? IsBackMove ? _image.Height : -_image.Height : 0);
                endPoint = new Point(IsVerticalMove ? 0 : IsBackMove ? -_image.Width : _image.Width,
                                     IsVerticalMove ? IsBackMove ? -_image.Height : _image.Height : 0);
                startPoint = new Point(XCoord, YCoord);
                if (IsVerticalMove)
                {
                    if (!IsBackMove &&
                        startPoint.Y > endPoint.Y)
                        startPoint = endPoint;
                    if (IsBackMove &&
                        startPoint.Y > beginPoint.Y)
                        startPoint = beginPoint;
                }
                else
                {
                    if (!IsBackMove &&
                        startPoint.X > endPoint.X)
                        startPoint = endPoint;
                    if (IsBackMove &&
                        startPoint.X > beginPoint.X)
                        startPoint = beginPoint;
                }
                currentPoint = startPoint;
                return bStopMove;
            }

            currentPoint = Point.Add(currentPoint, subtrahendSize);

            if (!endPoint.IsEmpty)
            {
                if (IsVerticalMove)
                {
                    if ((!IsBackMove &&
                         currentPoint.Y > endPoint.Y) ||
                        (IsBackMove && currentPoint.Y < endPoint.Y))
                    {
                        currentPoint = beginPoint;
                        endPoint = Point.Empty;
                    }
                }
                else
                {
                    if ((!IsBackMove &&
                         currentPoint.X > endPoint.X) ||
                        (IsBackMove && currentPoint.X < endPoint.X))
                    {
                        currentPoint = beginPoint;
                        endPoint = Point.Empty;
                    }
                }
            }

            if (endPoint.IsEmpty)
            {
                if ((IsVerticalMove &&
                     (!IsBackMove && currentPoint.Y > startPoint.Y) ||
                     (IsBackMove && currentPoint.Y < startPoint.Y)) ||
                    (!IsVerticalMove &&
                     (!IsBackMove && currentPoint.X > startPoint.X) ||
                     (IsBackMove && currentPoint.X < startPoint.X)))
                    bStopMove = true;
            }

            return bStopMove;
        }
    }
}