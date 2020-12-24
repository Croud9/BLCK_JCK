# frozen_string_literal: true

class Players
  attr_reader :name

  def initialize(args = {})
    initialize_behind(args)
  end

  def initialize_behind(_args)
  end
end
