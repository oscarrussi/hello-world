require_relative '../../services/save_csv'

module Api
  class CategoriesController < ApiController
    before_action :authenticate_user

    def index
      render json: Category.all
    end

    def update_many
      uploaded_io = params[:file]
      if File.extname(uploaded_io) == '.csv'
        SaveCsv.call(uploaded_io)
        LoadCategoriesJob.perform_later
        head :ok
      else
        render json: { "error": 'Only valid format is csv' }, status: :unprocessable_entity
      end
    end
  end
end
