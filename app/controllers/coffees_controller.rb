class CoffeesController < ApplicationController
  before_action :set_coffee, only: %i[show edit update destroy coming_soon]
  before_action :set_roaster, only: %i[index new create update]
  before_action :authorize_admin, only: %i[edit update destroy]

  # GET /coffees or /coffees.json
  def index
    @pagy, @coffees =
      if params[:query].present?
        pagy(search, items: 10)
      elsif @roaster.present?
        @roaster.coffees
      else
        pagy(Coffee.all.order('brews_count DESC, name ASC'), items: 10)
      end
  end

  # GET /coffees/1 or /coffees/1.json
  def show
    # variable for default tab
    @recent_brews = @coffee.brews.visible.includes(:user).sort_by(&:created_at).last(10).reverse
  end

  def coming_soon
    respond_to do |format|
      format.html { render partial: 'coffees/coming_soon_tab', locals: { coffee: @coffee } }
    end
  end

  # GET /coffees/new
  def new
    @coffee = Coffee.new
  end

  # GET /coffees/1/edit
  def edit; end

  # POST /coffees or /coffees.json
  def create
    @coffee = @roaster.coffees.new(coffee_params)

    respond_to do |format|
      if @coffee.save
        format.html { redirect_to coffee_url(@coffee), notice: 'Coffee was successfully created.' }
        format.json { render :show, status: :created, location: @coffee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coffee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coffees/1 or /coffees/1.json
  def update
    respond_to do |format|
      if @coffee.update(coffee_params)
        format.html { redirect_to coffee_url(@coffee), notice: 'Coffee was successfully updated.' }
        format.json { render :show, status: :ok, location: @coffee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coffee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coffees/1 or /coffees/1.json
  def destroy
    @coffee.destroy

    respond_to do |format|
      format.html { redirect_to coffees_url, notice: 'Coffee was successfully destroyed.' }
      format.json { head :no_content }
      #format.turbo_stream
    end
  end

  private

  def search
    Coffee.where('name ILIKE :search OR tasting_notes ILIKE :search OR country ILIKE :search OR process ILIKE :search',
                 search: "%#{params[:query].downcase}%")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_coffee
    @coffee = Coffee.find(params[:id])
  end

  def set_roaster
    return unless params[:roaster_id]

    @roaster = Roaster.find(params[:roaster_id])
  end

  # Only allow a list of trusted parameters through.
  def coffee_params
    params.require(:coffee).permit(:roaster_id, :name, :country, :region, :town, :lat, :lng, :process, :altitude,
                                   :variety, :tasting_notes, :producer, :description, :url)
  end
end
