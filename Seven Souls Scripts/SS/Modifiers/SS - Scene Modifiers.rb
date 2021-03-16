#==============================================================================
# ** SS - Scene Modifiers
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Coletânea de todas modificações realizadas nas classes Scene_ padrões do
# RPG Maker VXAce.
#==============================================================================
# * Requerimentos:   ---
#==============================================================================

#==============================================================================
# ** Scene_Title Modifiers
#------------------------------------------------------------------------------
# * As modificações dessa classe pulam o processamento da cena da tela de
# título, levando o jogador diretamente ao primeiro mapa do jogo.
#==============================================================================
class Scene_Title < Scene_Base
  
    #--------------------------------------------------------------------------
    # * Inicialização do processo
    #--------------------------------------------------------------------------
    def start
      super
        DataManager.setup_new_game
        fadeout_all
        $game_map.autoplay
        SceneManager.goto(Scene_Map)
    end
    
    #--------------------------------------------------------------------------
    # * Finalização do processo
    #--------------------------------------------------------------------------
    def terminate
      super
    end
    
  end # Scene_Title