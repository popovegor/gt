DELETE  FROM [dbo].[Dictionaries_WebMoneyMessages]

INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -100
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'общая ошибка при разборе команды. неверный формат команды.'
        )
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -110
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'запросы отсылаются не с того IP адреса, который указан при регистрации данного интерфейса в Технической поддержке.'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -1
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/reqn'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -2
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/sign'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -3
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/tranid'
        )
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -3
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/pursesrc'
        )
        
  INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -4
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/pursesrc'
        )
        
        
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -5
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/pursedest'
        )
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -6
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/amount'
        )  
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -7
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/desc'
        )              
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -8
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'слишком длинное поле w3s.request/trans/pcode'
        )        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -9
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'поле w3s.request/trans/pcode не должно быть пустым если w3s.request/trans/period > 0'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -10
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'поле w3s.request/trans/pcode должно быть пустым если w3s.request/trans/period = 0'
        )    
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -11
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/pursesrc'
        )    
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -12
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/trans/wminvid'
        )    
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -13
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'идентификатор переданный в поле w3s.request/wmid не зарегистрирован'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -14
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'проверка подписи не прошла'
        )    
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -15
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/wmid'
        )    
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 102
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'не выполнено условие постоянного увеличения значения параметра w3s.request/reqn'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 103
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'транзакция с таким значением поля w3s.request/trans/tranid уже выполнялась'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 110
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'нет доступа к интерфейсу'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 111
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'попытка перевода с кошелька не принадлежащего WMID, которым подписывается запрос; при этом доверие не установлено.'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 4
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'внутренняя ошибка при создании транзакции'
        )   
        
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 15
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'внутренняя ошибка при создании транзакции'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 19
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'внутренняя ошибка при создании транзакции'
        )   
        
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 23
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'внутренняя ошибка при создании транзакции'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -15
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'неверное значение поля w3s.request/wmid'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 5
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'идентификатор отправителя не найден'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 6
		, 2
        , N'Error. Correspond not found.'
        , N'Ошибка. Корреспондент не найден.'
        , N'корреспондент не найден'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 7
		, 2
        , N'Error. Your purse is not found.'
        , N'Ошибка. Ваш кошелек не найден.'
        , N'кошелек получателя не найден'
        )
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 11
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'кошелек отправителя не найден'
        )   

 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 13
		, 2
        , N'Error. Transaction amount must be more zero.'
        , N'Ошибка. Сумма транзакции должна быть больше нуля.'
        , N'сумма транзакции должна быть больше нуля'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 17
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'недостаточно денег в кошельке для выполнения операции'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 21
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'счет, по которому совершается оплата не найден'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 22
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'по указанному счету оплата с протекцией не возможна'
        )
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 25
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'время действия оплачиваемого счета закончилось'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 26
		, 2
        , N'Error. Purses must be different.'
        , N'Ошибка. В операции должны участвовать разные кошельки.'
        , N'в операции должны участвовать разные кошельки'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 29
		, 2
        , N'Error. Types of purses must be the same.'
        , N'Ошибка. Типы кошельков отличаются.'
        , N'типы кошельков отличаются'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 30
		, 2
        , N'Error. Purse does not support direct transfer.'
        , N'Ошибка. Кошелек не поддерживает прямой перевод.'
        , N'кошелек не поддерживает прямой перевод'
        )   
        
 INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 35
		, 2
        , N'System error. Please, contact administrator.'
        , N'Системная ошибка. Обратитесь к администратору.'
        , N'плательщик не авторизован корреспондентом для выполнения данной операции'
        )   
        
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 58
		, 2
        , N'Error. Limit of your purse is overflow.'
        , N'Ошибка. Превышен лимит средств на кошельках получателя.'
        , N'превышен лимит средств на кошельках получателя'
        )   
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 0
		, 2
        , NULL
        , NULL
        , N'ok'
        ) 
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 0
		, 1
        , NULL
        , NULL
        , N'ok'
        )
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 0
		, 3
        , NULL
        , NULL
        , N'ok'
        )
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 1
		, 4
        , 'Top up your gameismoney.ru account.'
        , 'Пополнение счета GameIsMoney.RU'
        , N'topup description'
        ) 
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 2
		, 4
        , 'Draw out from GameIsMoney.Ru'
        , 'Вывод средств из GameIsMoney.Ru'
        , N'draw out description'
        ) 
        
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( 3
		, 4
        , 'gameismoney.ru'
        , 'gameismoney.ru'
        , N'address'
        )
        
 
      
INSERT  [dbo].[Dictionaries_WebMoneyMessages]
        ( [Retcode]
		, [Type]	
        , [Message]
        , [MessageRu]
        , [Description]
        )
VALUES  ( -1
		, 4
        , 'Webmoney transfer error. For more details, please, contact administrator.'
        , 'Ошибка системы webmoney. Для подробностей свяжитесь с администратором.'
        , N'default error'
        )                                                                                                                                                          