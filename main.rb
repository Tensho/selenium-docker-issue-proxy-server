require 'selenium-webdriver'

chrome_options = {
  args: ["--ignore-certificate-errors"] # Allows to not care about mitmproxy root CA cert
}

# proxy = Selenium::WebDriver::Proxy.new(http: "#{ENV['HTTP_PROXY_HOST']}:#{ENV['HTTP_PROXY_PORT']}")

driver = Selenium::WebDriver.for(
  :remote, url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
  capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => chrome_options,
  # proxy: proxy
  )
)

driver.navigate.to "https://github.com"

puts driver.current_url

driver.find_element(id: 'start-of-content')
