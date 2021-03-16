#===============================================================================
# Esteem - Scene_Title Skip
#-------------------------------------------------------------------------------
# Script por: Revali
#===============================================================================
# Não há comentários adicionais
#===============================================================================
class Scene_Title < Scene_Base
  
    def start
      super
      DataManager.setup_new_game
      fadeout_all
      $game_map.autoplay
      SceneManager.goto(Scene_Map)
    end
    
    def terminate
      super
    end
    
  end # Scene_Title