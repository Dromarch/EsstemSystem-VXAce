#==============================================================================
# ** Esteem [Código Rápido] - Change Windowskin
#==============================================================================
# ► Script por: Skyloftian
#------------------------------------------------------------------------------
# ► Atualizações: 08/06/18 v1.0 Concluído
#==============================================================================
# ► Descrição: Esse é um código simples para trocar a windowskin a qualquer 
# momento através do comando Chamar Script (Script Call).
#==============================================================================
# ► Intruções de Uso: Para alterar a windowskin a qualquer momento, basta em
# um evento chamar o seguinte código através do comando Chamar Script:
#
# esteem_change_windowskin("nome_da_windowskin")
#
# Lembrando que as windowskins devem estar na pasta Graphics/System.
#==============================================================================
# ► Início do Código | Não mude nada caso não entenda
#==============================================================================
class Window_Base < Window
  
    alias :esteem_cw_wb_init :initialize
    def initialize(x, y, width, height)
      esteem_cw_wb_init(x, y, width, height)
      self.windowskin = Cache.system($game_system.windowskin)
    end
    
    alias :esteem_cw_wb_up :update
    def update
      esteem_cw_wb_up
      self.windowskin = Cache.system($game_system.windowskin) if self.windowskin != Cache.system($game_system.windowskin)
    end
    
end # Window_Base
class Game_System
    
    attr_accessor :windowskin
    
    alias :esteem_cw_gs_init :initialize
    def initialize
      esteem_cw_gs_init
      @windowskin = "Window"
    end
    
end # Game_System
  class Game_Interpreter
    
    def esteem_change_windowskin(windowskin_name)
      $game_system.windowskin = windowskin_name
    end
    
end # Game_Interpreter