class EmploymentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_employment, only: %i[ show edit update destroy ]

  def index
    if params[:emp_id].present?
      emp_id = params[:emp_id].to_i
      @employee = Employee.find(emp_id)
      @employment = @employee.employment
    end

  end

  def show; end

  def new
    emp_id = params[:emp_id].to_i
    @employee = Employee.find(emp_id)
    @employment = Employment.new(employee_id: emp_id)
    
  end

  def edit; end

  def create
    respond_to do |format|
      @employment = Employment.new(employment_params)     
      if @employment.save
      format.html { redirect_to employments_path(emp_id: @employment.employee.id), notice: "Employment was successfully created." }
       else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:employment_form, partial: "employments/form", locals: { employment: @employment })
        end 
      end
    end
  end

  def update
    respond_to do |format|
      if @employment.update(employment_params)
      format.html { redirect_to employments_path(emp_id: @employment.employee.id), notice: "Employment was successfully updated." }
       else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:employment_form, partial: "employments/form", locals: { employment: @employment })
        end 
      end
    end
  end 

  def destroy
  end

   private
    def set_employment
      @employment = Employment.find(params[:id])
    end

    def employment_params
      params.require(:employment).permit(:start_date, :end_date, :employee_id)
    end

end
