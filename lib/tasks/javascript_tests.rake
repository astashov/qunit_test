require File.expand_path("jstest.rb", File.join(File.dirname(__FILE__), ".."))

desc "Runs all the JavaScript tests and collects the results"
JavaScriptTestTask.new(:javascript_tests, 4711) do |t|
  t.mount("/javascripts", File.join(Dir.pwd, "public", "javascripts"))
  t.mount("/stylesheets", File.join(Dir.pwd, "public", "stylesheets"))
  t.mount("/test")

  testcases        = ENV['TESTCASES']
  tests_to_run     = ENV['TESTS']    && ENV['TESTS'].split(',')
  browsers_to_test = ENV['BROWSERS'] && ENV['BROWSERS'].split(',')

  Dir["test/javascripts/*_test.html"].sort.each do |test_file|
    tests = testcases ? { :url => "/#{test_file}", :testcases => testcases } : "/#{test_file}"
    test_filename = test_file[/.*\/(.+?)\.html/, 1]
    t.run(tests) unless tests_to_run && !tests_to_run.include?(test_filename)
  end

  %w( safari firefox ie opera ).each do |browser|
    t.browser(browser.to_sym) unless browsers_to_test && !browsers_to_test.include?(browser)
  end
end