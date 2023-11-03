# spec/controllers/employees_controller_spec.rb

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      phone: '123-456-7890'
    }
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @employees with a list of employees' do
      employee = Employee.create(valid_attributes)
      get :index
      expect(assigns(:employees)).to eq([employee])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      employee = Employee.create(valid_attributes)
      get :show, params: { id: employee.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new employee' do
      get :new
      expect(assigns(:employee)).to be_a_new(Employee)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new employee' do
        expect {
          post :create, params: { employee: valid_attributes }
        }.to change(Employee, :count).by(1)
      end

      it 'redirects to a new employment path upon successful creation' do
        post :create, params: { employee: valid_attributes }
        expect(response).to redirect_to(new_employment_path(emp_id: Employee.last.id))
      end
    end

    # context 'with invalid parameters' do
    #   it 're-renders the "new" template' do
    #     post :create, params: { employee: { invalid_attribute: 'Invalid Value' } }
    #     expect(response).to render_template('new')
    #   end
    # end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      employee = Employee.create(valid_attributes)
      get :edit, params: { id: employee.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'updates an employee with valid parameters' do
      employee = Employee.create(valid_attributes)
      new_attributes = { first_name: 'Updated' }
      patch :update, params: { id: employee.id, employee: new_attributes }
      employee.reload
      expect(employee.first_name).to eq 'Updated'
    end

    # it 're-renders the "edit" template with invalid parameters' do
    #   employee = Employee.create(valid_attributes)
    #   patch :update, params: { id: employee.id, employee: { email: 'invalid-email' } }
    #   expect(response).to render_template('edit')
    # end
  end

  describe 'DELETE #destroy' do
    it 'destroys an employee' do
      employee = Employee.create(valid_attributes)
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
    end

    it 'redirects to the employees index' do
      employee = Employee.create(valid_attributes)
      delete :destroy, params: { id: employee.id }
      expect(response).to redirect_to(employees_url)
    end
  end
end
