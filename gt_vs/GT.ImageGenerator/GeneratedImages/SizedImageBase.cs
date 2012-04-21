using System;
using GT.ImageGenerator.Serialization;

namespace GT.ImageGenerator.GeneratedImages
{
    [Serializable]
    public abstract class SizedImageBase : GeneratedImageBase
    {
        private int m_iWidth = 0;
        private int m_iHeight = 0;

        [QueryStringSerializable("w")]
        public int Width
        {
            get { return m_iWidth; }
            set
            {
                if (value < 0)
                    throw new ArgumentException("Width cannot be < 0", "value");
                m_iWidth = value;
            }
        }

        [QueryStringSerializable("h")]
        public int Height
        {
            get { return m_iHeight; }
            set
            {
                if (value < 0)
                    throw new ArgumentException("Height cannot be < 0", "value");
                m_iHeight = value;
            }
        }
    }
}