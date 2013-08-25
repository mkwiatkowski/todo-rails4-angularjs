desc "Run karma test runner for JavaScript tests"
task :karma do
  sh "CHROME_BIN=chromium-browser karma start jstest/config.coffee"
end
