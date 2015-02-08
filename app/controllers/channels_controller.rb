class ChannelsController < ApplicationController
	def on
    render text: "on"
  end

  def off
    render text: "off"
  end

  def status
    render text: "off"
  end
end
