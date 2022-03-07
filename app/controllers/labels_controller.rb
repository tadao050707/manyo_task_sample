class LabelsController < ApplicationController
  before_action :set_label, only: %i[edit update destroy]

  def index
    @labels = current_user.labels
  end

  def new
    @label = current_user.labels.new
  end

  def create
    @label = current_user.labels.build(label_params)

    if @label.save
      redirect_to labels_path, notice: t('.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: t('.destroyed')
  end

  private

    def set_label
      begin
        @label = current_user.labels.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to labels_path
      end
    end

    def label_params
      params.require(:label).permit(:name)
    end
end
