module RatingsHelper
	def model_exists params
		if params[:question_id]
			Question.find params[:question_id]
		elsif params[:answer_id]
			Answer.find params[:answer_id]
		else
			nil
		end
	end
end
