  
RSpec.configure do |config|
  config.order = :default
end

def run_file(file)
  eval(File.read(file), binding)
end

def get_variable_from_file(file, variable)
  file_scope = binding
  file_scope.eval(File.read(file))
  
  begin
    return file_scope.local_variable_get(variable)
  rescue NameError
    raise NameError, "local variable `#{variable}' not defined in #{file}."
  end    
end

def capture_puts
  begin
    old_stdout = $stdout
    $stdout = StringIO.new('','w')
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end