class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @show = Show.find(params[:show_id])
  end

  # GET /bookings/1/edit
  def edit
    @show = @booking.show
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.show = Show.find(params[:booking][:show_id])
    @booking.show.available_seats -= @booking.seats

    respond_to do |format|
      if @booking.save
        @booking.show.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
	@booking.show.available_seats += @booking.seats
        @booking.show.save
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def populate_show
	  @show = Show.where("movie_id=?", params[:movie_id]).includes(:time_slot, :screen)
    @show.get_show_date(params[:show_date]) if params[:show_date]
    if @show
      respond_to do |format|
        format.js { render 'populate_show', :formats => [:js] }
      end
    else
      respond_to do |format|
        format.json { render json: @show.errors, status: :unprocessable_entity}
      end
    end
  end

  def populate_screen
    @show = Show.where("movie_id=? AND show_date=? AND screen_id=? AND time_slot_id=?", params[:movie_id], params[:show_date], params[:screen_id], params[:time_slot_id])
    puts @show.inspect
    if @show
      respond_to do |format|
        format.js { render 'populate_screen', :formats => [:js] }                                                                   end
    else
      respond_to do |format|
        format.json { render json: @show.errors, status: :unprocessable_entity}                                                   end
    end
      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:user_id, :show_id, :seats, :total_price, :status, :movie_tickets)
    end
end
