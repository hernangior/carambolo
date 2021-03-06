class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create]

  # GET /entries
  # GET /entries.json
  def index
    @entries = current_user.entries.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.new(entry_params)

    respond_to do |format|
      if @entry.save
        flash[:success] = 'Entry was successfully created.'
        format.html { redirect_to @entry }
        format.json { render :show, status: :created, location: @entry }
      else
        flash.now[:error] = 'Sorry, an error has occured'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        flash[:success] = 'Entry was successfully updated.'
        format.html { redirect_to @entry }
        format.json { render :show, status: :ok, location: @entry }
      else
        flash.now[:error] = 'Sorry, an error has occured'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      flash[:success] = 'Entry was successfully destroyed.'
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:feeling, :description, :day, :hour, :user_id)
    end
end
