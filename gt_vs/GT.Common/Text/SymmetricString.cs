using System;
using System.Text;

namespace GT.Common.Text
{
    public class SymmetricString
    {
        private readonly StringBuilder m_sb = new StringBuilder();
        private int m_iStartPos = 0;
        private int m_iEndPos = 0;
        private static readonly char[] leftBrackets = new char[] {'(', '[', '{', '<'};
        private static readonly char[] rightBrackets = new char[] {')', ']', '}', '>'};


        public void AddSymmetric(string p_str)
        {
            if (!string.IsNullOrEmpty(p_str))
            {
                m_sb.Insert(m_iStartPos, p_str);
                m_iStartPos += p_str.Length;
                m_iEndPos += p_str.Length;
                m_sb.Insert(m_iEndPos, p_str);
            }
        }

        public void Add(string p_str)
        {
            if (!string.IsNullOrEmpty(p_str))
            {
                m_sb.Insert(m_iEndPos, p_str);
                m_iEndPos += p_str.Length;
            }
        }

        public void AddBracket(BracketType p_brackets)
        {
            int[] brackets = (int[]) Enum.GetValues(typeof (BracketType));
            for (int i = 0; i < brackets.Length; ++i)
                if ((brackets[i] & (int) p_brackets) == brackets[i])
                {
                    m_sb.Insert(m_iStartPos++, leftBrackets[i]);
                    m_sb.Insert(++m_iEndPos, rightBrackets[i]);
                }
        }

        public override string ToString()
        {
            return m_sb.ToString();
        }
    }
}