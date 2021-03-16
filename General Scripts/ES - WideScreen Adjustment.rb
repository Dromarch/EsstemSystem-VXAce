#==============================================================================
# ✦ Esteem System - WideScreen Adjustment
#==============================================================================
# ➛ Script por: Revali / Skyloftian
#------------------------------------------------------------------------------
# ➛ Descrição: Código extremamente simples para realizar os ajustes necessários
# para se utilizar uma resolução 16:9 no RPG Maker VXAce.
#==============================================================================
module Esteem
    module SA
    
    Graphics.resize_screen(640, 360) # Set the screen size - 640 x 360
  
    end # SA
end # Esteem
class Game_Map

def height
    if @map.height == 13
    return 11.25
    else 
    @map.height
    end
end

def screen_tile_y
    11.25
end

end # Game_Map