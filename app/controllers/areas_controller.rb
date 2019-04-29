class AreasController < ApplicationController
  def index
    initialize_areas
    @areas = Area.using(:dwh_t).all
  end

  def edit
    @areas = Area.using(:dwh_t).find(params[:id])
  end

  def update
    @areas = Area.using(:dwh_t).find(params[:id])

    if @areas.update(areas_params)
      flash[:notice] = 'Actualizado Correctamente'
      redirect_to areas_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def areas_params
    params.require(:area).permit(:id, :nombre, :clave)
  end

  private

  def initialize_areas
    area = Area.using(:dwh_t).delete_all

    areas = Area.using(:rrhh).all

    areas.each do |area_r|
      area = Area.using(:dwh_t).new()

      area.id = area_r.id
      area.nombre = area_r.nombre
      area.clave = area_r.clave
      area.save!
    end
  end
end
