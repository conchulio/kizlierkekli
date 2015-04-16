class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]

  # GET /apartments
  # GET /apartments.json
  def index
    @apartments = Apartment.all
  end

  def index_within_boundaries 
    @apartments = Apartment.where('
        latitude >= :lat1 AND latitude <= :lat2 AND
        longitude >= :lng1 AND longitude <= :lng2', 
        {lat1: params[:lat1], lat2: params[:lat2], lng1: params[:lng1], lng2: params[:lng2]}
      )

    # byebug
    if !params[:text].blank?
      @apartments = @apartments.search_everything(params[:text])
    else
      @apartments = @apartments.order(created_at: :desc)
    end

    # Only show the 100 most relevant entries
    render json: @apartments.limit(100), only: [:id, :latitude, :longitude]
  end

  # GET /apartments/1()
  # GET /apartments/1.json
  def show
    @apartment = Apartment.find(params[:id])
    @favorite = Favorite.new
    @is_favorite = Favorite.exists?(user_id: current_user, apartment_id: @apartment)
  end

  def infowindow
    @apartment = Apartment.find(params[:id])
    render layout: false
  end

  # GET /apartments/new
  def new
    @apartment = Apartment.new
  end

  # GET /apartments/1/edit
  def edit
  end

  # POST /apartments
  # POST /apartments.json
  def create
    modified_params = apartment_params
    modified_params[:user] = current_user
    @apartment = Apartment.new(modified_params)

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:title, :description, :cost, :deposit, :currency, :user_id, :males, :females, :address, :latitude, :longitude, :from, :until, :male_or_female)
    end
end
