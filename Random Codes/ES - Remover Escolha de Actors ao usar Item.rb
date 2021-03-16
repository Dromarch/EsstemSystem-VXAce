#==============================================================================
# ** Esteem [Código Rápido] - Remover Escolha de Actors ao usar Item
#==============================================================================
# Script por: Skyloftian
#------------------------------------------------------------------------------
# Atualizações: 12/01/18 v1.0 Concluído
#==============================================================================
class Scene_ItemBase < Scene_MenuBase
  
    def determine_item
      if item.for_friend?
        use_item
      else
        use_item
        activate_item_window
      end
    end
    
    def use_item
      play_se_for_item
      user.use_item(item)
      use_item_to_actors
      check_common_event
      check_gameover
      activate_item_window
    end
  
  end # Scene_ItemBase