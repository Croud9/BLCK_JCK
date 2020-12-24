# frozen_string_literal: true

class User < Players
  def initialize_behind(args)
    @name = args[:name]
  end
end
