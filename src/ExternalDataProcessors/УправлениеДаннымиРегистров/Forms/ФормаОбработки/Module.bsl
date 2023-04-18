#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИнициализироватьКартинки();
	ИнициализироватьСписокРегистров();
	ВыполнятьВТранзакции = Истина;
	ОбменДаннымиЗагрузка = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПолноеИмяПриИзменении(Элемент)
	
	ИмяРегистратора = "";	
	ОписаниеРегистра = ПолучитьОписаниеРегистра(ПолноеИмя);
	УстановитьСписокВыбораРегистраторов();
	УстановитьТекстЗапроса();
	СоздатьКолонки();
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяРегистратораПриИзменении(Элемент)
	УстановитьТекстЗапроса();
	СоздатьКолонки();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Список.ДанныеСтроки(ВыбраннаяСтрока);		
	ДанныеЗаписи  = ПолучитьДанныеСтрокиСписка(ТекущиеДанные);
	
	ОткрытьФормуВводаЗаписи("Изменить", Новый Структура("ДанныеЗаписи", ДанныеЗаписи));	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьЗапись(Команда)
	
	ОткрытьФормуВводаЗаписи("Добавить");	
	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьЗапись(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеЗаписи = ПолучитьДанныеСтрокиСписка(ТекущиеДанные);
	
	ОткрытьФормуВводаЗаписи("Скопировать", Новый Структура("ДанныеЗаписи", ДанныеЗаписи));
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВыделенныеЗаписи(Команда)
	
	ВыделенныеСтроки = Элементы.Список.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбУдаленииЗаписи", ЭтотОбъект);
	ПоказатьВопрос(ОписаниеОповещения, "Подтвердите удаление записей", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьЗаписиПоОтбору(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбУдаленииВсехЗаписей", ЭтотОбъект);
	ПоказатьВопрос(ОписаниеОповещения, "Подтвердите удаление записей", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗапись(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеЗаписи = ПолучитьДанныеСтрокиСписка(ТекущиеДанные);
	
	ОткрытьФормуВводаЗаписи("Изменить", Новый Структура("ДанныеЗаписи", ДанныеЗаписи));	
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗначенияВыделенные(Команда)
			
	ВыделенныеСтроки = Элементы.Список.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуВводаЗаписи("УстановитьЗначенияВыделенные");	
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗначенияПоОтбору(Команда)
	
	ОткрытьФормуВводаЗаписи("УстановитьЗначенияПоОтбору");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьСписокРегистров()

	ОписаниеРегистров.Очистить();
	Элементы.ПолноеИмя.СписокВыбора.Очистить();
 	
	ТипыРегистров = ТипыРегистров();

	Для Каждого КлючЗначение Из ТипыРегистров Цикл
		Для Каждого Регистр Из Метаданные[КлючЗначение.Ключ] Цикл
			ОписаниеСтруктура = Новый Структура;
			ОписаниеСтруктура.Вставить("Тип", КлючЗначение.Значение);
			ОписаниеСтруктура.Вставить("Синоним", Регистр.Синоним);
			ОписаниеСтруктура.Вставить("Имя", Регистр.Имя);
			ОписаниеСтруктура.Вставить("ПолноеИмя", ОписаниеСтруктура.Тип + "." + ОписаниеСтруктура.Имя);
			ОписаниеСтруктура.Вставить("Имя", Регистр.Имя);

			Если КлючЗначение.Значение = ТипыРегистров.РегистрыСведений
				И Строка(Регистр.РежимЗаписи) = "Независимый" Тогда
				ОписаниеСтруктура.Вставить("ПодчинениеРегистратору", Ложь);	
			Иначе
				ОписаниеСтруктура.Вставить("ПодчинениеРегистратору", Истина);
			КонецЕсли;
			
			Если КлючЗначение.Значение = ТипыРегистров.РегистрыБухгалтерии Тогда
				ОписаниеСтруктура.Вставить("Корреспонденция", Регистр.Корреспонденция);	
				ОписаниеСтруктура.Вставить("МаксКоличествоСубконто", Регистр.ПланСчетов.МаксКоличествоСубконто);
			КонецЕсли;
						
			ОписаниеРегистров.Добавить(ОписаниеСтруктура, ОписаниеСтруктура.ПолноеИмя);
			
			Элементы.ПолноеИмя.СписокВыбора.Добавить(ОписаниеСтруктура.ПолноеИмя, 
				ОписаниеСтруктура.Синоним,,
				КартинкаПоТипуРегистра(ОписаниеСтруктура.Тип));
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстЗапроса()
	
	Если ОписаниеРегистра = Неопределено Тогда
		Список.ТекстЗапроса = "";
		Возврат;
	КонецЕсли;
	
	ИмяТаблицы = "";
	Если ОписаниеРегистра.Тип = ТипыРегистров().РегистрыСведений Тогда
		ИмяТаблицы = "РегистрСведений.%Имя%";	
	ИначеЕсли ОписаниеРегистра.Тип = ТипыРегистров().РегистрыНакопления Тогда
		ИмяТаблицы = "РегистрНакопления.%Имя%";
	ИначеЕсли ОписаниеРегистра.Тип = ТипыРегистров().РегистрыБухгалтерии Тогда
		ИмяТаблицы = "РегистрБухгалтерии.%Имя%.ДвиженияССубконто";
	КонецЕсли;
	ИмяТаблицы = СтрЗаменить(ИмяТаблицы, "%Имя%", ОписаниеРегистра.Имя);


	ТекстЗапроса = "";
	Если ЗначениеЗаполнено(ИмяТаблицы) Тогда
		
		Список.ТекстЗапроса = "ВЫБРАТЬ * ИЗ " + ИмяТаблицы;
		
		Поля = ПолучитьПоля();
		
		Если Поля.Количество() > 0 Тогда
			
			ТекстЗапроса = "ВЫБРАТЬ ";
			
			ЭтоПервоеПоле = Истина;
			Для Каждого Поле Из Поля Цикл
				
				Если Не ЭтоПервоеПоле Тогда
					ТекстЗапроса = ТекстЗапроса + "," + Символы.ПС;	
				КонецЕсли;
				
				Если ЗначениеЗаполнено(ИмяРегистратора)
					И Поле.Имя = "Регистратор" Тогда
					ТекстЗапроса = ТекстЗапроса + "ВЫРАЗИТЬ(Таблица.Регистратор КАК Документ." + ИмяРегистратора + ") КАК Регистратор";
				Иначе
					ТекстЗапроса = ТекстЗапроса + "Таблица." + Поле.Имя;
				КонецЕсли;
				
				ЭтоПервоеПоле = Ложь;
			КонецЦикла;
			
			ТекстЗапроса = ТекстЗапроса + "
			|ИЗ " + ИмяТаблицы + " КАК Таблица";	
			
			Если ЗначениеЗаполнено(ИмяРегистратора) Тогда
				ТекстЗапроса = ТекстЗапроса + "
				|ГДЕ Таблица.Регистратор ССЫЛКА Документ." + ИмяРегистратора;		
			КонецЕсли;
			
		Иначе
			
			ТекстЗапроса = "ВЫБРАТЬ 1 КАК Недоступно";
			
		КонецЕсли;

	КонецЕсли;
		
	Список.ТекстЗапроса = ТекстЗапроса;	
		
КонецПроцедуры

&НаСервере
Функция ТипыРегистров()
	
	Типы = Новый Структура;
	Типы.Вставить("РегистрыСведений", "РегистрыСведений");
	Типы.Вставить("РегистрыНакопления", "РегистрыНакопления");
	Типы.Вставить("РегистрыБухгалтерии", "РегистрыБухгалтерии");
	Возврат Типы;
	
КонецФункции

&НаСервере
Функция ТипыРеквизитов()
	
	Массив = Новый Массив;
	Массив.Добавить("СтандартныеРеквизиты");
	Массив.Добавить("Измерения");
	Массив.Добавить("Ресурсы");
	Массив.Добавить("Реквизиты");
	Возврат Массив;
	
КонецФункции

&НаСервере
Функция ПолучитьМенеджерРегистра(ОписаниеРегистра)
	
	Если ОписаниеРегистра.Тип = "РегистрыСведений" Тогда
		Возврат РегистрыСведений[ОписаниеРегистра.Имя];
	ИначеЕсли ОписаниеРегистра.Тип = "РегистрыНакопления" Тогда
		Возврат РегистрыНакопления[ОписаниеРегистра.Имя];
	ИначеЕсли ОписаниеРегистра.Тип = "РегистрыБухгалтерии" Тогда
		Возврат РегистрыБухгалтерии[ОписаниеРегистра.Имя];
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция КартинкаПоТипуРегистра(ТипРегистра)
	
	Возврат КартинкиРегистров.НайтиПоЗначению(ТипРегистра).Картинка;
	
КонецФункции

&НаСервере
Функция ПолучитьОписаниеРегистра(ПолноеИмя)
	
	Для Каждого КлючЗначение Из ОписаниеРегистров Цикл
		Если КлючЗначение.Представление = ПолноеИмя Тогда
			ОписаниеСтруктура = КлючЗначение.Значение; 
			
			Если Не ОписаниеСтруктура.Свойство("Реквизиты") Тогда
				ИнициализироватьРеквизитыРегистра(ОписаниеСтруктура);
				КлючЗначение.Значение = ОписаниеСтруктура;
			КонецЕсли;
		
			Возврат ОписаниеСтруктура;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции

&НаСервере
Процедура ИнициализироватьРеквизитыРегистра(ОписаниеСтруктура)
	
	ТипыРеквизитов = ТипыРеквизитов();
	
	РегистрМетаданные = Метаданные[ОписаниеСтруктура.Тип][ОписаниеСтруктура.Имя];
	
	ПорядокРеквизита = 0;		
	РеквизитыРегистра = Новый Массив;			
	Для Каждого ТипРеквизита Из ТипыРеквизитов Цикл
		Для Каждого Реквизит Из РегистрМетаданные[ТипРеквизита] Цикл
			ПорядокРеквизита = ПорядокРеквизита + 1;
			ОписаниеРеквизита = Новый Структура;
			ОписаниеРеквизита.Вставить("Имя", Реквизит.Имя);
			ОписаниеРеквизита.Вставить("Порядок", ?(ТипРеквизита = "СтандартныеРеквизиты" И Найти(Реквизит.Имя, "Субконто"), 50, ПорядокРеквизита));
			ОписаниеРеквизита.Вставить("Тип", ТипРеквизита);
			ОписаниеРеквизита.Вставить("ТипЗначения", Реквизит.Тип);
			РеквизитыРегистра.Добавить(ОписаниеРеквизита);	
		КонецЦикла;			
		ПорядокРеквизита = ПорядокРеквизита + 50;
	КонецЦикла;				
	
	Если ОписаниеСтруктура.Тип = ТипыРегистров().РегистрыБухгалтерии Тогда
		ОписаниеРеквизита = Новый Структура;
		ОписаниеРеквизита.Вставить("Имя", "Счет");
		ОписаниеРеквизита.Вставить("Порядок", 50);
		ОписаниеРеквизита.Вставить("Тип", "СтандартныеРеквизиты");
		ОписаниеРеквизита.Вставить("ТипЗначения", Новый ОписаниеТипов("ПланСчетовСсылка." + РегистрМетаданные.ПланСчетов.Имя));
		РеквизитыРегистра.Добавить(ОписаниеРеквизита);					
	КонецЕсли;
	
	ОписаниеСтруктура.Вставить("Реквизиты", РеквизитыРегистра);
		
КонецПроцедуры

&НаСервере
Процедура СоздатьКолонки()
	
	Колич = Элементы.Список.ПодчиненныеЭлементы.Количество();
	Для к = 1 по Колич Цикл
		Элемент = Элементы.Список.ПодчиненныеЭлементы[Колич - к];
		Элементы.Удалить(Элемент);	
	КонецЦикла;
	
	Поля = ПолучитьПоля();
	
	Для Каждого ОписаниеПоля Из Поля Цикл		
		НовыйЭлемент = Элементы.Добавить("Список" + ОписаниеПоля.Имя, Тип("ПолеФормы"), Элементы.Список);
		НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
		НовыйЭлемент.ПутьКДанным = "Список." + ОписаниеПоля.Имя;
		НовыйЭлемент.Заголовок = ОписаниеПоля.Заголовок;
	КонецЦикла;
	         
КонецПроцедуры

&НаСервере
Функция ПолучитьПоля()
	
	СписокПолей = Новый СписокЗначений;
	
	Для Каждого ПолеКомпановки Из Список.КомпоновщикНастроек.Настройки.ДоступныеПоляВыбора.Элементы Цикл
		Если ПолеКомпановки.Папка Тогда
			Продолжить;	
		КонецЕсли;
		
		Если ПолеКомпановки.ТипЗначения.СодержитТип(Тип("ХранилищеЗначения")) Тогда
			Продолжить;
		КонецЕсли;
		
		ИмяПоля = Строка(ПолеКомпановки.Поле);
		
		ОписаниеПоля = Новый Структура;
		ОписаниеПоля.Вставить("Имя", ИмяПоля);
		ОписаниеПоля.Вставить("Заголовок", ПолеКомпановки.Заголовок);
		ОписаниеПоля.Вставить("ТипЗначения", ПолеКомпановки.ТипЗначения);
		
		
		ИмяПоляБезСуф = ИмяПоля;
		Если Найти(ИмяПоляБезСуф, "Дт")
			Или Найти(ИмяПоляБезСуф, "Кт") Тогда
			Индекс = Макс(Найти(ИмяПоляБезСуф, "Дт"), Найти(ИмяПоляБезСуф, "Кт")); 
			ИмяПоляБезСуф = Сред(ИмяПоляБезСуф, 1, Индекс - 1) + Сред(ИмяПоляБезСуф, Индекс + 2); 	
		КонецЕсли;
		
		Порядок = 0;
		Для Каждого Реквизит Из ОписаниеРегистра.Реквизиты Цикл			
			Если Реквизит.Имя = ИмяПоляБезСуф
				Или Реквизит.Имя = ИмяПоля Тогда
				Порядок = Реквизит.Порядок;	
			КонецЕсли;
		КонецЦикла;
		
		Если Порядок = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		СписокПолей.Добавить(ОписаниеПоля, Формат(Порядок, "ЧЦ=3; ЧВН=") + ИмяПоля);
			
	КонецЦикла;
	
	СписокПолей.СортироватьПоПредставлению();
	
	Поля = Новый Массив;
	Для Каждого Строка Из СписокПолей Цикл
		Поля.Добавить(Строка.Значение);	
	КонецЦикла;
	
	Возврат Поля;
	
КонецФункции


&НаКлиенте
Процедура ОткрытьФормуВводаЗаписи(Действие, ДополнительныеПараметры = Неопределено)
	
	ПараметрыФормы = Новый Структура;
	
	Если ДополнительныеПараметры = Неопределено Тогда
		ДополнительныеПараметры = Новый Структура;
	КонецЕсли;
	
	ДополнительныеПараметры.Вставить("Действие", Действие);
	ДополнительныеПараметры.Вставить("ВыделенныеСтроки", ПолучитьВыделенныеСтроки());
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриЗакрытииФормыВводаЗаписи", ЭтотОбъект, ДополнительныеПараметры);
	
	ОтображатьФлажок = Ложь;
	ДанныеЗаписи 	 = Неопределено;
	Если Действие = "Добавить" Тогда
		мЗаголовок = "Новая запись";	
	ИначеЕсли Действие = "Скопировать" Тогда
		мЗаголовок 	 = "Копирование записи";
		ДанныеЗаписи = ДополнительныеПараметры.ДанныеЗаписи;
	ИначеЕсли Действие = "Изменить" Тогда
		мЗаголовок 	 = "Изменение записи";
		ДанныеЗаписи = ДополнительныеПараметры.ДанныеЗаписи;
	ИначеЕсли Действие = "УстановитьЗначенияВыделенные" 
		Или Действие = "УстановитьЗначенияПоОтбору" Тогда
		мЗаголовок 	     = "Замена значений";
		ОтображатьФлажок = Истина;
	КонецЕсли;
	 
	мИмяФормы = СтрЗаменить(ИмяФормы, ".ФормаОбработки", ".ФормаЗаписи");
	
	ПараметрыФормы.Вставить("Поля",   ПолучитьПоля());
	ПараметрыФормы.Вставить("Заголовок", мЗаголовок);
	ПараметрыФормы.Вставить("ОтображатьФлажок", ОтображатьФлажок);
	ПараметрыФормы.Вставить("ДанныеЗаписи", ДанныеЗаписи);
	
	ОткрытьФорму(мИмяФормы, ПараметрыФормы,,,,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытииФормыВводаЗаписи(ДанныеЗаписи, ДополнительныеПараметры) Экспорт
	
	Если ДанныеЗаписи = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПриЗакрытииФормыВводаЗаписиНаСервере(ДанныеЗаписи, ДополнительныеПараметры);
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииФормыВводаЗаписиНаСервере(ДанныеЗаписи, ДополнительныеПараметры)
	
	Если ДополнительныеПараметры.Действие = "Добавить"
		Или ДополнительныеПараметры.Действие = "Скопировать" Тогда
		
		Если ВыполнятьВТранзакции Тогда
			НачатьТранзакцию();
		КонецЕсли;
		
		ДобавитьЗаписьНаСервере(ДанныеЗаписи);	
		
		Если ВыполнятьВТранзакции Тогда
			ЗафиксироватьТранзакцию();
		КонецЕсли;
		
	ИначеЕсли ДополнительныеПараметры.Действие = "Изменить" Тогда
		
		Если ВыполнятьВТранзакции Тогда
			НачатьТранзакцию();
		КонецЕсли;

		ИзменитьЗаписьНаСервере(ДанныеЗаписи, ДополнительныеПараметры.ДанныеЗаписи);	
		
		Если ВыполнятьВТранзакции Тогда
			ЗафиксироватьТранзакцию();
		КонецЕсли;
		
	ИначеЕсли ДополнительныеПараметры.Действие = "УстановитьЗначенияВыделенные" Тогда
		
		УстановитьЗначенияСтрокНаСервере(ДополнительныеПараметры.ВыделенныеСтроки, ДанныеЗаписи);
					
	ИначеЕсли ДополнительныеПараметры.Действие = "УстановитьЗначенияПоОтбору" Тогда
		
		УстановитьЗначенияПоОтборуНаСервере(ДанныеЗаписи);
		
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ДобавитьЗаписьНаСервере(ДанныеЗаписи) 
	
	Менеджер = ПолучитьМенеджерРегистра(ОписаниеРегистра);
	
	Если ОписаниеРегистра.ПодчинениеРегистратору Тогда
		Если Не ЗначениеЗаполнено(ДанныеЗаписи.Регистратор) Тогда
			ВызватьИсключение "Не заполнен регистратор"; 
		КонецЕсли;
		
		НаборЗаписей = Менеджер.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Установить(ДанныеЗаписи.Регистратор);
		НаборЗаписей.Прочитать();
		
		Запись = НаборЗаписей.Добавить();
	
		ЗаполнитьЗаписьДанными(Запись, ДанныеЗаписи, ОписаниеРегистра);
		
		Если ДанныеЗаписи.НомерСтроки > 0
			И Запись.НомерСтроки <> ДанныеЗаписи.НомерСтроки Тогда
			Попытка
				НаборЗаписей.Сдвинуть(Запись, ДанныеЗаписи.НомерСтроки - ?(Запись.НомерСтроки = 0, НаборЗаписей.Количество(), Запись.НомерСтроки));
			Исключение
				ВызватьИсключение "Не удалось установить номер строки";	
			КонецПопытки;
		КонецЕсли;                                                                                                                          
		
		НаборЗаписей.ОбменДанными.Загрузка = ОбменДаннымиЗагрузка;
		НаборЗаписей.Записать();
	Иначе
		МенеджерЗаписи = Менеджер.СоздатьМенеджерЗаписи();	
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ДанныеЗаписи);
		МенеджерЗаписи.Записать();           
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьЗаписьНаСервере(ДанныеЗаписи, ИзменяемаяЗапись) 
		
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(ИзменяемаяЗапись);
	УстановитьЗначенияСтрокНаСервере(МассивСтрок, ДанныеЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначенияПоОтборуНаСервере(НовыеЗначения)
	
	КоллекцияСтрок = ПолучитьОтобранныеЗаписи();
	УстановитьЗначенияСтрокНаСервере(КоллекцияСтрок, НовыеЗначения);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначенияСтрокНаСервере(КоллекцияСтрок, НовыеЗначения)
	
	Если ВыполнятьВТранзакции Тогда
		НачатьТранзакцию();
	КонецЕсли;
	
	Менеджер = ПолучитьМенеджерРегистра(ОписаниеРегистра);
	
	СтруктураЗаписи = ПолучитьПустуюСтруктуруПолей();
	
	Если ОписаниеРегистра.ПодчинениеРегистратору Тогда
		
		ЗаписиРегистраторов = Новый Соответствие;
		Для Каждого ДанныеЗаписи Из КоллекцияСтрок Цикл
			МассивЗаписей = ЗаписиРегистраторов.Получить(ДанныеЗаписи.Регистратор);
			Если МассивЗаписей = Неопределено Тогда
				МассивЗаписей = Новый Массив;
				МассивЗаписей.Добавить(ДанныеЗаписи);
				ЗаписиРегистраторов.Вставить(ДанныеЗаписи.Регистратор, МассивЗаписей);	
			Иначе
				МассивЗаписей.Добавить(ДанныеЗаписи);
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого КлючЗапись Из ЗаписиРегистраторов Цикл
			НаборЗаписей = Менеджер.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(КлючЗапись.Ключ);
			НаборЗаписей.Прочитать();
						
			Для Каждого Строка Из КлючЗапись.Значение Цикл
				Запись = НаборЗаписей[Строка.НомерСтроки - 1];
				//@skip-check query-in-loop
				ЗаполнитьСтруктуруЗаписьюРегистра(СтруктураЗаписи, Запись, ОписаниеРегистра);
				ЗаполнитьЗначенияСвойств(СтруктураЗаписи, НовыеЗначения);				
				ЗаполнитьЗаписьДанными(Запись, СтруктураЗаписи, ОписаниеРегистра);
			КонецЦикла;
			
			НаборЗаписей.ОбменДанными.Загрузка = ОбменДаннымиЗагрузка;
			НаборЗаписей.Записать();
		КонецЦикла;
	Иначе
		Для Каждого ДанныеЗаписи Из КоллекцияСтрок Цикл
			МенеджерЗаписи = Менеджер.СоздатьМенеджерЗаписи();	
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ДанныеЗаписи);
			МенеджерЗаписи.Прочитать();  
			Если МенеджерЗаписи.Выбран() Тогда
				ЗаполнитьЗначенияСвойств(СтруктураЗаписи, МенеджерЗаписи);
				ЗаполнитьЗначенияСвойств(СтруктураЗаписи, НовыеЗначения);				
				ЗаполнитьЗаписьДанными(МенеджерЗаписи, СтруктураЗаписи, ОписаниеРегистра);	
				МенеджерЗаписи.Записать();
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;	
	
	Если ВыполнятьВТранзакции Тогда
		ЗафиксироватьТранзакцию();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УдалитьЗаписиНаСервере(КоллекцияСтрок)
	
	Если ВыполнятьВТранзакции Тогда
		НачатьТранзакцию();
	КонецЕсли;
	
	Менеджер = ПолучитьМенеджерРегистра(ОписаниеРегистра);
	
	Если ОписаниеРегистра.ПодчинениеРегистратору Тогда
		
		МассивРегистраторов = Новый Массив;
		Для Каждого ДанныеЗаписи Из КоллекцияСтрок Цикл
			Если МассивРегистраторов.Найти(ДанныеЗаписи.Регистратор) = Неопределено Тогда
				МассивРегистраторов.Добавить(ДанныеЗаписи.Регистратор);	
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого Регистратор Из МассивРегистраторов Цикл
			НаборЗаписей = Менеджер.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
			НаборЗаписей.Прочитать();
			
			УдаляемыеНомераСтрок = Новый Массив;
			Для Каждого ДанныеЗаписи Из КоллекцияСтрок Цикл
				Если ДанныеЗаписи.Регистратор = Регистратор Тогда
					УдаляемыеНомераСтрок.Добавить(ДанныеЗаписи.НомерСтроки);		
				КонецЕсли;
			КонецЦикла;
			
			УдаляемыеЗаписи = Новый Массив;
			Для Каждого Запись Из НаборЗаписей Цикл
				Если Не УдаляемыеНомераСтрок.Найти(Запись.НомерСтроки) = Неопределено Тогда
					УдаляемыеЗаписи.Добавить(Запись);
				КонецЕсли;
			КонецЦикла;
			
			Если Не УдаляемыеНомераСтрок.Количество() = УдаляемыеЗаписи.Количество() Тогда
				ВызватьИсключение "Не удалось найти все данные для удаления";	
			КонецЕсли;
			
			Для Каждого Запись Из УдаляемыеЗаписи Цикл
				НаборЗаписей.Удалить(Запись);	
			КонецЦикла;
			
			НаборЗаписей.ОбменДанными.Загрузка = ОбменДаннымиЗагрузка;
			НаборЗаписей.Записать();
		КонецЦикла;
	Иначе
		УдаляемыеЗаписи = Новый Массив;
		Для Каждого ДанныеЗаписи Из КоллекцияСтрок Цикл
			МенеджерЗаписи = Менеджер.СоздатьМенеджерЗаписи();	
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ДанныеЗаписи);
			МенеджерЗаписи.Прочитать();  
			Если МенеджерЗаписи.Выбран() Тогда
				УдаляемыеЗаписи.Добавить(МенеджерЗаписи);
			КонецЕсли;
		КонецЦикла;
		
		Если Не КоллекцияСтрок.Количество() = УдаляемыеЗаписи.Количество() Тогда
			ВызватьИсключение "Не удалось найти все данные для удаления";	
		КонецЕсли;
		
		Для Каждого Запись Из УдаляемыеЗаписи Цикл
			Запись.Удалить();	
		КонецЦикла;
	КонецЕсли;	
	
	Если ВыполнятьВТранзакции Тогда
		ЗафиксироватьТранзакцию();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УдалитьЗаписиПоОтборуНаСервере()
	
	КоллекцияСтрок = ПолучитьОтобранныеЗаписи();
	УдалитьЗаписиНаСервере(КоллекцияСтрок);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбУдаленииВсехЗаписей(Ответ, ДополнительныеПараметры) Экспорт
		
	Если Не Ответ = КодВозвратаДиалога.Да Тогда
		Возврат;	
	КонецЕсли;
	
	УдалитьЗаписиПоОтборуНаСервере();	
	
	Элементы.Список.Обновить();

КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбУдаленииЗаписи(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Не Ответ = КодВозвратаДиалога.Да Тогда
		Возврат;	
	КонецЕсли;
	
	ВыделенныеСтроки = ПолучитьВыделенныеСтроки();
	
	УдалитьЗаписиНаСервере(ВыделенныеСтроки);
	
	Элементы.Список.Обновить();
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьЗаписьДанными(Запись, ДанныеЗаписи, ОписаниеРегистра)
	
	ЗаполнитьЗначенияСвойств(Запись, ДанныеЗаписи);
	
	Если ОписаниеРегистра.Тип = ТипыРегистров().РегистрыБухгалтерии Тогда			
		СуффиксыСубконто = Новый Массив;
		Если ОписаниеРегистра.Корреспонденция Тогда 
			СуффиксыСубконто.Добавить("Дт");	
			СуффиксыСубконто.Добавить("Кт");	
		Иначе
			СуффиксыСубконто.Добавить("");	
		КонецЕсли;
		
		Для НомерСубконто = 1 по ОписаниеРегистра.МаксКоличествоСубконто Цикл
			Для Каждого СуффиксСубконто Из СуффиксыСубконто Цикл
				ВидСубконто = ДанныеЗаписи["ВидСубконто" + СуффиксСубконто + НомерСубконто];
				ЗначениеСубконто = ДанныеЗаписи["Субконто" + СуффиксСубконто + НомерСубконто]; 
				Если ЗначениеЗаполнено(ВидСубконто) Тогда
					Запись["Субконто" + СуффиксСубконто][ВидСубконто] = ЗначениеСубконто;
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтруктуруЗаписьюРегистра(СтруктураЗаписи, Запись, ОписаниеРегистра)
	
	ЗаполнитьЗначенияСвойств(СтруктураЗаписи, Запись);
	
	Если ОписаниеРегистра.Тип = ТипыРегистров().РегистрыБухгалтерии Тогда			
		СуффиксыСубконто = Новый Массив;
		Если ОписаниеРегистра.Корреспонденция Тогда 
			СуффиксыСубконто.Добавить("Дт");	
			СуффиксыСубконто.Добавить("Кт");	
		Иначе
			СуффиксыСубконто.Добавить("");	
		КонецЕсли;
		
		Для Каждого СуффиксСубконто Из СуффиксыСубконто Цикл
			
			//@skip-check query-in-loop
			СписокСубконто = ПолучитьСписокСубконтоСчета(Запись["Счет" + СуффиксСубконто]);
			
			Для Каждого СтрокаСубконто Из СписокСубконто Цикл
				СтруктураЗаписи["ВидСубконто" + СуффиксСубконто + СтрокаСубконто.НомерСтроки] = СтрокаСубконто.ВидСубконто;
				СтруктураЗаписи["Субконто" + СуффиксСубконто + СтрокаСубконто.НомерСтроки] 	  = Запись["Субконто" + СуффиксСубконто][СтрокаСубконто.ВидСубконто]; 
			КонецЦикла;
			
		КонецЦикла;
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция ПолучитьОтобранныеЗаписи()
	
	СКД = Новый СхемаКомпоновкиДанных;
	
	ИсточникДанных = СКД.ИсточникиДанных.Добавить();
	ИсточникДанных.Имя = "ИсточникДанных";
	ИсточникДанных.ТипИсточникаДанных = "Local";
	
	НаборДанных = СКД.НаборыДанных.Добавить(Тип("НаборДанныхЗапросСхемыКомпоновкиДанных"));
	НаборДанных.Имя = "НаборДанных";
	НаборДанных.ИсточникДанных = "ИсточникДанных";
	НаборДанных.Запрос = Список.ТекстЗапроса;
	
	
	СписокПолей = ПолучитьПоля();	
	Для Каждого Поле Из СписокПолей Цикл	
		ПолеНабораДанных = НаборДанных.Поля.Добавить(Тип("ПолеНабораДанныхСхемыКомпоновкиДанных"));
		ПолеНабораДанных.Заголовок 		= Поле.Заголовок;
		ПолеНабораДанных.ПутьКДанным 	= Поле.Имя;
		ПолеНабораДанных.Поле 			= Поле.Имя;
		ПолеНабораДанных.ТипЗначения 	= Поле.ТипЗначения;
	КонецЦикла;

	Компоновщик = Новый КомпоновщикНастроекКомпоновкиДанных;
	Компоновщик.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СКД));
	Компоновщик.ЗагрузитьНастройки(Список.КомпоновщикНастроек.Настройки);
	
	ГруппировкаКомпоновкиДанных = Компоновщик.Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));	
	Для Каждого Поле Из СписокПолей Цикл	
		ВыбранноеПолеКомпоновкиДанных = ГруппировкаКомпоновкиДанных.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
		ВыбранноеПолеКомпоновкиДанных.Поле = Новый ПолеКомпоновкиДанных(Поле.Имя);
	КонецЦикла;

    Для Каждого ЭлементОтбора Из Список.Отбор.Элементы Цикл
        СоздатьЭлементОтбора(Компоновщик.Настройки.Отбор.Элементы,ЭлементОтбора);				
	КонецЦикла;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СКД, Компоновщик.ПолучитьНастройки(),,, Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки);
	
	ТЗ = Новый ТаблицаЗначений;
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(ТЗ);	
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
	
	Возврат ТЗ;
	
