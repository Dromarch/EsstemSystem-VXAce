#===============================================================================
# Janela Especial - Valor de Variável
#-------------------------------------------------------------------------------
# Por: Skyloftian
#===============================================================================
# > Versão 1.0
#-------------------------------------------------------------------------------
# > Atualizações:
#   - 20/01/17 (v0.1) : Concluído
#===============================================================================
# > Função:
#   - Mostra uma janela com um texto e o valor de uma variável.
#===============================================================================
# > Script feito sob medida para o membro guKing
#===============================================================================
# > Dúvidas e afins? Acesse: www.centrorpg.com
#===============================================================================
module Esteem
    module Moves
      
      # Configure aqui as informações vitáis do script
      
      SWITCH   = 1 # ID da Switch que mostra/esconde a janela
      
      TEXT     = "Movimentos disponíveis para o Shard:" # Texto que aparecerá na janela
      VARIABLE = 1 # ID da Variável que guarda o valor a ser mostrado na janela
      
      WIND_X   = 0   # Posição horizontal da janela
      WIND_Y   = 0   # Posição vertical da janela
      WIDTH    = 310 # Largura da janela
      
    end # Moves
  end # Esteem
  #=============================================================
  # > Window_Variable < Window_Base
  #=============================================================
  class Window_Variable < Window_Base
    include Esteem::Moves
    
    #---------------------------------------------------------
    # ~ Initialize
    #--------------------------------------------------------- 
    def initialize
      super(WIND_X, WIND_Y, window_width, fitting_height(1))
      self.openness = 0
    end
    
    #---------------------------------------------------------
    # ~ Window_Width
    #--------------------------------------------------------- 
    def window_width
      return WIDTH
    end
    
    #---------------------------------------------------------
    # ~ Refresh
    #--------------------------------------------------------- 
    def refresh
      text = TEXT
      value = $game_variables[VARIABLE]
      contents.clear
      draw_text(0, 0, 5 + text_size(text).width, text_size(text).height, text)
      draw_text(5 + text_size(text).width, 0, 5 + text_size(value).width, text_size(value).height, value)
    end
    
    #---------------------------------------------------------
    # ~ Update 
    #--------------------------------------------------------- 
    def update
      super
      update_openness
      refresh
    end
    
    #---------------------------------------------------------
    # ~ Update_Openness
    #--------------------------------------------------------- 
    def update_openness
      open if $game_switches[SWITCH]
      close if !$game_switches[SWITCH]
    end
    
  end # Window_Variable
  
  #=============================================================
  # > Scene_Map < Scene_Base
  #=============================================================
  class Scene_Map < Scene_Base
    
    #---------------------------------------------------------
    # ~ Create_All_Window
    #--------------------------------------------------------- 
    alias :new_placement :create_all_windows
    def create_all_windows
      new_placement
      create_window_variable
    end
    
    #---------------------------------------------------------
    # ~ Create_Window_Variable
    #--------------------------------------------------------- 
    def create_window_variable
      @variable_window = Window_Variable.new
    end
    
  end # Scene_Map