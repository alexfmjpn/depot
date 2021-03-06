# исходный код класса Product модели
class Product < ActiveRecord::Base
#  проверка наличия какого-нибудь содержимого во всех текстовых полях перед записью строки в базу данных
	validates :title, :description, :image_url, presence: true 
	# метод validates () - проверка наличия названия, описания, гиперссылки изображения условие - presence, значение - true

	# проверка того, что цена имеет допустимое, положительное числовое значение . 
	# испсользуем методом с именем numericality . Мы также 
	# передадим несколько многословному методу greater_than_or_equal_to (больше чем или равно) значение 0 .01:
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	# Почему проверка велась относительно значения 0 .01, а не нуля? Потому что
	# можно ведь ввести в это поле и такое значение, как 0 .001 . Поскольку база данных
	# сохраняет только две цифры после десятичной точки, в ней окажется нуль, даже
	# если поле пройдет проверку на ненулевое значение . Проверка того, что число, по
	# крайней мере, равно 0 .01, гарантирует, что будет сохранено только допустимое значение .

	# нужно убедиться в том, 	# что у каждого товара есть свое уникальное название . Эта задача решается с по-
	# мощью еще одной строки кода в модели Product . Проведем простую проверку,
	# гарантирующую, что никакая другая строка в таблице products не имеет названия,
	# указанного в той строке, которую мы собираемся сохранить:
	validates :title, uniqueness: true # проверка поля title на условие uniqueness значение - true

	# нужно проверить приемлемость введенного URL-адреса изображения . 
	# Для этого воспользуемся методом format, который определяет 
	# соответствие значения поля регулярному выражению .
	# просто проверим, что URL-адрес заканчивается одним из расширений: .gif, .jpg или .png .
	
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i, message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
	}
	
	# %r{\.(gif|jpg|png)\Z}i Оборачивающие слэши - разделители, содержат регуряное выражение - \.(gif|jpg|png)\ собственно регулярка, 
	# Z - признак конца строки (https://habrahabr.ru/post/156395/), i -в любом регистре
	#  во избежание получения сообщений об ошибках при пустом поле используется параметр allow_blank
end
# после редактирования и сохранения файла  product.rb перезапускать приложение для про-
# верки изменений не пришлось — перезагрузка страницы, заставившая ранее Rails
# заметить изменения в схеме данных, всегда приводит к тому, что используется
# самая последняя версия кода 