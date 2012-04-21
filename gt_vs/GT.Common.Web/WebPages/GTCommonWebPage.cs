using System.IO;
using System.Web.UI;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace GT.Common.Web.WebPages
{
	public class GTCommonWebPage : Page
	{
		public byte[] Compress( byte[] bytes )
		{
			MemoryStream memory = new MemoryStream();
			Stream stream = new DeflaterOutputStream( memory,
				new ICSharpCode.SharpZipLib.Zip.Compression.Deflater(
				ICSharpCode.SharpZipLib.Zip.Compression.Deflater.BEST_COMPRESSION ), 131072 );
			stream.Write( bytes, 0, bytes.Length );
			stream.Close();
			return memory.ToArray();
		}

		public byte[] Decompress( byte[] bytes )
		{
			Stream stream = new InflaterInputStream( new MemoryStream( bytes ) );
			MemoryStream memory = new MemoryStream();
			int totalLength = 0;
			byte[] writeData = new byte[4096];
			while ( true )
			{
				int size = stream.Read( writeData, 0, writeData.Length );
				if ( size > 0 )
				{
					totalLength += size;
					memory.Write( writeData, 0, size );
				}
				else
					break;
			}
			stream.Close();
			return memory.ToArray();
		}

		protected override object LoadPageStateFromPersistenceMedium()
		{
			string vState = this.Request.Form["__VSTATE"];
			byte[] bytes = System.Convert.FromBase64String( vState );

			bytes = this.Decompress( bytes );

			LosFormatter format = new LosFormatter();
			return format.Deserialize( System.Convert.ToBase64String( bytes ) );
		}

		protected override void SavePageStateToPersistenceMedium( object viewState )
		{
			LosFormatter format = new LosFormatter();
			StringWriter writer = new StringWriter();
			format.Serialize( writer, viewState );
			string viewStateStr = writer.ToString();

			byte[] bytes = System.Convert.FromBase64String( viewStateStr );
			bytes = this.Compress( bytes );

			string vStateStr = System.Convert.ToBase64String( bytes );

			ClientScript.RegisterHiddenField( "__VSTATE", vStateStr );
		}
	}
}
