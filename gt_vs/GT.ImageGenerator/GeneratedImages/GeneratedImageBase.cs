using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using GT.Common.Drawing;
using GT.ImageGenerator.GeneratedImages.AnimatedGif;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages
{
  [Serializable]
  public abstract class GeneratedImageBase : IDisposable
  {
    public const string TYPE_PROPERTY_NAME = "it";
    public const string CACHE_PROPERTY_NAME = "ch";
    public const string CONTENT_PROPERTY_NAME = "cnt";
    public const string TRANSP_PROPERTY_NAME = "trn";
    public const string BACKCOLOR_PROPERTY_NAME = "bc";
    public const string QUALITY_PROPERTY_NAME = "q";
    public const int DEFAULT_QUALITY = 100;

    protected Image _image = null;
    protected bool m_bCache = true;
    protected bool m_bTransparent = false;
    private string m_sContentType = "image/jpeg";
    private Color m_BackColor = Color.White;
    private int m_quality = DEFAULT_QUALITY;

    public DateTime GenerationDate = DateTime.MinValue;

    private static readonly object _lockObject = new object();

    [QueryStringSerializable(TYPE_PROPERTY_NAME)]
    public virtual int UniqueID
    {
      get { return 0; }
    }

    [QueryStringSerializable(CACHE_PROPERTY_NAME)]
    public virtual bool Cache
    {
      get { return m_bCache; }
      set { m_bCache = value; }
    }

    [QueryStringSerializable(TRANSP_PROPERTY_NAME)]
    public virtual bool Transparent
    {
      get { return m_bTransparent; }
      set { m_bTransparent = value; }
    }

    [QueryStringSerializable(CONTENT_PROPERTY_NAME)]
    public string ContentType
    {
      get { return m_sContentType; }
      set { m_sContentType = value; }
    }

    [QueryStringSerializable(BACKCOLOR_PROPERTY_NAME)]
    public Color BackColor
    {
      get { return m_BackColor; }
      set { m_BackColor = value; }
    }

    [QueryStringSerializable(QUALITY_PROPERTY_NAME)]
    public int Quality
    {
      get { return m_quality; }
      set { m_quality = value; }
    }

    public Image GeneratedImage
    {
      get
      {
        GenerateInternal();
        return _image;
      }
      set
      {
        _image = value;
      }
    }

    public string ImageUrl
    {
      get
      {
        return GeneratedImageManager.GetLink(this);
      }
    }

    protected static void SetupGraphics(Graphics p_graph)
    {
      p_graph.SmoothingMode = SmoothingMode.AntiAlias;
      p_graph.InterpolationMode = InterpolationMode.HighQualityBicubic;
      p_graph.PixelOffsetMode = PixelOffsetMode.HighQuality;
      p_graph.TextRenderingHint = TextRenderingHint.AntiAlias;
    }

    protected abstract void Generate();

    private void GenerateInternal()
    {
      if (_image == null)
      {
        Generate();
        if (Transparent &&
            ContentType == "image/gif")
          MakeTransparent();
        GenerationDate = DateTime.Now;
      }
    }

    private void MakeTransparent()
    {
      using (MemoryStream ms = new MemoryStream())
      {
        AnimatedGifEncoder e = new AnimatedGifEncoder();
        e.Start(ms);
        e.SetTransparent(BackColor);
        e.SetDelay(500);
        e.SetRepeat(-1);
        e.AddFrame(_image);
        e.AddFrame(_image);
        e.Finish();
        _image = Image.FromStream(ms);
      }
    }

    public void Save(Stream p_stream)
    {
      Save(p_stream, false);
    }

    public void Save(Stream p_stream, bool p_bDispose)
    {
      if (p_stream != null)
      {
        if ((Transparent &&
             ContentType == "image/gif") ||
            this is IAnimatedImage)
          lock (_lockObject)
            GeneratedImage.Save(p_stream, ImageFormat.Gif);
        else
        {
          lock (_lockObject)
          {
            ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo ici = null;

            foreach (ImageCodecInfo codec in codecs)
            {
              if (codec.MimeType == ContentType)
              {
                ici = codec;
                break;
              }
            }

            if (ici != null)
            {
              EncoderParameters ep = new EncoderParameters();
              ep.Param[0] = new EncoderParameter(Encoder.Quality, Quality > 0
                ? Quality
                : GeneratedImageManager.Configuration.Quality);
              Bitmap bm = new Bitmap(GeneratedImage);
              bm.Save(p_stream, ici, ep);
              GeneratedImage.Dispose();
              bm.Dispose();
            }
          }
        }
        if (p_bDispose)
          Dispose();
      }
    }

    public void Dispose()
    {
      if (_image != null)
        _image.Dispose();
      _image = null;
    }
  }
}