class FrontpagesController < ApplicationController
  before_action :authenticate_user!, only: [:signed_sample]

  # GET /sample
  def sample
  end

  # GET /signed-sample
  def signed_sample
  end
end
