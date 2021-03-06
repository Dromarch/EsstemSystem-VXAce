#===============================================================================
#  ** Esteem - Simplified One Player Menu
#-------------------------------------------------------------------------------
#  ► Atualizações: 19/09/17 (v1.0)
#                  12/01/18 (v1.1) - Adicionado compatibilidade para ativar ou 
#                                    desativar os comandos com base em switches.
#===============================================================================
#  * Menu simplificado para um personagem com apenas os comandos desejados.
#  * Sem janela dos personagens( Status_Window ).
#===============================================================================
#  * Para configurar vide a área configurável abaixo.
#===============================================================================
#  ► Script por: Skyloftian
#===============================================================================

#===============================================================================
#  * CONFIGURAÇÕES
#===============================================================================
module Esteem
    module SOP_Menu
       
    GOLD_WINDOW = true # Ativar ou não a janela de ouro. 
                       # true = ativa | false = desativa
  
  #-------------------------------------------------------------------------------
  #  * Comandos que devem ficar ativos, true = ativa | false = desativa
  #-------------------------------------------------------------------------------
    ENABLED_COMMANDS = { # Não apague!
    
          # :comando   => [true/false/switch, "Nome de Exibição no Menu"],
          #                Use true para que o comando esteja sempre ativo
          #                Use false para os comandos que não deseja usar no menu
          #                Use um número para corresponder a uma switch que ativa
          #                e desativa o comando.
            :item      => [true,  "Itens"],
            :skill     => [01,    "Habilidades"],
            :equip     => [false, ""],
            :status    => [false, ""],
            :save      => [true,  "Salvar"],
            :game_end  => [true,  "Sair"]
            
            } # Não apague!
            
    end # SOP_Menu
  end #Esteem
  #===============================================================================
  # > Fim das Configurações
  #   - Aqui termina a área configurável do script e começa o código. Não recomen-
  #   do que o altere, isso é, a menos que tenha certeza do que está fazendo.
  #===============================================================================
  class Window_MenuCommand < Window_Command
    include Esteem::SOP_Menu
    
    def make_command_list
      add_enabled_commands
    end
    
    def add_enabled_commands
        ENABLED_COMMANDS.each do |s, k|
        case s
        when s
          if k[0] != true && k[0] != false
            if $game_switches[k[0]]
              add_command(k[1],   s,   main_commands_enabled)
            end
          elsif k[0]
            add_command(k[1],   s,   main_commands_enabled)
          end
        end
      end
    end
    
  end # Window_MenuCommand
  class Scene_Menu < Scene_MenuBase
    include Esteem::SOP_Menu
    
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
    
    def command_personal
      case @command_window.current_symbol
      when :skill
        SceneManager.call(Scene_Skill)
      when :equip
        SceneManager.call(Scene_Equip)
      when :status
        SceneManager.call(Scene_Status)
      end
    end
  
  end # Scene_Menu