КонецФункции

&НаСервере
Процедура СоздатьЭлементОтбора(ЭлементыОтбора, ЭлементОтбораИсточник)

    НовыйЭлементОтбора = ЭлементыОтбора.Добавить(Тип(ЭлементОтбораИсточник));

    ЗаполнитьЗначенияСвойств(НовыйЭлементОтбора,ЭлементОтбораИсточник);

    Если Тип(ЭлементОтбораИсточник) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") И ЭлементОтбораИсточник.Элементы.Количество() > 0 Тогда

        Для Каждого ЭлементОтбора Из ЭлементОтбораИсточник.Элементы Цикл

            СоздатьЭлементОтбора(НовыйЭлементОтбора.Элементы,ЭлементОтбора)

        КонецЦикла;

    КонецЕсли;

КонецПроцедуры 

&НаСервере 
Функция ПолучитьПустуюСтруктуруПолей()
	
	Поля = ПолучитьПоля();
	СтруктураПолей = Новый Структура;
	
	Для Каждого ОписаниеПоля Из Поля Цикл	
		СтруктураПолей.Вставить(ОписаниеПоля.Имя, ОписаниеПоля.ТипЗначения.ПривестиЗначение());	
	КонецЦикла;
	
	Возврат СтруктураПолей;
	
КонецФункции 

