using System;
using System.Drawing;
using System.Drawing.Imaging;

namespace GT.Common.Drawing
{

	//mdibb.net
    public unsafe class FastBitmap
    {
        private Bitmap Subject;
        private int SubjectWidth;
        private BitmapData bitmapData = null;
        private Byte* pBase = null;

        public FastBitmap(Bitmap SubjectBitmap)
        {
            Subject = SubjectBitmap;
            try
            {
                LockBitmap();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void Release()
        {
            try
            {
                UnlockBitmap();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Bitmap Bitmap
        {
            get { return Subject; }
        }

        public void SetPixel(int X, int Y, Color Colour)
        {
            try
            {
                PixelData* p = PixelAt(X, Y);
                p->red = Colour.R;
                p->green = Colour.G;
                p->blue = Colour.B;
            }
            catch (AccessViolationException ave)
            {
                throw (ave);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Color GetPixel(int X, int Y)
        {
            try
            {
                PixelData* p = PixelAt(X, Y);
                return Color.FromArgb((int) p->red, (int) p->green, (int) p->blue);
            }
            catch (AccessViolationException ave)
            {
                throw (ave);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LockBitmap()
        {
            GraphicsUnit unit = GraphicsUnit.Pixel;
            RectangleF boundsF = Subject.GetBounds(ref unit);
            Rectangle bounds =
                new Rectangle((int) boundsF.X, (int) boundsF.Y, (int) boundsF.Width, (int) boundsF.Height);
            SubjectWidth = (int) boundsF.Width*sizeof (PixelData);
            if (SubjectWidth%4 != 0)
            {
                SubjectWidth = 4*(SubjectWidth/4 + 1);
            }
            bitmapData = Subject.LockBits(bounds, ImageLockMode.ReadWrite, PixelFormat.Format24bppRgb);
            pBase = (Byte*) bitmapData.Scan0.ToPointer();
        }

        private PixelData* PixelAt(int x, int y)
        {
            return (PixelData*) (pBase + y*SubjectWidth + x*sizeof (PixelData));
        }

        private void UnlockBitmap()
        {
            Subject.UnlockBits(bitmapData);
            bitmapData = null;
            pBase = null;
        }

        public struct PixelData
        {
            public byte blue;
            public byte green;
            public byte red;
        }
    }
}