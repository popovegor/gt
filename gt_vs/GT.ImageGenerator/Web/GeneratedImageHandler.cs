using System;
using System.IO;
using System.Web;
using System.Web.Services;
using GT.Common;
using GT.Common.Web.Exceptions;
using GT.ImageGenerator.Cache;
using GT.ImageGenerator.GeneratedImages;

namespace GT.ImageGenerator.Web
{
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  public class GeneratedImageHandler : IHttpHandler
  {
    public const string HANDLER_NAME = "/ImageHandler.ashx";

    #region IHttpHandler Members

    public void ProcessRequest(HttpContext context)
    {
      try
      {
        string sQuery = context.Request.Url.Query;

        if (!string.IsNullOrEmpty(sQuery))
        {
          string sHash = GeneratedImageManager.GetHash(sQuery);

          HttpCachePolicy cache = context.Response.Cache;
          cache.SetCacheability(HttpCacheability.Public);
          foreach (string key in context.Request.QueryString.AllKeys)
            cache.VaryByParams[key] = true;
          cache.SetOmitVaryStar(true);

          if (!CacheManager.Contains(sHash))
          {
            GeneratedImageBase image = GeneratedImageManager.GetImageByLink(sQuery);
            if (image.GeneratedImage != null)
            {
              cache.SetExpires(
                  image.GenerationDate.AddMonths(image.Cache ? 1 : -1));
              cache.SetValidUntilExpires(true);
              context.Response.Cache.SetLastModified(image.GenerationDate);
              context.Response.ContentType = image.ContentType;

              using (MemoryStream stream = new MemoryStream())
              {
                image.Save(stream, true);
                stream.WriteTo(context.Response.OutputStream);
              }
            }
          }
          else
          {
            string sFileName = CacheManager.GetLink(sHash);
            context.Response.ContentType = string.Format("image/{0}", Path.GetExtension(sFileName));
            byte[] img = File.ReadAllBytes(context.Request.MapPath(sFileName));
            context.Response.OutputStream.Write(img, 0, img.Length);
          }
        }
      }
      catch (Exception e)
      {
        AssistLogger.Log<WebExceptionHolder>(e);
      }
    }

    public bool IsReusable
    {
      get { return true; }
    }

    #endregion
  }
}