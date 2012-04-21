﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="About.ascx.cs" Inherits="GT.Web.Site.Help.About" %>

<h2 class="first" id="general-about">Что это за сайт?</h2>
        <p>Этот сайт представляет собой рынок игровых товаров. Здесь вы можете купить или продать персонажей, ресурсы, артефакты, валюту из ваших любимых компьютерных игр. Покупателями и продавцами тут выступают сами пользователи, а Game is Money контролирует процесс купли-продажи и защищает вас от мошенничества. Все покупки и продажи, совершаемые на сайте, застрахованы по технологии Escrow. </p>
        <h2 id="general-how">Как это работает?</h2>
        <p>Пользователи, приходя на сайт, оставляют объявления о покупке или продаже тех или иных игровых товаров. Каждое объявление проходит модерацию. Когда пользователь находит подходящее ему объявление, он может провести с его автором сделку, соответствующим образом откликнувшись на объявление.</p>
        <p>Любая сделка, проходящая на сайте Game is Money, застрахована по технологии Escrow и контролируется администрацией. Работает это следующим образом:
         </p>
        <ul class="list">
          <li>Покупатель производит оплату до передачи товара. Денежные средства блокируются у него на счете и становятся недоступными.</li>
          <li>Продавец видит факт оплаты товара, подтверждающий платежеспособность покупателя, но фактически денег не получает.</li>
          <li>Продавец передает товар покупателю.</li>
          <li>Убедившись, что товар нужного качества и соответствует ожиданиям, покупатель подтверждает факт получения товара, и денежные средства переходят в распоряжение продавца.</li>
        </ul>
        <p>Таким образом, продавец всегда может быть уверен в платежеспособности покупателя, а покупатель может не волноваться, что продавец передаст некачественный или не соответствующий описанию товар. Все расчеты осуществляются мгновенно и базируются на платежной системе WebMoney Transfer (<a href="<%= BillingUrl %>" target="_self">подробнее</a>). В случае каких-либо спорных моментов или конфликтов между продавцом и покупателем, их разрешением занимается администрация Game is Money.</p>
        <p>Более подробно о том, как проходят сделки в системе, читайте в разделах <a href="<%= HowBuyUrl %>" target="_self">Как покупать</a>, <a href="<%= HowSellUrl %>" target="_self">Как продавать.</a></p>