using System;
using System.Drawing;

namespace GT.ImageGenerator.GeneratedImages
{
    [Serializable]
    public class BackgroundImage : SizedImageBase
    {
        public BackgroundImage() : base()
        {
        }

        public override int UniqueID
        {
            get { return 1; }
        }

        protected override void Generate()
        {
            _image = new Bitmap(Width, Height);

            using (Graphics graph = Graphics.FromImage(_image))
            {
                SetupGraphics(graph);
                graph.Clear(BackColor);
            }
        }
    }
}