class SavingsController < ApplicationController
  # GET /savings
  # GET /savings.json
  def index
    @savings = Saving.all
    @sum = Saving.sum

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @savings }
    end
  end

  # GET /savings/1
  # GET /savings/1.json
  def show
    @saving = Saving.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saving }
    end
  end

  # GET /savings/new
  # GET /savings/new.json
  def new
    @saving = Saving.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saving }
    end
  end

  # GET /savings/1/edit
  def edit
    @saving = Saving.find(params[:id])
  end

  # POST /savings
  # POST /savings.json
  def create
    @saving = Saving.new(params[:saving])

    respond_to do |format|
      if @saving.save
        format.html { redirect_to @saving, notice: 'Saving was successfully created.' }
        format.json { render json: @saving, status: :created, location: @saving }
      else
        format.html { render action: "new" }
        format.json { render json: @saving.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /savings/1
  # PUT /savings/1.json
  def update
    @saving = Saving.find(params[:id])

    respond_to do |format|
      if @saving.update_attributes(params[:saving])
        format.html { redirect_to @saving, notice: 'Saving was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saving.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /savings/1
  # DELETE /savings/1.json
  def destroy
    @saving = Saving.find(params[:id])
    @saving.destroy

    respond_to do |format|
      format.html { redirect_to savings_url }
      format.json { head :no_content }
    end
  end

  def send_mail
    Message.notice.deliver
    redirect_to action: :index

  end
end
