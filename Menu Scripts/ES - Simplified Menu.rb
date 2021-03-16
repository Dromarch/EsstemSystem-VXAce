#===============================================================================
#  ◇ Esteem - Simplified Menu
#-------------------------------------------------------------------------------
#  ► 19/09/17 (v1.0)
#===============================================================================
#  * Menu simplificado com apenas os comandos desejados.
#  * Sem janela dos personagens( Stauts_Window ).
#===============================================================================
#  * Para configurar vide a área configurável abaixo.
#===============================================================================
#  ► Por: Revali (aka. Skyloftian)
#===============================================================================

#===============================================================================
#  * CONFIGURAÇÕES
#===============================================================================
module Esteem
    module SMenu
       
    GOLD_WINDOW = true # Ativar ou não a janela de ouro. 
                       # true = ativa | false = desativa
  
  #-------------------------------------------------------------------------------
  #  * Comandos que devem ficar ativos, true = ativa | false = desativa
  #-------------------------------------------------------------------------------
    ENABLED_COMMANDS = { # Não apague!
    
          # :comando   => [true/false, "Nome de Exibição no Menu"],
            :item      => [true, "Itens"],
            :skill    =>  [false, ""],
            :equip     => [false, ""],
            :status    => [false, ""], 
            :formation => [false, ""],
            :save      => [true,  "Salvar"],
            :game_end  => [true,  "Sair"]
            
            } # Não apague!
            
    end # SMenu
  end #Esteem
  #===============================================================================
  # > Fim das Configurações
  #   - Aqui termina a área configurável do script e começa o código. Não recomen-
  #   do que o altere, isso é, a menos que tenha certeza do que está fazendo.
  #===============================================================================
  class Window_MenuCommand < Window_Command
    include Esteem::SMenu
    
    def make_command_list
      add_enabled_commands
    end
    
    def add_enabled_commands
        ENABLED_COMMANDS.each do |s, k|
        case s
        when s
          if k[0]
            add_command(k[1],   s,   main_commands_enabled)
          end
        end
      end
    end
    
  end # Window_MenuCommand
  class Scene_Menu < Scene_MenuBase
    include Esteem::SMenu
    
    def start
      super
      create_command_window
      create_gold_window if GOLD_WINDOW
      set_windows_positions
    end
    
    def set_windows_positions
      @command_window.x = (Graphics.width / 2) - (@command_window.width / 2)
      if GOLD_WINDOW
        @command_window.y = ((Graphics.height / 2) - (@command_window.height / 2)) - (@gold_window.height / 2)
        @gold_window.x = @command_window.x
        @gold_window.y = @command_window.y + @command_window.height
      else
        @command_window.y = (Graphics.height / 2) - (@command_window.height / 2)
      end
    end
    
  end # Scene_Menu