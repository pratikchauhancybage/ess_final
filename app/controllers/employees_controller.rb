class EmployeesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_employee, only: %i[ show edit update destroy ]


  def index
    @employees = Employee.all
  end

  def show 
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        @employment = Employment.new(employee_id: @employee.id)
        format.turbo_stream
        format.html { redirect_to new_employment_path(emp_id: @employee.id) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:employee_form, partial: "employees/form", locals: { employee: @employee })
        end 
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
      format.html { redirect_to action: :index, notice: "Employee was successfully updated." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:employees, partial: "employees/employee", locals: { employee: @employee })
        end 
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:employee_form, partial: "employees/form", locals: { employee: @employee })
        end 
      end
    end
  end

  def destroy
    @employee.destroy
    flash.now[:notice] = "Employee was successfully destroyed."
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@employee)
      end
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
    end
    
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :nick_name, :email, :phone)
    end
end
