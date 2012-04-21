DELETE  FROM [dbo].[Dictionaries_MessageTemplates]


INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 1
        , N'SellingSelected'
        , N'Your offer selected'
        , N'На ваше объявление поступил отклик.'
        , N'The buyer "{0}" selected your offer "{1}".'
        , N'Пользователь "{0}" стал потенциальным покупателем в вашем объявлении "{1}".'
        )

INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 2
        , N'SellingConfirmed'
        , N'The offer has been paid'
        , N'Товар оплачен'
        , N'The buyer "{0}" has paid for your offer "{1}".'
        , N'Покупатель "{0}" оплатил товар по сделке "{1}". Теперь вам необходимо передать товар покупателю. После того, как покупатель подтвердит факт получения товара, денежные средства будут зачислены на ваш счет.'
        )


INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 3
        , N'SellingFinised'
        , N'Your deal finished'
        , N'Cделка завершена'
        , N'The buyer "{0}" confirmed delivery of the goods and finished your deal "{1}".'
        , N'Пользователь "{0}" подтвердил получение товара и завершил вашу сделку "{1}".'
        )
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 4
        , N'SellingAbandoned'
        , N'Refusing in participation'
        , N'Отказ по объявлению'
        , N'The seller "{0}" excluded you from list of potential buyers in the offer "{1}".'
        , N'Продавец "{0}" исключил вас из списка потенциальных покупателей по объявлению "{1}".'
        )
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 5
        , N'SellingConflicted'
        , N'The deal disputed'
        , N'Конфликтная сделка'
        , N'The deal "{0}" was disputed by the user "{1}". Please contact administrator.'
        , N'На вас поступила жалоба от пользователя "{1}". Сделка "{0}" перешла в состяние конфликта. Пожалуйста, свяжитесь с администрацией сервиса.'
        )
        
         
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 6
        , N'SellingDeleted'
        , N'The offer deleted'
        , N'Предложение удалено'
        , N'The offer "{0}" accepted by you was removed by the seller "{1}".'
        , N'Объявление "{0}", которое вы выбрали, было удалено продавцом "{1}".'
        )
        
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 7
        , N'SellingCanceled'
        , N'The offer canceled'
        , N'Предложение отменено'
        , N'The offer "{0}" was canceled by the user "{1}".'
        , N'Пользователь "{1}" отказался от участия в сделке "{0}".'
        )
        
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 8
        , N'SellingAccepted'
        , N'You became the buyer'
        , N'Вы стали покупателем'
        , N'The seller "{1}" selected you as a buyer in the offer "{0}".'
        , N'Продавец "{1}" выбрал вас в качестве покупателя по объявлению "{0}". Теперь вам необходимо оплатить товар.'
        )
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 9
        , N'BuyingAccepted'
        , N'Your offer for demand accepted'
        , N'Ваш отклик на заявку принят'
        , N'Your offer for demand "{0}" was accepted by the buyer "{1}".'
        , N'Ваше предложение на объявление о покупке "{0}" было принято покупателем "{1}".'
        )
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 10
        , N'BuyingRejected'
        , N'Your offer rejected'
        , N'Ваше предложение отклонено'
        , N'Your offer "{0}" proposed for the demand "{1}" was rejected by the buyer "{2}".'
        , N'Ваше предложение "{0}" оставленное на объявление о покупке "{1}" было отклонено покупателем "{2}".'
        )
        
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 11
        , N'SellingSuggested'
        , N'The new offer suggested'
        , N'Оставлено новое предложение'
        , N'The new offer "{0}" was suggested by the user "{1}" on your demand "{2}"'
        , N'Новое предложение "{0}" было оставлено пользователем "{1}" на ваше объявление о покупке "{2}"'
        )
        
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 12
        , N'SellingBuyerAbandon'
        , N'Lost potential buyer'
        , N'Потенциальный покупатель отказался от предложения'
        , N'The potential buyer "{0}" is no longer participating in your offer "{1}".'
        , N'Потенциальный покупатель "{0}" отказался от вашего объявления "{1}".'
        )
        
        
INSERT  [dbo].[Dictionaries_MessageTemplates]
        ( [MessageTemplateId]
        , [Name]
        , [Subject]
        , [SubjectRu]
        , [Body]
        , [BodyRu]
        )
VALUES  ( 13
        , N'BuyingDeleted'
        , N'The demand deleted'
        , N'Заявка удалена'
        , N'The demand "{0}" accepted by you was removed by the buyer "{1}".'
        , N'Объявление о покупке "{0}", которое вы выбрали, было удалено покупателем "{1}".'
        )                