&НаКлиенте
Функция ПолучитьВыделенныеСтроки()	
	МассивСтрок = Новый Массив;
	Для Каждого Идентификатор Из Элементы.Список.ВыделенныеСтроки Цикл
		ТекущиеДанные = Элементы.Список.ДанныеСтроки(Идентификатор);
		ДанныеЗаписи  = ПолучитьДанныеСтрокиСписка(ТекущиеДанные);
		МассивСтрок.Добавить(ДанныеЗаписи);
	КонецЦикла; 
	Возврат МассивСтрок;
КонецФункции

&НаСервере
Процедура УстановитьСписокВыбораРегистраторов()
	
	СписокВыбора = Элементы.ИмяРегистратора.СписокВыбора;
	СписокВыбора.Очистить();
	
	Если ОписаниеРегистра.ПодчинениеРегистратору Тогда
		Элемент = НайтиЭлементКоллекцииПоКлючу(ОписаниеРегистра.Реквизиты, "Имя", "Регистратор");
		Типы = Элемент.ТипЗначения.Типы();
		Для Каждого Тип Из Типы Цикл
			Ссылка = Новый(Тип);	
			МетаданныеОбъекта = Ссылка.Метаданные();
			СписокВыбора.Добавить(МетаданныеОбъекта.Имя, МетаданныеОбъекта.Синоним,, БиблиотекаКартинок.Документ);
		КонецЦикла;
	КонецЕсли;
	
	СписокВыбора.СортироватьПоПредставлению();
	
	Элементы.ИмяРегистратора.Доступность = СписокВыбора.Количество();
	
