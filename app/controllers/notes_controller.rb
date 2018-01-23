class NotesController < ApplicationController

  def new
    @appointment = Appointment.new
    @note = @appointment.notes.build
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.new(notes_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:notice] = "Saved successfully!"
      redirect_to appointment_path(@appointment)
    else
      render 'new'
    end
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

  private

    def notes_params
      params.require(:note).permit(:description)
    end

end
