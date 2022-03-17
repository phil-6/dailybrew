class BrewsController < ApplicationController
  before_action :set_brew, only: %i[show edit update destroy]
  before_action :set_coffee, only: %i[new create update user_brews]
  before_action :confirm_owner, only: %i[edit update destroy]

  # GET /brews or /brews.json
  def index
    @brews = (params[:coffee_id] ? Coffee.find(params[:coffee_id]).brews : current_user.brews.includes(:coffee).all).order(created_at: :desc)
  end

  def recent_brews
    @recent_brews =
      if params[:coffee_id]
        set_coffee
        Coffee.find(params[:coffee_id]).brews.visible.includes(:user).sort_by(&:created_at).last(10).reverse
      else
        Brew.visible.includes(:user, :coffee).sort_by(&:created_at).last(10).reverse
      end

    respond_to do |format|
      format.html { render partial: 'coffees/recent_brews', locals: { brews: @recent_brews } }
    end
  end

  def user_brews
    @user_brews = @coffee.brews.where(user: current_user).sort_by(&:created_at).reverse

    respond_to do |format|
      format.html { render partial: 'coffees/user_brews', locals: { brews: @user_brews } }
    end
  end

  # GET /brews/1 or /brews/1.json
  def show; end

  # GET /brews/new
  def new
    @brew = Brew.new
    @last_brew = current_user.brews.where(coffee: @coffee).last || current_user.brews.last
    @last_coffee = @last_brew.coffee if @last_brew
  end

  # GET /brews/1/edit
  def edit; end

  # POST /brews or /brews.json
  def create
    @brew = current_user.brews.new(brew_params)
    @brew.coffee = @coffee
    @brew.time = time_in_seconds if brew_params['time'].instance_of?(String)

    respond_to do |format|
      if @brew.save
        format.html { redirect_to dashboard_path, notice: 'Brew was successfully created.' }
        format.json { render :show, status: :created, location: @brew }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brews/1 or /brews/1.json
  def update
    @brew.update(brew_params)
    @brew.time = time_in_seconds if brew_params['time'].instance_of?(String)
    respond_to do |format|
      if @brew.save!
        format.html { redirect_to brew_url(@brew), notice: 'Brew was successfully updated.' }
        format.json { render :show, status: :ok, location: @brew }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brews/1 or /brews/1.json
  def destroy
    @brew.destroy

    respond_to do |format|
      flash.now[:alert] = 'Brew was successfully destroyed.'
      format.turbo_stream
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end

  private

  def set_brew
    @brew = Brew.find(params[:id])
  end

  def set_coffee
    @coffee = params[:coffee_id] ? Coffee.find(params[:coffee_id]) : @brew.coffee
  end

  def confirm_owner
    return if @brew.user == current_user

    redirect_back(fallback_location: root_path, flash: { error: "You don't have permission to do that action." })
  end

  # Only allow a list of trusted parameters through.
  def brew_params
    params.require(:brew).permit(:user_id, :coffee_id, :equipment, :method, :coffee_weight, :water_weight, :grinder,
                                 :grinder_setting, :time, :notes, :rating, :public)
  end

  def time_in_seconds
    time = brew_params['time'].split(':')
    (time.first.to_i * 60) + time.second.to_i
  end
end
