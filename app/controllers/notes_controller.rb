class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id
    @note.save
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track_id)
  end

  private
  def note_params
    params.require(:note).permit(:note_body)
  end
end
