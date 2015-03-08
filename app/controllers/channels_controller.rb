class ChannelsController < ApplicationController
  before_action :get_channel

  begin
    require 'piface'
  rescue Exception
    puts "Error: piface not defined!"
  end

  def on
    render text: set_channel(@channel, 1)
  end

  def off
    render text: set_channel(@channel, 0)
  end

  def status
    render text: read_channel(@channel)
  end

private

  def get_channel
    @channel = (params[:id].to_i) - 1
  end

  def input_state_to_word(state)
    return (state == 1) ? "on" : "off"
  end

  def set_channel(channel, state) # turn a channel on or off
    if defined? Piface
      Piface.write channel, state
    else
      puts "!"
      puts "! Piface not present, setting channel #{channel} to #{state}"
      puts "!"
    end

    sleep 1

    if read_channel(channel) != input_state_to_word(state)
      Piface.write(channel, 0) if defined? Piface
      return "error"
    else
      return (state == 1) ? "on" : "off"
    end
  end

  def read_channel(channel) # get "on/off" for channel number
    if defined? Piface
      state = (Piface.read(channel) == 1) ? "on" : "off"
    else
      state = (rand(2) == 1) ? "on" : "off"
      puts "!"
      puts "! Piface not present, reading channel #{channel} and returning '#{state}'"
      puts "!"
    end

    return state
  end

end
