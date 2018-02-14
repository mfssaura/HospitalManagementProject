class NotesController < ApplicationController

  before_action :check_user, only:[:edit, :destroy]

  def new
    @appointment = Appointment.new
    @note = @appointment.notes.build
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.new(notes_params)
    @note.user_id = current_user.id
    respond_to do |format|
      if @note.save 
        format.html { redirect_to appointment_path(@appointment), notice: "Saved successfully" }
        format.js
      else
        format.html { render 'new', notice: "Try again" }
        format.js
      end 
    end 
    # if @note.save
    #   flash[:notice] = "Saved successfully!"
    #   redirect_to appointment_path(@appointment)
    # else
    #   flash[:alert] = "Unable to save!"
    #   render 'new'
    # end
  end

  def show
    @appointment = Appointment.find(params[:appointment_id])
  end

  def destroy
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.find(params[:id])
    @note.destroy
    redirect_to appointment_path(@appointment)
  end

  def check_user
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.find(params[:id])
    #Restrict user to edit other users notes
    redirect_to authenticated_root_path and return if current_user.id != @note.user_id
  end 

  def edit
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.find(params[:id])
    if @note.update(notes_params)
      flash[:notice] = "Updated"
      redirect_to appointment_path(@appointment)
    else
      flash[:alert] = "Opps!"
      render 'edit'
    end
  end

  private

    def notes_params
      params.require(:note).permit(:description)
    end

end
