class ReservesController < ApplicationController

  def create
    reserve = Reserve.new permit_params
    if reserve.save
      render status: 200, json: { data: reserve, message: 'Reserva creada correctamente' }
    else
      errors = reserve.errors.full_messages.to_sentence
      render status: 422, json: { message: errors }
    end
  end

  def by_date
    reserves = Reserve.includes(:movie).search_by_dates(search_params[:start_date], search_params[:end_date]).to_json(include: [:movie])
    if reserves.present?
      render status: 200, json: reserves
    else
      render status: 404, json: { message: 'No hay reservas en las fechas seleccionadas'}
    end
  end

  private

  def permit_params
    params.require(:reserve).permit(:cellphone, :number_document, :email, :movie_id,
                                    :name, :reserve_date, :seat)
  end

  def search_params
    params.permit(:end_date, :start_date)
  end
end
