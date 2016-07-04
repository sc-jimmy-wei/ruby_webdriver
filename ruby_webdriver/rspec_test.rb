require "selenium-webdriver"
require "./page_element.rb"
require "page-object"

describe "Fitness Tracker" do

	before(:all) do
		@driver = Selenium::WebDriver.for :firefox
		@driver.manage.window.maximize
		# @driver.navigate.to ("localhost:3000")
		@wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	end
	
	after(:all) do
		@driver.quit
	end

	it "check if Home Page can load" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.home_title}
		expect(home_page.home_title == "Welcome to Fitness Tracker").to be true
	end

	it "check if baby picture is displayed in home page" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.baby_pic_element}
		expect(home_page.baby_pic_element.visible?).to be true
	end

	it "check if Sign Up Page can load" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.sign_up_link_element}
		home_page.sign_up_link
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.sign_up_title}
		expect(sign_up_page.sign_up_title == "Sign up").to be true
	end

	it "check sign up flow for new baby" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.sign_up_link_element}
		home_page.sign_up_link
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.first_name_element}
		sign_up_page.first_name = "Steve"
		sign_up_page.last_name = "Yang"
		sign_up_page.check_metric
		sign_up_page.height = 75
		sign_up_page.weight = 6
		sign_up_page.temperature = 27
		sign_up_page.create_button
		@wait.until {home_page.show_all_babies_link_element}
		home_page.show_all_babies_link
		baby_list_page = BabyListPage.new(@driver)
		@wait.until {baby_list_page.baby_list_table_element}
		expect(baby_list_page.find_steve_element.visible?).to be true
	end

end