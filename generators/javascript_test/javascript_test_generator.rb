require 'pp'
class JavascriptTestGenerator < Rails::Generator::Base
  

  attr_reader :js_name
  
  def initialize(*runtime_args)
    @js_name = runtime_args.first.first.to_s
    @collision = (runtime_args[1][:collision] == :force) ? :force : :skip
    super(*runtime_args)
  end

  def manifest
    record do |m|
      pp @collision
      m.file 'testrunner.js', File.join("public", "javascripts", "testrunner.js"), :collision => @collision
      m.file 'testsuite.css', File.join("public", "stylesheets", "testsuite.css"), :collision => @collision
      m.template 'lib.erb', File.join("public", "javascripts", "#{@js_name}.js"), :collision => @collision
      m.directory File.join("test", "javascripts")
      m.template 'test.erb', File.join("test", "javascripts", "#{@js_name}_test.html"), :collision => @collision
    end
  end

end
