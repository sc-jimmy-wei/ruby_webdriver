require "selenium-webdriver"
require "page-object"

class HomePage
	include PageObject
	page_url("http://localhost:3000")

	#define element in HOME PAGE
	h1(:home_title, :xpath => '//*[@id="page-content-wrapper"]/div/div/div/h1')
	image(:baby_pic, :alt => 'Happy baby')
	link(:sign_up_link, :href => 'babies/new')

	#define functions used in HOME PAGE
	
end

class SignUpPage
	include PageObject
	page_url("http://localhost:3000/babies/new")

	#define element in SIGN UP PAGE
	h1(:sign_up_title, :xpath => '/html/body/h1')

	#define functions used in SIGN UP PAGE

end