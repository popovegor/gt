using System;
using System.Text.RegularExpressions;
using GT.Common.Types;
using System.Text;

namespace GT.Common.Text
{
  public static class StringUtils
  {

    private static readonly Regex m_regex = new Regex("[^a-zA-Z0-9]", RegexOptions.Compiled);

    public static bool IsDigitString(string p_str)
    {
      for (int i = 0; i < p_str.Length; i++)
        if (!char.IsDigit(p_str[i]))
          return false;
      return true;
    }

    public static void CutEnd(ref string p_sStr, char p_cEndChar)
    {
      if (p_sStr.Length == 0)
        return;
      if (p_sStr[p_sStr.Length - 1] == p_cEndChar)
        p_sStr = p_sStr.Substring(0, p_sStr.Length - 1);
    }

    public static string FormatStringArray(string p_sFormatString, string[] p_asTarget)
    {
      string sReturn = string.Empty;
      if (string.IsNullOrEmpty(p_sFormatString))
        p_sFormatString = "{0}";
      if (p_asTarget != null && p_asTarget.Length > 0)
      {
        foreach (string sVal in p_asTarget)
        {
          sReturn += string.Format(p_sFormatString, sVal);
        }
      }
      return sReturn;
    }

    public static string NumEraser(string p_sSourceStr, int p_iDigitsLimit)
    {
      string TestStr = p_sSourceStr;
      TestStr = Regex.Replace(TestStr, "\\W", "", RegexOptions.Compiled);
      if (Regex.Match(TestStr, "\\d{" + p_iDigitsLimit.ToString() + ",}", RegexOptions.Compiled).Success)
        return Regex.Replace(p_sSourceStr, "\\d", "*");
      else return p_sSourceStr;
    }

    public static string GetNonEmptyFormattedString(string p_sFormat, object p_oValue)
    {
      if (p_oValue != null)
        return GetNonEmptyFormattedString(p_sFormat, p_oValue.ToString());
      return string.Empty;
    }

    public static string GetNonEmptyFormattedString(string p_sFormat, string p_sValue)
    {
      if (!string.IsNullOrEmpty(p_sFormat) &&
          !string.IsNullOrEmpty(p_sValue))
        return string.Format(p_sFormat, p_sValue);
      return string.Empty;
    }

    public static string GetFormattedString(string p_sFormat, string p_sDelimiter, object[] p_args)
    {
      if (p_args != null &&
          p_args.Length > 0)
      {
        string sMerged = string.Empty;
        for (int i = 0; i < p_args.Length; ++i)
          if (p_args[i] != null)
          {
            string sArg = TypeConverter.ToString(p_args[i]);
            if (sArg != string.Empty)
              sMerged = sMerged.Length > 0
                          ? string.Format("{0}{1}{2}", sMerged, p_sDelimiter, sArg)
                          : string.Format("{0}{1}", sMerged, sArg);
          }
        if (sMerged != string.Empty)
          return string.Format(p_sFormat, sMerged);
      }
      return string.Empty;
    }

    public enum eQuoteTypes
    {
      Single = 0,
      Double
    }

    public static string Quote(string p_sValue, eQuoteTypes p_eQuoteType)
    {
      switch (p_eQuoteType)
      {
        case eQuoteTypes.Double:
          return string.Format("\"{0}\"", p_sValue);
        case eQuoteTypes.Single:
          return string.Format("'{0}'", p_sValue);
        default:
          return p_sValue;
      }
    }


    public static string AddSmothBR(string inputString, int maxSybolsInWord)
    {
      string outString = inputString;
      if (!string.IsNullOrEmpty(inputString))
      {
        string[] separatedStringArr = outString.Split(new char[] { ' ' });
        for (int strIndex = 0; strIndex < separatedStringArr.Length; strIndex++)
        {
          if (separatedStringArr[strIndex].Length > maxSybolsInWord)
          {
            int separatorsCount = separatedStringArr[strIndex].Length / maxSybolsInWord;
            string smothString = separatedStringArr[strIndex];
            for (int addCount = 1; addCount < separatorsCount + 1; addCount++)
            {
              smothString = smothString.Insert(maxSybolsInWord * addCount, " &shy; ");
            }
            separatedStringArr[strIndex] = smothString;
          }
        }
        outString = string.Join(" ", separatedStringArr);
      }
      return outString;
    }

    public static string ReplaceNonAlphaNumWithRandom(string p_sInput)
    {
      if (!string.IsNullOrEmpty(p_sInput))
        return m_regex.Replace(p_sInput, new MatchEvaluator(ReplaceNonAlphaNum));
      return string.Empty;
    }

    private static string ReplaceNonAlphaNum(Match p_match)
    {
      string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
      return guid.Substring(new Random().Next(0, guid.Length - 1), 1);
    }

    public static string Format(string format, string[] args)
    {
      var sb = new StringBuilder(format);
      if (args != null)
      {
        for (int i = 0; i < args.Length; i++)
        {
          var arg = args[i];
          sb.Replace(string.Concat("{", i, "}"), args[i] ?? string.Empty);
        }
      }
      return Regex.Replace(sb.ToString(), @"{\d+}", string.Empty);
    }
  }
}