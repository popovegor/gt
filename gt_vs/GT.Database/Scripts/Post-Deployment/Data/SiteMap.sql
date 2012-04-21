DELETE  [dbo].[SiteMap]

/****** Object:  Table [dbo].[SiteMap]    Script Date: 12/11/2009 01:18:06 ******/

INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 0
        , N'Home'
        , N'Заглавная'
        , N'Home'
        , N'Gameismoney.ru - здесь вы можете купить или продать различные товары из ваших любимых игр: аккаунты, персонажей, игровую валюту, карты оплаты и многое другое. Сервис Game is Money поможет вам максимально комфортно и безопасно реализовать свой товар или купить то, что вы искали - перса, голд, адену. Надежность, простота, скорость, поддержка большого количества он-лайн игр и серверов – вот наши преимущества.'
        , N'~/'
        , NULL
        , -1
        , NULL
        , NULL
        , 'Buy, sell character, account, pers selling, game money, currency, pay for game'
        , 'Куплю, продам персонажа, аккаунт, продажа перса, игровая валюта, оплата игр'
        , 'Selling characters, accounts, pers, buy, sell pers, game money, game currency, pay for game'
        , 'Game is Money — покупка и продажа персонажей, аккаунтов, игровой валюты'
        )  

INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 1
        , N'Sign up'
        , N'Регистрация'
        , N'Sign up'
        , N'Регистрация на портале GameIsMoney.Ru Зарегистрируйтесь и получите возможность покупать и продавать игровые товары.'
        , N'~/Authentication/SignUp.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Sign up gameismoney.ru, simple registration, allow to, sell, buy, game goods, world of warcraft, wow, lineage 2, allods online, aion, perfect world'
        , 'Регистрация на gameismoney.ru, возможность покупать, продавать, игровые товары, world of warcraft, wow, lineage 2, аллоды онлайн, aion, perfect world'
        , 'Sign Up'
        , 'Регистрация'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 2
        , N'Sign in'
        , N'Вход'
        , N'Sign in'
        , N'Вход на портал GameIsMoney.Ru Войдите под своей учетной записью, чтобы получить возможность покупать и продавать игровые товары.'
        , N'~/Authentication/SignIn.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Sign In'
        , 'Вход'
        , 'Sign In'
        , 'Вход'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 3
        , N'Office'
        , N'Личный кабинет'
        , N'Office'
        , N'Личный кабинет пользователя - управляйте своими покупками и продажами, изменяйте свои учетные данные, пополняйте счет и выводите прибыль.'
        , N'~/Office'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Office'
        , 'Личный кабинет'
        , 'Office'
        , 'Личный кабинет'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 4
        , N'Selling'
        , N'Объявления о продаже'
        , N'Selling'
        , N'Продажа персонажей, игровых товаров, аккаунтов, игровой валюты. Здесь вы можете найти товары из таких игр как World of warcraft, lineage 2, allods online, perfect world, aion и многих других. Выберете понравившееся объявление, чтобы купить желаемый товар, например купить перса. Если вы желаете сами что-либо продать, то разместите свое объявление.'
        , N'~/Selling'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Sell accounts, characters, gold, adena, kinars, isk, wow, allods, lineage, eve'
        , 'Продать аккаунты, персонажей, голд, адену, кинары, вов, аллоды, wow, lineage'
        , 'Sell accounts, characters, game money, gold, adena, kinars, selling pers, wow, allods, lineage'
        , 'Продать аккаунты, персонажей, игровую валюту, голд, адену, кинары, кристаллы, перса, вов, аллоды, wow, lineage, perfect world'
        )  
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 5
        , N'Buying'
        , N'Объявления о покупке'
        , N'Buying'
        , N'Покупка персонажей, игровых товаров, аккаунтов, игровой валюты. Здесь пользователи оставляют объявления о покупке товаров из таких игр как World of warcraft, lineage 2, аллоды онлайн, perfect world, aion и многих других. Выберете понравившееся оюъявление, чтобы предложить свой товар, например, вы хотите продать перса. Если вы желаете сами что-либо купить, то разместите своё объявление о продаже.'
        , N'~/Buying'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Buy wow, gold, adena, kinars, isk, lineage 2, accounts, allods, characters'
        , 'Купить wow, вов, голд, gold, адену, кинары, lineage,аккаунты, аллоды, персонажей'
        , 'Buy wow, lineage 2, aion, gold, adena, accounts, pers, characters, game money'
        , 'Купить персонажей, аккаунты, игровоую валюту, голд, адену, кинары, перса, кристаллы, аллоды, wow, lineage, вов, perfect world'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 10
        , N'Help'
        , N'Помощь пользователям'
        , N'Help'
        , N'Помощь пользователям - как заключать сделки, вопросы о пополнении счета и выводе денежных средств, как с нами связаться, пользовательское соглашение и контактная информация'
        , N'~/Help/General'
        , NULL
        , 0
        , NULL
        , NULL
        , 'help, offers, deals, demands, contacts, selling, buying info'
        , 'help, сделки, покупка продажа игровых товаров'
        , 'Help'
        , 'Помощь пользователям'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 1001
        , N'How to buy'
        , N'Как покупать'
        , N'How to buy'
        , N'Помощь - как заключать сделки, вопросы о пополнении счета и выводе денежных средств, как с нами связаться, пользовательское соглашение и контактная информация'
        , N'~/Help/HowBuy'
        , NULL
        , 10
        , NULL
        , NULL
        , 'help, offers, deals, demands, contacts, selling, buying info'
        , 'help, сделки, покупка продажа игровых товаров'
        , 'How to buy'
        , 'Как покупать'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 1002
        , N'How to sell'
        , N'Как продавать'
        , N'How to sell'
        , N'Помощь - как заключать сделки, вопросы о пополнении счета и выводе денежных средств, как с нами связаться, пользовательское соглашение и контактная информация'
        , N'~/Help/HowSell'
        , NULL
        , 10
        , NULL
        , NULL
        , 'help, offers, deals, demands, contacts, selling, buying info'
        , 'help, сделки, покупка продажа игровых товаров'
        , 'How to sell'
        , 'Как продавать'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 1003
        , N'Money transactions'
        , N'Денежные операции'
        , N'Money transactions'
        , N'Помощь - как заключать сделки, вопросы о пополнении счета и выводе денежных средств, как с нами связаться, пользовательское соглашение и контактная информация'
        , N'~/Help/Billing'
        , NULL
        , 10
        , NULL
        , NULL
        , 'help, offers, deals, demands, contacts, selling, buying info'
        , 'help, сделки, покупка продажа игровых товаров'
        , 'Money transactions'
        , 'Денежные операции'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 1004
        , N'Rules and agreements'
        , N'Правила и соглашения'
        , N'Rules and agreements'
        , N'Помощь - как заключать сделки, вопросы о пополнении счета и выводе денежных средств, как с нами связаться, пользовательское соглашение и контактная информация'
        , N'~/Help/Rules'
        , NULL
        , 10
        , NULL
        , NULL
        , 'help, offers, deals, demands, contacts, selling, buying info'
        , 'help, сделки, покупка продажа игровых товаров'
        , 'Rules and agreements'
        , 'Правила и соглашения'
        )
                
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 6
        , N'Password Recovery'
        , N'Восстановление пароля'
        , N'Password Recovery'
        , N'Забыли свой пароль? Здесь вы можете его восстановить.'
        , N'~/Authentication/PasswordRecovery.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Password recovery'
        , 'Восстановление пароля'
        , 'Password recovery'
        , 'Восстановление пароля'
        )

INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 7
        , N'Game Info'
        , N'Информация об игре'
        , N'Game Info'
        , N'Информация об игре'
        , N'~/Games/Game.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Game Info'
        , 'Информация об игре'
        , 'Game Info'
        , 'Информация об игре'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 8
        , N'Server Info'
        , N'Информация о сервере'
        , N'Server Info'
        , N'Информация о сервере'
        , N'~/Servers/Server.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Server Info'
        , 'Информация о сервере'
        , 'Server Info'
        , 'Информация о сервере'
        )
  
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 9
        , N'User information'
        , N'Информация о пользователе'
        , N'User information'
        , N'Информация о пользователе'
        , N'~/Users/User.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'User information'
        , 'Информация о пользователе'
        , 'User information'
        , 'Информация о пользователе'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 18
        , N'An error occurred'
        , N'Произошла ошибка :('
        , N'An error occurred'
        , N'Произошла ошибка :('
        , N'~/Error.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'An error occurred'
        , 'Произошла ошибка :('
        , 'An error occurred'
        , 'Произошла ошибка :('
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 311
        , N'Change your e-mail'
        , N'Смена эл. адреса'
        , N'Change your e-mail'
        , N'Смена эл. адреса'
        , N'~/Authentication/ChangeEmail.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Change your e-mail'
        , 'Смена эл. адреса'
        , 'Change your e-mail'
        , 'Смена эл. адреса'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 315
        , N'Change your password'
        , N'Смена пароля'
        , N'Change your password'
        , N'Смена пароля'
        , N'~/Authentication/ChangePassword.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Change your password'
        , 'Смена пароля'
        , 'Change your password'
        , 'Смена пароля'
        )
  
  
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 16
        , N'Notification disabling'
        , N'Отмена опевещения'
        , N'Notification disabling'
        , N'Отмена опевещения'
        , N'~/Notification/Unsubscribe.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Notification cancel'
        , 'Отмена опевещения'
        , 'Notification cancel'
        , 'Отмена опевещения'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 17
        , N'Registration confirmation'
        , N'Подтверждение регистрации'
        , N'Registration confirmation'
        , N'Подтверждение регистрации'
        , N'~/Authentication/Confirmation.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Registration confirmation'
        , 'Подтверждение регистрации'
        , 'Registration confirmation'
        , 'Подтверждение регистрации'
        ) 
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 31
        , N'Profile'
        , N'Профиль'
        , N'Profile'
        , N'Профиль'
        , N'~/PersonalAccount/Profile.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'User Profile'
        , 'Профиль пользователя'
        , 'User Profile'
        , 'Профиль пользователя'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 321
        , N'Incoming messages'
        , N'Полученные сообщения'
        , N'Incoming messages'
        , N'Полученные сообщения'
        , N'~/MessageSystem/MessageViewer2.aspx?d=in'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Incoming messages'
        , 'Полученные сообщения'
        , 'Incoming messages'
        , 'Полученные сообщения'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 322
        , N'Outgoing messages'
        , N'Отправленные сообщения'
        , N'Outgoing messages'
        , N'Отправленные сообщения'
        , N'~/MessageSystem/MessageViewer2.aspx?d=out'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Outgoing messages'
        , 'Отправленные сообщения'
        , 'Outgoing messages'
        , 'Отправленные сообщения'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 33
        , N'Transfers'
        , N'Денежные переводы'
        , N'Transfers'
        , N'Денежные переводы'
        , N'~/BillingSystem/TransferViewer.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Transfers'
        , 'Денежные переводы'
        , 'Transfers'
        , 'Денежные переводы'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 34
        , N'Top up'
        , N'Пополнение счета'
        , N'Top up'
        , N'Пополнение счета'
        , N'~/BillingSystem/TopUp.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Top up'
        , 'Пополнение счета'
        , 'Top up'
        , 'Пополнение счета'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 35
        , N'My sales'
        , N'Мои продажи'
        , N'My sales'
        , N'Мои продажи'
        , N'~/Office/Selling'
        , NULL
        , 3
        , NULL
        , NULL
        , 'My sales'
        , 'Мои продажи'
        , 'My sales'
        , 'Мои продажи'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 36
        , N'My purchases'
        , N'Мои покупки'
        , N'My purchases'
        , N'Мои покупки'
        , N'~/Office/Buying'
        , NULL
        , 3
        , NULL
        , NULL
        , 'My purchases'
        , 'Мои покупки'
        , 'My purchases'
        , 'Мои покупки'
        )      
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 37
        , N'All feedbacks'
        , N'Все отзывы'
        , N'All feedbacks'
        , N'Все отзывы'
        , N'~/UserRating/FeedbackViewer.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'All feedbacks'
        , 'Все отзывы'
        , 'All feedbacks'
        , 'Все отзывы'
        )  
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 371
        , N'Feedbacks as buyer'
        , N'Отзывы как покупателю'
        , N'Feedbacks as buyer'
        , N'Отзывы как покупателю'
        , N'~/UserRating/FeedbackViewer.aspx?ab=true'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Feedbacks as buyer'
        , 'Отзывы как покупателю'
        , 'Feedbacks as buyer'
        , 'Отзывы как покупателю'
        )  
        
        
                
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 372
        , N'Feedbacks as seller'
        , N'Отзывы как продавцу'
        , N'Feedbacks as seller'
        , N'Отзывы как продавцу'
        , N'~/UserRating/FeedbackViewer.aspx?as=true'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Feedbacks as seller'
        , 'Отзывы как продавцу'
        , 'Feedbacks as seller'
        , 'Отзывы как продавцу'
        )  
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 373
        , N'Feedbacks for others'
        , N'Отзывы другим пользователям'
        , N'Feedbacks for others'
        , N'Отзывы другим пользователям'
        , N'~/UserRating/FeedbackViewer.aspx?fo=true'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Feedbacks for others'
        , 'Отзывы другим пользователям'
        , 'Feedbacks for others'
        , 'Отзывы другим пользователям'
        ) 
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 3701
        , N'Feedback'
        , N'Отзыв пользователю'
        , N'Feedback'
        , N'Отзыв пользователю'
        , N'~/UserRating/LeaveFeedback.aspx'
        , NULL
        , 37
        , NULL
        , NULL
        , 'Feedback'
        , 'Отзыв пользователю'
        , 'Feedback'
        , 'Отзыв пользователю'
        ) 

INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 38
        , N'Draw out'
        , N'Вывод денежных средств'
        , N'Draw out'
        , N'Вывод денежных средств'
        , N'~/BillingSystem/DrawOut.aspx'
        , NULL
        , 3
        , NULL
        , NULL
        , 'Draw out'
        , 'Вывод денежных средств'
        , 'Draw out'
        , 'Вывод денежных средств'
        ) 


                
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 352
        , N'Edit the offer'
        , N'Редактирование объявления о продаже'
        , N'Edit the offer'
        , N'Редактирование объявления о продаже'
        , N'~/Offers/EditSelling.aspx?Id='
        , NULL
        , 35
        , NULL
        , NULL
        , 'Edit the offer'
        , 'Редактирование объявления о продаже'
        , 'Edit the offer'
        , 'Редактирование объявления о продаже'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 351
        , N'Add new offer'
        , N'Размещение объявления о продаже'
        , N'Add new offer'
        , N'Размещение объявления о продаже'
        , N'~/Offers/EditSelling.aspx'
        , NULL
        , 35
        , NULL
        , N'if (window.PopupManager) {PopupManager.Open(EditSelling, {Id : 0}); return false;} return true;'
        , 'Add new offer'
        , 'Размещение объявления о продаже'
        , 'Add new offer'
        , 'Размещение объявления о продаже'
        )
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 43
        , N'Selling offer info'
        , N'Объявление о продаже'
        , N'Selling offer info'
        , N'Объявление о продаже'
        , N'~/Offers/ViewSelling.aspx '
        , NULL
        , 4
        , NULL
        , NULL
        , 'Selling offer info'
        , 'Объявление о продаже'
        , 'Selling offer info'
        , 'Объявление о продаже'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 362
        , N'Edit the demand'
        , N'Редактирование объявления о покупке'
        , N'Edit the demand'
        , N'Редактирование объявления о покупке'
        , N'~/Offers/EditBuying.aspx?Id='
        , NULL
        , 36
        , NULL
        , NULL
        , 'Edit the demand'
        , 'Редактирование объявления о покупке'
        , 'Edit the demand'
        , 'Редактирование объявления о покупке'
        )
 
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 361
        , N'Add new demand'
        , N'Размещение объявления о покупке'
        , N'Add new demand'
        , N'Размещение объявления о покупке'
        , N'~/Offers/EditBuying.aspx'
        , NULL
        , 36
        , NULL
        , N'if (window.PopupManager) {PopupManager.Open(EditBuying, {Id : 0}); return false;} return true;'
        , 'Add new demand'
        , 'Размещение объявления о покупке'
        , 'Add new demand'
        , 'Размещение объявления о покупке'
        ) 


INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 53
        , N'Buying offer info'
        , N'Объявление о покупке'
        , N'Buying offer info'
        , N'Объявление о покупке'
        , N'~/Offers/ViewBuying.aspx'
        , NULL
        , 5
        , NULL
        , NULL
        , 'Buying offer info'
        , 'Объявление о покупке'
        , 'Buying offer info'
        , 'Объявление о покупке'
        )         
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 13
        , N'News archive'
        , N'Архив новостей'
        , N'News archive'
        , N'Архив игровых и около игровых новостей. Что нового в мире ММО? Когда релизится долгожданная игра? Игровые выставки и конференции игровой индустрии. Все самое свежее и интересное об играх, их дополнениях и патчах.'
        , N'~/News/NewsArchive.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'News archive, mmo news, updates, patches, addons, plugins'
        , 'Архив новостей, ммо новости, обновления, патчи, аддоны, плагины'
        , 'News archive'
        , 'Архив новостей'
        )
        
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 12
        , N'News'
        , N'Новости'
        , N'News'
        , N'Новости'
        , N'~/DetailsInfo/NewsInfo.aspx'
        , NULL
        , 0
        , NULL
        , NULL
        , 'News'
        , 'Новости'
        , 'News'
        , 'Новости'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 71
        , N'World of Warcraft'
        , N'World of Warcraft'
        , N'World of Warcraft'
        , N'World of Warcraft - популярнейшая онлайн игра от компании Blizzard. Согласно книге рекордов Гиннесса, World of Warcraft является самой популярной MMORPG в мире. '
        , N'~/Games/Game.aspx?id=1'
        , NULL
        , 0
        , NULL
        , NULL
        , 'World of warcraft, wow, buy, sell gold, accounts, artefacts, characters, time card'
        , 'World of warcraft, wow, вов, купить, продать голд, gold, аккаунты, персонажей'
        , 'Worlds of warcrat, wow, buy, sell gold, accounts, artefacts, characters, time cards - GameIsMoney.Com'
        , 'World of warcraft, wow, вов, купить, продать голд, gold, аккаунты, персонажей - GameIsMoney.Ru'
        )
        
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 72
        , N'Lineage 2'
        , N'Lineage 2'
        , N'Lineage 2'
        , N'Lineage 2 - фэнтезийная массовая многопользовательская ролевая интернет-игра (MMORPG) для PC, является приквелом, действие которого происходит за 150 лет до событий Lineage. На данный момент выпущено 14 дополнений для игры. После серии Chaotic Chronicle началась серия Chaotic Throne. После установки обновления Freya, будет установлено обновление Chaotic Throne: High Five, которое уже тестируется на Корейских серверах Lineage 2.'
        , N'~/Games/Game.aspx?id=2'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Lineage 2, la2, l2, buy, sell adena, accounts, characters'
        , 'Lineage 2, la2, l2, купить, продать адену, продажа адены, оружие lineage'
        , 'Lineage 2, la2, buy, sell adena, accounts, lineage weapons - GameIsMoney.Com'
        , 'Lineage 2, la2, l2, купить, продать адену, продажа адены, оружие lineage - GameIsMoney.Ru'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 73
        , N'Allods Online'
        , N'Аллоды Онлайн'
        , N'Allods Online'
        , N'Аллоды Онлайн - многопользовательская ролевая онлайн-игра, продолжающая игровую серию «Аллоды», но уже в масштабе MMORPG-вселенной. Игру разрабатывает студия Astrum Nival.'
        , N'~/Games/Game.aspx?id=4'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Allods online, characters, money, buy, sell, accounts, cristals'
        , 'Аллоды персонажи, прокачка, аллоды онлайн деньги, аккаунт аллоды, кристаллы'
        , 'Allods online characters, cristals, money, accounts - GameIsMoney.Com'
        , 'Аллоды персонажи, прокачка, аллоды онлайн деньги, аккаунт аллоды, кристаллы - GameIsMoney.Ru'
        )


INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 341
        , N'Top up failed'
        , N'Ошибка пополнения счета'
        , N'Top up failed'
        , N'Ошибка пополнения счета'
        , N'~/BillingSystem/TopUpFailed.aspx'
        , NULL
        , 34
        , NULL
        , NULL
        , NULL
        , NULL
        , 'Top up failed'
        , 'Ошибка пополнения счета'
        )
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 74
        , N'Perfect world'
        , N'Perfect world'
        , N'Perfect world'
        , N'Perfect world - китайская многопользовательская ролевая онлайн-игра, созданная компанией Beijing Perfect World. На данный момент она запущена во многих странах мира и имеет несколько различных версий. Действие происходит в мифическом мире Пангу. В игре реализованы смены дня и ночи, полёты в воздухе и плавание под водой.'
        , N'~/Games/Game.aspx?id=5'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Perfect world, buy characters, sell money, accounts, zen, gold, pw pers'
        , 'Perfect world, купить аккаунты, продать персонажа, юани, золото, zen, pw персы'
        , 'Perfect world, buy characters, sell money, accounts, zen, gold - GameIsMoney.Com'
        , 'Perfect world, купить аккаунты, продать персонажа, юани, золото, zen, gold  - GameIsMoney.Ru'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 75
        , N'Combats'
        , N'Бойцовский клуб'
        , N'Combats - fight club, browser mmo game.'
        , N'Бойцовский клуб (бк) - популярная русскоязычная многопользовательская браузерная онлайн-игра. Среди подобных игр БК на просторах Рунета была одной из первых.'
        , N'~/Games/Game.aspx?id=3'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Combats, fight club, buy characters, sell money, accounts, ekr'
        , 'Combats, бойцовский клуб, бк, купить аккаунты, продать персонажа, кр, екр, кредиты, персы'
        , 'Combats, fight club, buy characters, sell money, accounts, ekr - GameIsMoney.Com'
        , 'Combats, бойцовский клуб, бк, купить аккаунты, продать персонажа, кр, екр, кредиты, персы  - GameIsMoney.Ru'
        ) 
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 76
        , N'Legend: Legacy of Dragons'
        , N'Легенда: Наследие Драконов'
        , N'Legend: Legacy of Dragons - warofdragons, MMORPG, browser game'
        , N'Легенда: Наследие Драконов или DWAR — многопользовательская онлайн игра (BBMMORPG). Разработана компанией IT Territory, входящей с состав холдинга Astrum Online Entertainment.'
        , N'~/Games/Game.aspx?id=6'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Legend: Legacy of Dragons, dwar, warofdragons, buy characters, sell money, accounts, gold, magmars'
        , 'Легенда, наследие драконов, dwar, купить аккаунты, продать персонажа, золото, синька, персы, магмар'
        , 'Legend: Legacy of Dragons, dwar, warofdragons, buy characters, sell money, accounts, gold, magmars - GameIsMoney.Com'
        , 'Легенда: наследие драконов, dwar, купить аккаунты, продать персонажа, золото, синька, персы, магмар - GameIsMoney.Ru'
        )
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 77
        , N'EVE Online'
        , N'EVE Online'
        , N'EVE Online is the forerunner of next generation massive multiplayer online role-playing games (MMORPGs) set in a world of galactic magnitude and governed by a hyper capitalistic economy.'
        , N'EVE Online — одна из лучших космических многопользовательских онлайн игр. На нашем сайте вы можете купить или продать ISK, лицензии пилотов, тайм карты и многое другое, что обеспечит вам комфортную и приятную игру.'
        , N'~/Games/Game.aspx?id=7'
        , NULL
        , 0
        , NULL
        , NULL
        , 'EVE Online, buy isk, sell pilot license, eve money, eve online accounts, plex'
        , 'eve online, еве, иски, isk, купить аккаунт, продать деньги eve, plex'
        , 'EVE Online - buy and sell isk, accounts, pilot license, plex - GameIsMoney.Com'
        , 'EVE Online - купить или продать isk, иски, аккаунт, корабли, импланты - GameIsMoney.Ru'
        )   
        

INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 78
        , N'Lords of War and Money'
        , N'Герои войны и денег'
        , N'Lords of War and Money (lordswm) is a fantasy online game that combines tactical combats and economic strategy. Here you can buy or sell gold, resources, artefacts, accounts and heroes from this game.'
        , N'Heroes of War and Money является бесплатной, браузерной, онлайн игрой, с ежедневным онлайном в 10000-15000 игроков. Она сочетает в себе такие жанры как пошаговая стратегия и рпг. Герои войны и денег (гвд) являются еще одной вариацией на тему бессмертных homm. Здесь вы можете купить или продать золото, артефакты, ресурсы, героев, аккаунты из этой игры.'
        , N'~/Games/Game.aspx?id=8'
        , NULL
        , 0
        , NULL
        , NULL
        , 'lords of war and money, lordswm, lwm, hwm, buy gold, account, hero, sell money, artefact, character'
        , 'герои войны и денег, гвд, heroeswd, купить золото, аккаунт, героя, продать персонажа, деньги, продам шмот, куплю арты'
        , 'Lords of War and Money - buy or sell gold, account, artefact, resources, hero - GameIsMoney.Com'
        , 'Герои войны и денег - купить или продать золото, артефакты, ресурсы, аккаунты, героя  - GameIsMoney.Ru'
        )      
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 79
        , N'RF Online'
        , N'RF Online'
        , N'RF ONLINE, rfo, Rising Force — is an SF Action MMORPG with a setting in the extensive outer space. Here you can buy or sell gold, currency, account, pers or artefact from you favorite game.'
        , N'RF ONLINE, rfo — эпическое соединение традиционной фэнтезийной ММОРПГ и уникального футуристического sci-fi действия. Здесь вы можете купить или продать платину, золото, аккаунты, персонажей, артефакты из вашей любимой игры.'
        , N'~/Games/Game.aspx?id=9'
        , NULL
        , 7
        , NULL
        , NULL
        , 'RF online, rfo, Rising Force Online, sell gold, buy account, pers, potion, artefacts'
        , 'RF online, rfo, Rising Force Online, платина, продать аккаунт, перса, купить платину, золото, персонажа, поты'
        , 'RF ONLINE, rfo, Rising Force - buy or sell gold, currency, account, artefact, pers - GameIsMoney.Com'
        , 'RF ONLINE, rfo, Rising Force - купить или продать золото, артефакты, ресурсы, аккаунты, перса - GameIsMoney.Ru'
        )  
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 710
        , N'Aion: The Tower of Eternity'
        , N'Aion: The Tower of Eternity'
        , N'Aion: The Tower of Eternity — is beautiful MMORPG created by NCsoft. Here you can buy or sell kinah, account, wings, pers or artefact from you favorite game.'
        , N'Aion: The Tower of Eternity (Аион башня вечности) — это красивейшая ММОРПГ от NCsoft. Здесь вы можете купить или продать кинары, аккаунты, персонажей, артефакты, крылья из вашей любимой игры.'
        , N'~/Games/Game.aspx?id=10'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Aion: The Tower of Eternity, aion, sell kinah, buy account, pers, wings'
        , 'Aion: The Tower of Eternity, aion, аион, айон, купить кинары, продать перса, аккаунт, персонажа, kinah, крылья'
        , 'Aion: The Tower of Eternity - buy or sell kinah, account, pers, wings, artefact - GameIsMoney.Com'
        , 'Aion: The Tower of Eternity - купить кинары, продать персонажа аион, kinah, аккаунты айона, перса - GameIsMoney.Ru'
        )                            
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 711
        , N'Ganjawars'
        , N'Ganjawars'
        , N'Ganjawars is russian MMORPG about mafia and crime. Here you can buy or sell eun, account, pers or artefact from you favorite game.'
        , N'Ganjawars (Ганджубасовые войны) —  это игра в мафию, боевой симулятор и экономическая стратегия. Здесь вы можете купить или продать ганжабаксы, еноты, аккаунты, персонажей, недвигу из вашей любимой игры.'
        , N'~/Games/Game.aspx?id=11'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Ganjawars, sell eun'
        , 'Ганджубасовые войны, ganjawars, ганжавойны, ганжаварс, ганжабаксы, продать еуны, купить еноты, EUN, Евро-юниты'
        , 'Ganjawars - buy or sell eun, account, pers - GameIsMoney.Com'
        , 'Ganjawars - купить еуны, продать еноты, ганжабаксы, перса, евро-юниты, недвига - GameIsMoney.Ru'
        )   
        
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 712
        , N'Gladiators'
        , N'Гладиаторы'
        , N'Gladiators is a free online game in the world of Ancient Rome. Here you can buy or sell denarius, bonus, account, pers or artefact from you favorite game.'
        , N'Гладиаторы — бесплатная браузерная онлайн игра в жанре симулятора гладиаторских турниров. Здесь вы можете купить или продать денарии, динары, бонусы, аккаунты, персонажей из вашей любимой игры.'
        , N'~/Games/Game.aspx?id=12'
        , NULL
        , 0
        , NULL
        , NULL
        , 'Gladiators, sell denarius, buy bonus, pers'
        , 'Гладиаторы, продать денарии, купить бонусы, аккаунт, обмен бойцами'
        , 'Gladiators - buy or sell denarius, account, bonus, fighters - GameIsMoney.Com'
        , 'Гладиаторы - купить бонусы, продать денарии, бойцов, аккаунт, комплекты - GameIsMoney.Ru'
        ) 
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 7999
        , N'No information info about game'
        , N'Нет информации об игре'
        , N''
        , N''
        , N'~/Games/Game.aspx?id=7999'
        , NULL
        , 0
        , NULL
        , NULL
        , 'No information info about game'
        , 'Нет информации об игре'
        , 'No information info about game - GameIsMoney.Com'
        , 'Нет информации об игре - GameIsMoney.Ru'
        ) 
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 44
        , N'If you need sell'
        , N'Если нужно продать'
        , N'If you need sell'
        , N'Если Вам нужно продать персонажа, аккаунт, игровую валюту, голд, адену, кинары, кристаллы, то вам сюда - GameIsMoney.Ru'
        , N'~/Offers/WantToSell.aspx'
        , NULL
        , 4
        , NULL
        , NULL
        , NULL
        , NULL
        , N'If you want to sell'
        , N'Если нужно продать'
        )
        
        
        
INSERT  [dbo].[SiteMap]
        ( [ID]
        , [Title]
        , [TitleRu]
        , [Description]
        , [DescriptionRu]
        , [Url]
        , [Roles]
        , [Parent]
        , [TemplateName]
        , [JavaScript]
        , [KeyWords]
        , [KeyWordsRu]
        , [PageTitle]
        , [PageTitleRu]
        )
VALUES  ( 54
        , N'If you want to buy'
        , N'Если хотите купить'
        , N'If you want to buy'
        , N'Если Вы хотите купить персонажа, аккаунт, игровую валюту, голд, адену, кинары, кристаллы, то вам сюда - GameIsMoney.Ru'
        , N'~/Offers/WantToBuy.aspx'
        , NULL
        , 5
        , NULL
        , NULL
        , NULL
        , NULL
        , N'If you want to buy'
        , N'Если хотите купить'
        )
        
        
       