КонецПроцедуры

&НаСервере
Функция НайтиЭлементКоллекцииПоКлючу(КоллекцияЭлементов, Ключ, Значение)
	Для Каждого Элемент Из КоллекцияЭлементов Цикл
		Если Элемент[Ключ] = Значение Тогда
			Возврат Элемент;
		КонецЕсли;
	КонецЦикла;
КонецФункции

&НаСервере
Процедура ИнициализироватьКартинки()
	
	ТипыРегистров = ТипыРегистров();
	КартинкиРегистров.Очистить();
	КартинкиРегистров.Добавить(ТипыРегистров.РегистрыСведений,,, БиблиотекаКартинок.РегистрСведений);
	КартинкиРегистров.Добавить(ТипыРегистров.РегистрыНакопления,,, БиблиотекаКартинок.РегистрНакопления);
	КартинкиРегистров.Добавить(ТипыРегистров.РегистрыБухгалтерии,,, БиблиотекаКартинок.РегистрБухгалтерии);
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьДанныеСтрокиСписка(ТекущиеДанные)
	
	Результат = Новый Структура;
	
	Поля = ПолучитьПоля();
	
	Для Каждого ОписаниеПоля Из Поля Цикл		
		Результат.Вставить(ОписаниеПоля.Имя, ТекущиеДанные[ОписаниеПоля.Имя]);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ПолучитьСписокСубконтоСчета(Счет)
	
	Для Каждого Строка Из СубконтоСчетов Цикл
		Если Строка.Значение.Счет = Счет Тогда
			Возврат Строка.Значение.Субконто;	
		КонецЕсли;
	КонецЦикла;
				
	ИмяТаблицы = Счет.Метаданные().Имя;
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	СчетаВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	СчетаВидыСубконто.ВидСубконто КАК ВидСубконто
	|ИЗ
	|	ПланСчетов." + ИмяТаблицы + ".ВидыСубконто КАК СчетаВидыСубконто
	|ГДЕ
	|	СчетаВидыСубконто.Ссылка = &Счет");
	Запрос.УстановитьПараметр("Счет", Счет);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Субконто = Новый Массив;
	Пока Выборка.Следующий() Цикл
		Строка = Новый Структура;
		Строка.Вставить("НомерСтроки", Выборка.НомерСтроки);
		Строка.Вставить("ВидСубконто", Выборка.ВидСубконто);
		Субконто.Добавить(Строка);
	КонецЦикла;
	
	Строка = Новый Структура;
	Строка.Вставить("Счет", Счет);
	Строка.Вставить("Субконто", Субконто);
	
	СубконтоСчетов.Добавить(Строка);
	
	Возврат Субконто;
	
КонецФункции

#КонецОбласти