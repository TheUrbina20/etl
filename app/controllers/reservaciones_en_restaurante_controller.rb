class ReservacionesEnRestauranteController < ApplicationController
  def index
    @reservaciones_en_restaurante = ReservacionEnRestaurante.using(:dwh_t).where(error: true)
  end

  def edit
    @reservacion_en_restaurante = ReservacionEnRestaurante.using(:dwh_t).find(params[:id])
  end

  def destroy
    @reservacion_en_restaurante = ReservacionEnRestaurante.using(:dwh_t).find(params[:id])
    if @reservacion_en_restaurante.destroy
      flash[:notice] = 'Eliminado'
    else
      flash[:alert] = 'Error eliminando'
    end
    redirect_to reservaciones_en_restaurante_index_path
  end

  def update
    @reservacion_en_restaurante = ReservacionEnRestaurante.using(:dwh_t).find(params[:id])
    if validate_attributes && @reservacion_en_restaurante.update(reservacion_restaurante_params)
      @reservacion_en_restaurante.update_attributes(error: false)
      flash[:notice] = 'Actualizado'
      redirect_to reservaciones_en_restaurante_index_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def reservacion_restaurante_params
    params.require(:reservacion_en_restaurante).permit(:f_reservacion, :hora, :idcliente, :id_empleado)
  end

  def validate_attributes
    valid_date?(params[:reservacion_en_restaurante][:f_reservacion])
  end

end
