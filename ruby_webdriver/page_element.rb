require "selenium-webdriver"
require "page-object"

class HomePage
	include PageObject
	page_url("http://localhost:3000")

	#define element in HOME PAGE
	h1(:home_title, :xpath => '//*[@id="page-content-wrapper"]/div/div/div/h1')
	image(:baby_pic, :alt => 'Happy baby')
	link(:sign_up_link, :href => 'babies/new')
	link(:show_all_babies_link, :href => 'babies')
	#define functions used in HOME PAGE
	
end

class SignUpPage
	include PageObject
	page_url("http://localhost:3000/babies/new")

	#define element in SIGN UP PAGE
	h1(:sign_up_title, :xpath => '/html/body/h1')
	text_field(:first_name, :id => 'baby_first_name')
	text_field(:last_name, :id => 'baby_last_name')
	checkbox(:metric, :id => 'baby_metric')
	text_field(:height, :id => 'baby_height')
	text_field(:weight, :id => 'baby_weight')
	text_field(:temperature, :id => 'baby_temperature')
	button(:create_button, :value => 'Create Baby')

	#define functions used in SIGN UP PAGE

end

class BabyListPage
	include PageObject
	page_url("http://localhost:3000/babies")

	#define element in BABY LIST PAGE
	h1(:baby_list_title, :xpath => '/html/body/h1')
	table(:baby_list_table, :xpath => '/html/body/table')
	link(:find_steve, :xpath => '//*[contains(text(), "Steve Yang")]')

	#define functoins used in BABY LIST PAGE
	# def locate_row_by_text(text)
	# 	match_row = baby_list_table_element.find{ |row| row.text.include? text}
	# 	fail "Could not locate the row with value #{text}" if match_row.nil?
	# 	match_row
	# end

	# def click_match_row(text)
	# 	match_row = locate_row_by_text(text)
	# 	match_row.link_element.click
	# end
end