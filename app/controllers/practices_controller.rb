class PracticesController < ApplicationController
  before_action :require_login, only: %w(new edit create update destory)
  before_action :set_practice, only: %w(show edit update destroy)

  def index
    case current_user.major
    when :programmer
      @practices = Practice.for_programmer
    when :designer
      @practices = Practice.for_designer
    else
      @practices = Practice.all
    end
  end

  def show
  end

  def new
    @practice = Practice.new
  end

  def edit
  end

  def create
    @practice = Practice.new(practice_params)

    if @practice.save
      redirect_to @practice, notice: t('practice_was_successfully_created')
    else
      render 'new'
    end
  end

  def update
    if @practice.update(practice_params)
      redirect_to @practice, notice: t('practice_was_successfully_updated')
    else
      render 'edit'
    end
  end

  def destroy
    @practice.destroy
    redirect_to practices_url
  end

  private
    def practice_params
      params.require(:practice).permit(:title, :description, :aim)
    end

    def set_practice
      @practice = Practice.find(params[:id])
    end
end
