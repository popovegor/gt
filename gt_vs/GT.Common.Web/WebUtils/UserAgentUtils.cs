using System;
using System.Web;
using System.Collections.Generic;

namespace GT.Common.Web.WebUtils
{
    public class UserAgentUtils
    {
        public class SearchBots
        {
            static object _sync = new object();

            public class YandexBot
            {
                public const string MAIN = "Mozilla/5.0 (compatible; YandexBot/3.0)";
                public const string MIRROW = "Mozilla/5.0 (compatible; YandexBot/3.0; MirrorDetector)";
                public const string IMAGE = "Mozilla/5.0 (compatible; YandexImages/3.0)";
                public const string VIDEO = "Mozilla/5.0 (compatible; YandexVideo/3.0)";
                public const string MEDIA = "Mozilla/5.0 (compatible; YandexMedia/3.0)";
                public const string BLOGS = "Mozilla/5.0 (compatible; YandexBlogs/0.99; robot)";
                public const string ADDURL = "Mozilla/5.0 (compatible; YandexAddurl/2.0)";
                public const string FAVICONS = "Mozilla/5.0 (compatible; YandexFavicons/1.0)";
                public const string DIRECT = "Mozilla/5.0 (compatible; YandexDirect/3.0)";
                public const string DIRECTDAYTEL = "Mozilla/5.0 (compatible; YandexDirect/2.0; Dyatel)";
                public const string METRIKA = "Mozilla/5.0 (compatible; YandexMetrika/2.0)";
                public const string CATALOGDAYTEL = "Mozilla/5.0 (compatible; YandexCatalog/3.0; Dyatel)";
                public const string NEWS = "Mozilla/5.0 (compatible; YandexNews/3.0)";
            }

            public class GoogleBot
            {
                public const string MAIN = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";
                public const string ALTERNATIVE = "Googlebot/2.1 (+http://www.google.com/bot.html)";
                public const string ALTERNATIVE2 = "Googlebot/2.1 (+http://www.googlebot.com/bot.html)";
                public const string IMAGE = "Googlebot-Image/1.0";
                public const string IMAGE2 = "Googlebot-Image (Google) Googlebot-Image/1.0";
                public const string ADSENSE = "Mediapartners-Google";
                public const string MOBILE = "Googlebot-Mobile (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)";
                public const string GSA = "Google Search Appliance (Google) gsa-crawler";
                public const string ADSVALIDATOR = "AdsBot-Google (+http://www.google.com/adsbot.html)";
            }

            public class BingBot
            {
                public const string MAIN = "msnbot/2.0b (+http://search.msn.com/msnbot.htm)";
                public const string MAIN2 = "msnbot/1.1 (+http://search.msn.com/msnbot.htm)";
                public const string MAINNEW = "msnbot/2.1";
            }

            static IList<string> s_Bots;
            public static IList<string> List
            {
                get
                {
                    if (s_Bots == null)
                    {
                        lock (_sync)
                        {
                            if (s_Bots == null)
                            {
                                s_Bots = new List<string>();

                                //Yandex
                                s_Bots.Add(YandexBot.ADDURL);
                                s_Bots.Add(YandexBot.BLOGS);
                                s_Bots.Add(YandexBot.CATALOGDAYTEL);
                                s_Bots.Add(YandexBot.DIRECT);
                                s_Bots.Add(YandexBot.DIRECTDAYTEL);
                                s_Bots.Add(YandexBot.FAVICONS);
                                s_Bots.Add(YandexBot.IMAGE);
                                s_Bots.Add(YandexBot.MAIN);
                                s_Bots.Add(YandexBot.MEDIA);
                                s_Bots.Add(YandexBot.METRIKA);
                                s_Bots.Add(YandexBot.MIRROW);
                                s_Bots.Add(YandexBot.NEWS);
                                s_Bots.Add(YandexBot.VIDEO);

                                //Google
                                s_Bots.Add(GoogleBot.ADSENSE);
                                s_Bots.Add(GoogleBot.ADSVALIDATOR);
                                s_Bots.Add(GoogleBot.ALTERNATIVE);
                                s_Bots.Add(GoogleBot.ALTERNATIVE2);
                                s_Bots.Add(GoogleBot.GSA);
                                s_Bots.Add(GoogleBot.IMAGE);
                                s_Bots.Add(GoogleBot.IMAGE2);
                                s_Bots.Add(GoogleBot.MAIN);
                                s_Bots.Add(GoogleBot.MOBILE);

                                //Bing
                                s_Bots.Add(BingBot.MAIN);
                                s_Bots.Add(BingBot.MAIN2);
                                s_Bots.Add(BingBot.MAINNEW);
                            }
                        }
                    }

                    return s_Bots;
                }
            }
        }

        public static bool IsSearchBot
        {
            get
            {
                if (HttpContext.Current != null)
                {
                    return SearchBots.List.Contains(HttpContext.Current.Request.UserAgent);
                }

                return false;
            }
        }
    }
}
