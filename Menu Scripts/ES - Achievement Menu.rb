#===============================================================================
# Esteem - Achievement Menu
#-------------------------------------------------------------------------------
# Por: Revali
#===============================================================================
# > Versão 1.0
#-------------------------------------------------------------------------------
# > Atualizações:
#   - 21/04/17 (v1.0) : Concluído
#-------------------------------------------------------------------------------
# > Termos de Uso:
#   - Script feito sob o pedido do colega Manec. O uso é único e exclusivo
#   para ele.
#   - Os créditos são obrigatórios, mas sinta-se livre para não creditar-me.
#   - O script não deve ser postado em outro lugar, caso deseje isso, favor me
#   contatar antes.
#   - O script pode ser modificado por sua conta e risco, mas não me responsabi-
#   lizo por quaisquer erros que venham a ocorrer posteriormente.
#===============================================================================
# > Função:
#   - Este script cria uma cena de conquistas que é chamada ao pressionar a
#   tecla P do teclado.
#-------------------------------------------------------------------------------
# > Instruções:
#   - Não há muito o que fazer, apenas configurar os tópicos que são encontrados
#   logo abaixo.
#===============================================================================
# > Dúvidas e afins? Acesse: www.centrorpg.com e me contate
#===============================================================================

module Esteem
	module Achievement
    #===========================================================================
    # > Configurações:
    #   - Aqui você encontrará todas as configurações que podem ser realizadas
    #   no script.
    #---------------------------------------------------------------------------
    # > Configurações do fundo da cena:

    	ACH_TITLE_TEXT = "MENU DE CONQUISTAS" # Título que aparecerá na cena

    	ACH_TITLE_BACK = "Title_Back"         # Nome da imagem de fundo do
    										  # título da cena

    	ACH_LIST_BACK  = "List_Back"          # Nome da imagem de fundo da
    										  # lista de conquistas

    	ACH_SWI        = 05                   # Switch que ativa ou desativa
    										  # a chamada do menu ao 
    										  # pressionar P.

		ACHIEVEMENT_LIST = { # Don't Touch This

							   #:símbolo     => ["Nome", Variável, Valor Máximo, Switch],
							   #:símbolo     =  Qualquer coisa, serve apenas 
							   #				para identificar cada opção.
							   #"Nome"		 =  Nome da conquista.
							   #Variável     =  Numéro da variável que contará.
							   #Valor Máximo =  Valor máximo que contará.
							   #Switch       =  Switch que ativará a conquista
							   #                e a fará aparecer.
							   #                Deixe 0 para ela aparecer por
							   #                padrão.

								:first_list  => ["Matar um javali.", 1, 1, 0],
								:second_list => ["Comer um javali.", 1, 1, 2],
								:third_list  => ["Encontrar dois mapas.", 2, 2, 0]

						   } # Don't Touch This

	end # Achievement
end # Esteem
#===============================================================================
# > Fim das Configurações
#   - Aqui termina a área configurável do script e começa o código. Não recomen-
#   do que o altere, isso é, a menos que tenha certeza do que está fazendo.
#===============================================================================

#=============================================================
# > Scene_Achievement
#=============================================================
class Scene_Achievement < Scene_Base
	include Esteem::Achievement

	def start
		super
		draw_background
		create_window
	end

	def draw_background
	    @background_sprite = Sprite.new
	    @background_sprite.bitmap = SceneManager.background_bitmap
	    @background_sprite.color.set(16, 16, 16, 128)

	    @titleback = Sprite.new
	    @titleback.bitmap = Cache.picture("ACH_TITLE_BACK")

	    @titletext = Sprite.new
	    @titletext.bitmap = Bitmap.new(Graphics.width, 25)
	    @titletext.bitmap.font.size = 25
	    @titletext.bitmap.draw_text(0, 0, Graphics.width, 25, ACH_TITLE_TEXT, 1)
	    @titletext.y = (72 / 2) - (25 / 2)

	    @listback = Sprite.new
	    @listback.bitmap = Cache.picture("ACH_LIST_BACK")
	    @listback.y = 72
    end    

	def create_window
		@ListWindow = Window_AchievementList.new(0, 72)
		@ListWindow.opacity = 0
		@ListWindow.set_handler(:cancel, method(:return_scene))
	end

	def terminate
		super
		dispose_sprites
	end

	def dispose_sprites
		@background_sprite.dispose
		@titleback.dispose
		@titletext.dispose
		@listback.dispose
	end
	
end # Scene_Achievement

#=============================================================
# > Window_AchievementList
#=============================================================
class Window_AchievementList < Window_Command
  include Esteem::Achievement
  
	def initialzie
		super(0,72)
	end

	def window_width
		Graphics.width
	end
  
	def window_height
	    Graphics.height - 72
	end


	def ok_enabled?
		return false
	end

	def visible_line_number
		item_max
	end

	def alignment
		return 1
	end

	def make_command_list
		ACHIEVEMENT_LIST.each do |symbol, infos|
			case symbol
			when symbol
				add_command("#{infos[0]}   #{$game_variables[infos[1]]}/#{infos[2]}", symbol) if $game_switches[infos[3]] || infos[3] == 0
			end
		end
	end

end # Window_AchievementList

#=============================================================
# > Scene_Map
#=============================================================
class Scene_Map < Scene_Base
	include Esteem::Achievement

	alias :press_new_key :update
	def update
		press_new_key
		call_achievement_scene
	end

	def call_achievement_scene
		if Input.trigger?(Key::P) && ACH_SWI
			Sound.play_ok
			SceneManager.call(Scene_Achievement)
		end
	end

end # Scene_Map