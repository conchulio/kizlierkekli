require 'test_helper'

class ApartmentsControllerTest < ActionController::TestCase
  setup do
    @apartment = apartments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apartments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apartment" do
    assert_difference('Apartment.count') do
      post :create, apartment: { address: @apartment.address, cost: @apartment.cost, created_at: @apartment.created_at, currency: @apartment.currency, deposit: @apartment.deposit, description: @apartment.description, females: @apartment.females, from: @apartment.from, lat: @apartment.lat, lng: @apartment.lng, male_or_female: @apartment.male_or_female, males: @apartment.males, phone: @apartment.phone, title: @apartment.title, until: @apartment.until, user_id: @apartment.user_id }
    end

    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "should show apartment" do
    get :show, id: @apartment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @apartment
    assert_response :success
  end

  test "should update apartment" do
    patch :update, id: @apartment, apartment: { address: @apartment.address, cost: @apartment.cost, created_at: @apartment.created_at, currency: @apartment.currency, deposit: @apartment.deposit, description: @apartment.description, females: @apartment.females, from: @apartment.from, lat: @apartment.lat, lng: @apartment.lng, male_or_female: @apartment.male_or_female, males: @apartment.males, phone: @apartment.phone, title: @apartment.title, until: @apartment.until, user_id: @apartment.user_id }
    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "should destroy apartment" do
    assert_difference('Apartment.count', -1) do
      delete :destroy, id: @apartment
    end

    assert_redirected_to apartments_path
  end
end
