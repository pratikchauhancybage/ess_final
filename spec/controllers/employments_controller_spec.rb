# spec/controllers/employments_controller_spec.rb

require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  let(:valid_attributes) do
    {
      start_date: Date.today,
      end_date: Date.tomorrow,
      employee_id: 1
    }
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { emp_id: 1 }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @employee and @employment' do
      employee = Employee.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', phone: '123-456-7890')
      employment = Employment.create(start_date: Date.today, end_date: Date.tomorrow, employee_id: employee.id)
      get :index, params: { emp_id: employee.id }
      expect(assigns(:employee)).to eq(employee)
      expect(assigns(:employment)).to eq(employment)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      employment = Employment.create(valid_attributes)
      get :show, params: { id: employment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { emp_id: 1 }
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new employment' do
      employee = Employee.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', phone: '123-456-7890')
      get :new, params: { emp_id: employee.id }
      expect(assigns(:employment)).to be_a_new(Employment)
      expect(assigns(:employment).employee_id).to eq(employee.id)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new employment' do
        expect {
          post :create, params: { employment: valid_attributes }
        }.to change(Employment, :count).by(1)
      end

      it 'redirects to employments path upon successful creation' do
        post :create, params: { employment: valid_attributes }
        expect(response).to redirect_to(employments_path(emp_id: valid_attributes[:employee_id]))
      end
    end

    context 'with invalid parameters' do
      it 're-renders the "new" template' do
        post :create, params: { employment: { invalid_attribute: 'Invalid Value' } }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      employment = Employment.create(valid_attributes)
      get :edit, params: { id: employment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'updates an employment with valid parameters' do
      employment = Employment.create(valid_attributes)
      new_attributes = { start_date: Date.yesterday }
      patch :update, params: { id: employment.id, employment: new_attributes }
      employment.reload
      expect(employment.start_date).to eq(Date.yesterday)
    end

    it 're-renders the "edit" template with invalid parameters' do
      employment = Employment.create(valid_attributes)
      patch :update, params: { id: employment.id, employment: { end_date: 'invalid-date' } }
      expect(response).to render_template('edit')
    end
  end

  # Add tests for the 'destroy' action as needed

end
