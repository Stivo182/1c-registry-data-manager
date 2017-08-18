﻿#Область ОбработчикиФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИнициализироватьСписокРегистров();	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьЗапись(Команда)
	
	ОткрытьФормуВводаЗаписи("Добавить");	
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьЗапись(Команда)
	
	ВыделенныеСтроки = Элементы.Список.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбУдаленииЗаписи", ЭтаФорма, Новый Структура("ВыделенныеСтроки", ВыделенныеСтроки));
	ПоказатьВопрос(ОписаниеОповещения, "Подтвердите удаление записей", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВсеЗаписи(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбУдаленииВсехЗаписей", ЭтаФорма);
	ПоказатьВопрос(ОписаниеОповещения, "Подтвердите удаление записей", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗапись(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуВводаЗаписи("Изменить", ТекущиеДанные);	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиЭлементовФормы

&НаКлиенте
Процедура ПолноеИмяПриИзменении(Элемент)
	
	ОписаниеРегистра = ПолучитьОписаниеРегистра(ПолноеИмя);
	УстановитьТекстЗапроса();
	СоздатьКолонки();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Список.ДанныеСтроки(ВыбраннаяСтрока);	
	ОткрытьФормуВводаЗаписи("Изменить", ТекущиеДанные);	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьСписокРегистров()

	ОписаниеРегистров.Очистить();
	Элементы.ПолноеИмя.СписокВыбора.Очистить();
	
	ТипыРегистров = ТипыРегистров();
	ТипыРеквизитов = ТипыРеквизитов();

	Для Каждого КлючЗначение Из ТипыРегистров Цикл
		Для Каждого Регистр Из Метаданные[КлючЗначение.Ключ] Цикл
			ОписаниеСтруктура = Новый Структура;
			ОписаниеСтруктура.Вставить("Тип", КлючЗначение.Значение);
			ОписаниеСтруктура.Вставить("Синоним", Регистр.Синоним);
			ОписаниеСтруктура.Вставить("Имя", Регистр.Имя);
			ОписаниеСтруктура.Вставить("ПолноеИмя", ОписаниеСтруктура.Тип + "." + ОписаниеСтруктура.Имя);
			ОписаниеСтруктура.Вставить("Имя", Регистр.Имя);

			Если КлючЗначение.Значение = ТипыРегистров().РегистрыСведений
				И Строка(Регистр.РежимЗаписи) = "Независимый" Тогда
				ОписаниеСтруктура.Вставить("ПодчинениеРегистратору", Ложь);	
			Иначе
				ОписаниеСтруктура.Вставить("ПодчинениеРегистратору", Истина);
			КонецЕсли;
			
			Если КлючЗначение.Значение = ТипыРегистров().РегистрыБухгалтерии Тогда
				ОписаниеСтруктура.Вставить("Корреспонденция", Регистр.Корреспонденция);	
				ОписаниеСтруктура.Вставить("МаксКоличествоСубконто", Регистр.ПланСчетов.МаксКоличествоСубконто);
			КонецЕсли;
			
			
			ПорядокРеквизита = 0;		
			РеквизитыРегистра = Новый Массив;			
			Для Каждого ТипРеквизита Из ТипыРеквизитов Цикл
				Для Каждого Реквизит Из Регистр[ТипРеквизита] Цикл
					ПорядокРеквизита = ПорядокРеквизита + 1;
					ОписаниеРеквизита = Новый Структура;
					ОписаниеРеквизита.Вставить("Имя", Реквизит.Имя);
					ОписаниеРеквизита.Вставить("Порядок", ?(ТипРеквизита = "СтандартныеРеквизиты" И Найти(Реквизит.Имя, "Субконто"), 50, ПорядокРеквизита));
					ОписаниеРеквизита.Вставить("Тип", ТипРеквизита);
					РеквизитыРегистра.Добавить(ОписаниеРеквизита);	
				КонецЦикла;			
				ПорядокРеквизита = ПорядокРеквизита + 50;
			КонецЦикла;				
			
			Если КлючЗначение.Значение = ТипыРегистров().РегистрыБухгалтерии Тогда
				ОписаниеРеквизита = Новый Структура;
				ОписаниеРеквизита.Вставить("Имя", "Счет");
				ОписаниеРеквизита.Вставить("Порядок", 50);
				ОписаниеРеквизита.Вставить("Тип", "СтандартныеРеквизиты");
				РеквизитыРегистра.Добавить(ОписаниеРеквизита);					
			КонецЕсли;
					
			ОписаниеСтруктура.Вставить("Реквизиты", РеквизитыРегистра);
						
			ОписаниеРегистров.Добавить(ОписаниеСтруктура, ОписаниеСтруктура.ПолноеИмя);
			Элементы.ПолноеИмя.СписокВыбора.Добавить(ОписаниеСтруктура.ПолноеИмя, ОписаниеСтруктура.Синоним,, КартинкаПоТипуРегистра(ОписаниеСтруктура.Тип));
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстЗапроса()
	
	Если ОписаниеРегистра = Неопределено Тогда
		Список.ТекстЗапроса = "";
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = "";
	Если ОписаниеРегистра.Тип = ТипыРегистров().РегистрыСведений Тогда
		ТекстЗапроса = "РегистрСведений.%Имя%";	
	ИначеЕсли ОписаниеРегистра.Тип = ТипыРегистров().РегистрыНакопления Тогда
		ТекстЗапроса = "РегистрНакопления.%Имя%";
	ИначеЕсли ОписаниеРегистра.Тип = ТипыРегистров().РегистрыБухгалтерии Тогда
		ТекстЗапроса = "РегистрБухгалтерии.%Имя%.ДвиженияССубконто";
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "%Имя%", ОписаниеРегистра.Имя);

	Если ЗначениеЗаполнено(ТекстЗапроса) Тогда
		ТекстЗапроса = "ВЫБРАТЬ * ИЗ " + ТекстЗапроса + " КАК Таблица";	
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
	
	Если ТипРегистра = ТипыРегистров().РегистрыСведений Тогда
		Возврат БиблиотекаКартинок.РегистрСведений;
	ИначеЕсли ТипРегистра = ТипыРегистров().РегистрыНакопления Тогда
		Возврат БиблиотекаКартинок.РегистрНакопления;
	ИначеЕсли ТипРегистра = ТипыРегистров().РегистрыБухгалтерии Тогда
		Возврат БиблиотекаКартинок.РегистрБухгалтерии;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ПолучитьОписаниеРегистра(ПолноеИмя)
	
	Для Каждого КлючЗначение Из ОписаниеРегистров Цикл
		Если КлючЗначение.Представление = ПолноеИмя Тогда
			Возврат КлючЗначение.Значение;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции

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
			ВызватьИсключение "Не определен порядок для поля " + ИмяПоля;
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
Процедура ОткрытьФормуВводаЗаписи(Действие, ДанныеЗаписи = Неопределено)
	
	ДополнительныеПараметры = Новый Структура;	
	ДополнительныеПараметры.Вставить("Действие", Действие);
	ДополнительныеПараметры.Вставить("ДанныеЗаписи", ДанныеЗаписи);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриЗакрытииФормыВводаЗаписи", ЭтаФорма, ДополнительныеПараметры);
	
	Если Действие = "Добавить" Тогда
		мЗаголовок = "Новая запись";	
	ИначеЕсли Действие = "Изменить" Тогда
		мЗаголовок = "Изменение записи";
	КонецЕсли;
	
	мИмяФормы = СтрЗаменить(ИмяФормы, ".ФормаОбработки", ".ФормаЗаписи");
	ОткрытьФорму(мИмяФормы, Новый Структура("Список, Поля, ДанныеЗаписи, Заголовок", Список, ПолучитьПоля(), ДанныеЗаписи, мЗаголовок),,,,, ОписаниеОповещения);
	
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
	
	Если ДополнительныеПараметры.Действие = "Добавить" Тогда
		
		ДобавитьЗаписьНаСервере(ДанныеЗаписи);	
				
	ИначеЕсли ДополнительныеПараметры.Действие = "Изменить" Тогда
		
		ИзменитьЗаписьНаСервере(ДанныеЗаписи, ДополнительныеПараметры.ДанныеЗаписи);	
				
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
		
		Если ДанныеЗаписи.НомерСтроки > 0
			И Запись.НомерСтроки <> ДанныеЗаписи.НомерСтроки Тогда
			НаборЗаписей.Сдвинуть(Запись, ДанныеЗаписи.НомерСтроки - ?(Запись.НомерСтроки = 0, НаборЗаписей.Количество(), Запись.НомерСтроки));
		КонецЕсли;                                                                                                                          
		
		НаборЗаписей.Записать();
	Иначе
		МенеджерЗаписи = Менеджер.СоздатьМенеджерЗаписи();	
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ДанныеЗаписи);
		МенеджерЗаписи.Записать();           
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьЗаписьНаСервере(ДанныеЗаписи, ИзменяемаяЗапись) 
	
	НачатьТранзакцию();
	
	УдалитьЗаписьНаСервере(ИзменяемаяЗапись);
	ДобавитьЗаписьНаСервере(ДанныеЗаписи);
	
	ЗафиксироватьТранзакцию();
	
КонецПроцедуры


&НаСервере
Процедура УдалитьЗаписьНаСервере(ДанныеЗаписи)
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(ДанныеЗаписи);
	УдалитьЗаписиНаСервере(МассивСтрок);
КонецПроцедуры

&НаСервере
Процедура УдалитьЗаписиНаСервере(КоллекцияСтрок)
	
	НачатьТранзакцию();
	
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
	
	ЗафиксироватьТранзакцию();
	
КонецПроцедуры

&НаСервере
Процедура УдалитьВсеЗаписиНаСервере()
	
	ТЗ = ПолучитьОтобранныеЗаписи();
	УдалитьЗаписиНаСервере(ТЗ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбУдаленииВсехЗаписей(Ответ, ДополнительныеПараметры) Экспорт
		
	Если Не Ответ = КодВозвратаДиалога.Да Тогда
		Возврат;	
	КонецЕсли;
	
	УдалитьВсеЗаписиНаСервере();	
	
	Элементы.Список.Обновить();

КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопросОбУдаленииЗаписи(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Не Ответ = КодВозвратаДиалога.Да Тогда
		Возврат;	
	КонецЕсли;
	
	МассивСтрок = Новый Массив;
	Для Каждого Идентификатор Из ДополнительныеПараметры.ВыделенныеСтроки Цикл
		МассивСтрок.Добавить(Элементы.Список.ДанныеСтроки(Идентификатор));
	КонецЦикла; 
	
	УдалитьЗаписиНаСервере(МассивСтрок);
	
	Элементы.Список.Обновить();
	
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

#КонецОбласти