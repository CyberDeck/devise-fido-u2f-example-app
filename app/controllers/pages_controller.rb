class PagesController < ApplicationController
  include HighVoltage::StaticPage

  # Do not authenticate users. Service pages to whole internet.
  skip_before_action :authenticate_user!
end
