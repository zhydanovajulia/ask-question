class QuestionsController < ApplicationController
  before_filter :authenticate_user!
end
