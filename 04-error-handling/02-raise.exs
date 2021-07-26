defmodule Demo do 
  def run do 
    # raise "error!"
    try do
      raise ArgumentError, message: "Error: Invalid arguments"
     rescue
      e in ArgumentError -> IO.inspect e
    end
  end
end

defmodule DemoException do 
  defexception message: "Error from Demo1"  #default message
  def run do 
    # raise DemoException    
    raise DemoException, message: "New error message"

  end
end


# Demo.run
DemoException.run 