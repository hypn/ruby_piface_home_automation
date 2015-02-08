class ChannelsController < ApplicationController

  begin
    require 'piface'
  rescue Exception
    puts "Error: piface not defined!"
  end

	def on
    render text: set_channel(params[:id], 1)
  end

  def off
    render text: set_channel(params[:id], 0)
  end

  def status
    render text: read_channel(params[:id])
  end

private

  def state_to_word(state)
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

    sleep 2

    if read_channel(channel) != state_to_word(state)
      Piface.write(channel, 0) if defined? Piface
      return "error"
    else
      return (state == 1) ? "on" : "off"
    end
  end

  def read_channel(channel) # get "on/off" for channel number
    if defined? Piface
      state = (Piface.read_output(channel) == 0) ? "on" : "off"
    else
      state = (rand(2) == 1) ? "on" : "off"
      puts "!"
      puts "! Piface not present, reading channel #{channel} and returning '#{state}'"
      puts "!"
    end

    return state
  end

end
