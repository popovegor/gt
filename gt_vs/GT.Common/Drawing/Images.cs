using System.Drawing;
using System.Drawing.Imaging;

namespace GT.Common.Drawing
{
    public class Images
    {
        static ColorPalette GetColorPalette(uint p_uiColors)
        {
            // Assume monochrome image.
            PixelFormat bitscolordepth = PixelFormat.Format1bppIndexed;
            ColorPalette palette; // The Palette we are stealing
            Bitmap bitmap; // The source of the stolen palette

            // Determine number of colors.
            if (p_uiColors > 2)
                bitscolordepth = PixelFormat.Format4bppIndexed;
            if (p_uiColors > 16)
                bitscolordepth = PixelFormat.Format8bppIndexed;

            // Make a new Bitmap object to get its Palette.
            bitmap = new Bitmap(1, 1, bitscolordepth);

            palette = bitmap.Palette; // Grab the palette

            bitmap.Dispose(); // cleanup the source Bitmap

            return palette; // Send the palette back
        }

        public static Image GetTransparentGIF(Image p_image, Color p_TransparentColor)
        {
            return GetGIFWithNewColorTable(p_image, 256, p_TransparentColor, true);
        }

        public static Image GetGIFWithNewColorTable(Image p_image, uint p_uiColors, 
            Color p_TransparentColor, bool p_bTransparent)
        {
            return p_image;
            //// GIF codec supports 256 colors maximum, monochrome minimum.
            //if (p_uiColors > 256)
            //    p_uiColors = 256;
            //if (p_uiColors < 2)
            //    p_uiColors = 2;

            //// Make a new 8-BPP indexed bitmap that is the same size as the source image.
            //int iWidth = p_image.Width;
            //int iHeight = p_image.Height;

            //// Always use PixelFormat8bppIndexed because that is the color
            //// table-based interface to the GIF codec.
            //Bitmap bitmap = new Bitmap(iWidth,
            //                           iHeight,
            //                           PixelFormat.Format8bppIndexed);

            //// Create a color palette big enough to hold the colors you want.
            //ColorPalette pal = GetColorPalette(p_uiColors);

            //// Initialize a new color table with entries that are determined
            //// by some optimal palette-finding algorithm; for demonstration 
            //// purposes, use a grayscale.
            //for (uint i = 0; i < p_uiColors; i++)
            //{
            //    uint Alpha = 0xFF; // Colors are opaque.
            //    uint Intensity = i*0xFF/(p_uiColors - 1); // Even distribution. 

            //    // The GIF encoder makes the first entry in the palette
            //    // that has a ZERO alpha the transparent color in the GIF.
            //    // Pick the first one arbitrarily, for demonstration purposes.

            //    //if (i == 0 && p_bTransparent) // Make this color index...
            //    //    Alpha = 0; // Transparent
            //    int iIntensity = (int) Intensity;
            //    if (Color.FromArgb(iIntensity, iIntensity, iIntensity).Equals(p_TransparentColor) &&
            //        p_bTransparent)
            //        Alpha = 0;
                    

            //    // Create a gray scale for demonstration purposes.
            //    // Otherwise, use your favorite color reduction algorithm
            //    // and an optimum palette for that algorithm generated here.
            //    // For example, a color histogram, or a median cut palette.
            //    pal.Entries[i] = Color.FromArgb((int) Alpha,
            //                                    (int) Intensity,
            //                                    (int) Intensity,
            //                                    (int) Intensity);
            //}

            //// Set the palette into the new Bitmap object.
            //bitmap.Palette = pal;


            //// Use GetPixel below to pull out the color data of Image.
            //// Because GetPixel isn't defined on an Image, make a copy 
            //// in a Bitmap instead. Make a new Bitmap that is the same size as the
            //// image that you want to export. Or, try to
            //// interpret the native pixel format of the image by using a LockBits
            //// call. Use PixelFormat32BppARGB so you can wrap a Graphics  
            //// around it.
            //Bitmap BmpCopy = new Bitmap(iWidth,
            //                            iHeight,
            //                            PixelFormat.Format32bppArgb);
            //{
            //    Graphics g = Graphics.FromImage(BmpCopy);

            //    g.PageUnit = GraphicsUnit.Pixel;

            //    // Transfer the Image to the Bitmap
            //    g.DrawImage(p_image, 0, 0, iWidth, iHeight);

            //    // g goes out of scope and is marked for garbage collection.
            //    // Force it, just to keep things clean.
            //    g.Dispose();
            //}

            //// Lock a rectangular portion of the bitmap for writing.
            //BitmapData bitmapData;
            //Rectangle rect = new Rectangle(0, 0, iWidth, iHeight);

            //bitmapData = bitmap.LockBits(
            //    rect,
            //    ImageLockMode.WriteOnly,
            //    PixelFormat.Format8bppIndexed);

            //// Write to the temporary buffer that is provided by LockBits.
            //// Copy the pixels from the source image in this loop.
            //// Because you want an index, convert RGB to the appropriate
            //// palette index here.
            //IntPtr pixels = bitmapData.Scan0;

            //unsafe
            //{
            //    // Get the pointer to the image bits.
            //    // This is the unsafe operation.
            //    byte* pBits;
            //    if (bitmapData.Stride > 0)
            //        pBits = (byte*) pixels.ToPointer();
            //    else
            //        // If the Stide is negative, Scan0 points to the last 
            //        // scanline in the buffer. To normalize the loop, obtain
            //        // a pointer to the front of the buffer that is located 
            //        // (Height-1) scanlines previous.
            //        pBits = (byte*) pixels.ToPointer() + bitmapData.Stride*(iHeight - 1);
            //    uint stride = (uint) Math.Abs(bitmapData.Stride);

            //    for (uint row = 0; row < iHeight; ++row)
            //    {
            //        for (uint col = 0; col < iWidth; ++col)
            //        {
            //            // Map palette indexes for a gray scale.
            //            // If you use some other technique to color convert,
            //            // put your favorite color reduction algorithm here.
            //            Color pixel; // The source pixel.

            //            // The destination pixel.
            //            // The pointer to the color index byte of the
            //            // destination; this real pointer causes this
            //            // code to be considered unsafe.
            //            byte* p8bppPixel = pBits + row*stride + col;

            //            pixel = BmpCopy.GetPixel((int) col, (int) row);

            //            // Use luminance/chrominance conversion to get grayscale.
            //            // Basically, turn the image into black and white TV.
            //            // Do not calculate Cr or Cb because you 
            //            // discard the color anyway.
            //            // Y = Red * 0.299 + Green * 0.587 + Blue * 0.114

            //            // This expression is best as integer math for performance,
            //            // however, because GetPixel listed earlier is the slowest 
            //            // part of this loop, the expression is left as 
            //            // floating point for clarity.

            //            double luminance = (pixel.R*0.299) +
            //                               (pixel.G*0.587) +
            //                               (pixel.B*0.114);

            //            // Gray scale is an intensity map from black to white.
            //            // Compute the index to the grayscale entry that
            //            // approximates the luminance, and then round the index.
            //            // Also, constrain the index choices by the number of
            //            // colors to do, and then set that pixel's index to the 
            //            // byte value.
            //            *p8bppPixel = (byte) (luminance*(p_uiColors - 1)/255 + 0.5);
            //        } /* end loop for col */
            //    } /* end loop for row */
            //} /* end unsafe */

            //// To commit the changes, unlock the portion of the bitmap.  
            //bitmap.UnlockBits(bitmapData);
            //BmpCopy.Dispose();
            //return bitmap;
        }
    }
}
