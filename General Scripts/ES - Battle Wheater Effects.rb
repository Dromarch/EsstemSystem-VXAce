#===============================================================================
#  ** Esteem - Efeitos Climáticos nas Batalhas
#==============================================================================
# ► Script por: Revali / Skyloftian
#------------------------------------------------------------------------------
# ► Atualizações: 20/03/18 - v1.0 - Código criado e revisado
#==============================================================================
# ► Descrição: Executa os efeitos climáticos durante as batalhas.
#------------------------------------------------------------------------------
# * Para configurar vide a área configurável abaixo.
#==============================================================================
module Esteem
  module ECnB
#==============================================================================
# ► Configurações
#==============================================================================

    WEATHER_ON_BATTLE = 00 # Switch que ativa ou desativa o efeito do script.
                           # Deixe o valor em 0 para que o efeito esteja sempre
                           # ativo.

#==============================================================================
# ► Fim das Configurações | Não mude mais nada caso não entenda
#==============================================================================
  end # ECnB
end # Esteem
class Spriteset_Battle
  include Esteem::ECnB
  
  alias :new_crvw :create_viewports
	def create_viewports
    new_crvw
    create_weather if $game_switches[WEATHER_ON_BATTLE] || WEATHER_ON_BATTLE == 0
	end

	def create_weather
		@weather = Spriteset_Weather.new(@viewport2)
	end

	alias :new_upd :update
	def update
		new_upd
		update_weather if @weather
	end

	def update_weather
		@weather.type = $game_map.screen.weather_type
		@weather.power = $game_map.screen.weather_power
		@weather.ox = $game_map.display_x * 32
		@weather.oy = $game_map.display_y * 32
		@weather.update
	end

	alias :new_disp :dispose
	def dispose
		new_disp
    	@weather.dispose if @weather
	end

end # Spriteset_Battle