begin
  require "hirb"
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError
  puts "couldn't load some of the dev gems"
end

if defined? Hirb
  extend Hirb::Console
  Hirb.enable
  old_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || old_print.call(output, value)
  end
end


if defined?(PryByebug)
  Pry.commands.alias_command "_c", "continue"
  Pry.commands.alias_command "_s", "step"
  Pry.commands.alias_command "_n", "next"
  Pry.commands.alias_command "_f", "finish"
end
