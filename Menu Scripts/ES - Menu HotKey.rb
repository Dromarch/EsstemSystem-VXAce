#==============================================================================
#  ** Esteem - Menu HotKey
#==============================================================================
# ► Script por: Skyloftian
#------------------------------------------------------------------------------
# ► Atualizações: 16/06/18 - v1.0 - Código finalizado e revisado
#==============================================================================
# ► Descrição: Possibilita chamar as cenas do menu através de hotkeys.
#==============================================================================
# ► Comandos: Existem dois comandos para ativar ou desativar as hotkeys.
#
#             esteem_enable_scene(:symbol)     - Ativa a HotKey
#             esteem_disable_scene(:symbol)    - Desativa a Hotkey
#
# * Exemplos de Uso: esteem_enable_scene(:item)
#                    esteem_enable_scene(:equip, :save, :exit)
#                    esteem_disable_scene(:item, skill)
#
# * OBSERVAÇÃO: Estes comandos devem ser usados através do comando de evento
#               Chamar Script / Script Call.
#==============================================================================
# * Para configurar vide a área configurável abaixo.
#==============================================================================
module Esteem
    module MenuHotkey
  #==============================================================================
  # ► Configurações
  #==============================================================================
    HOTKEYS = { # Não apague!
     #===========================================================================
     # ► Definição dsa HotKeys
     #===========================================================================
     # * Configure as teclas de cada atalho e suas respectivas cenas.
     #---------------------------------------------------------------------------
     # :simbolo = [:tecla, Scene_Name]
     #
     # :simbolo   | É a forma de identificar os comandos. Pode ser qualquer coisa.
     # :tecla     | É a tecla utilizada para a hotkey.
     # Scene_Name | É o nome da classe responsável por processar a cena desejada.
     #===========================================================================
       :item     => [:L, Scene_Item],
       :skill    => [:R, Scene_Skill],
       :equip    => [:X, Scene_Equip],
       :save     => [:Y, Scene_Save],
       :exit     => [:B, Scene_End],
       :custom1  => [:Z, Scene_Menu]
     #===========================================================================
     # * Fim das Configurações
     #===========================================================================
             } # Não apague!
    end # MenuHotkey
  end # Esteem
  #==============================================================================
  # ► Início do Código | Não mude nada caso não entenda
  #==============================================================================
  class Scene_Map < Scene_Base
    
    def call_menu(scene)
      Sound.play_ok
      SceneManager.call(scene)
    end
    
    def update_call_menu
      Esteem::MenuHotkey::HOTKEYS.each do |scene, key|
        if Input.trigger?(key[0])
          if $game_system.enabled_scenes[scene]
            case scene
            when scene
              call_menu(key[1])
            end
          end
        end
      end
    end
    
  end # Scene_Map
  class Game_System
    
    attr_accessor :enabled_scenes
    
    alias :esteem_mh_gs_init :initialize
    def initialize
      esteem_mh_gs_init
      @enabled_scenes = {}
    end
    
  end # Game_System
  class Game_Interpreter
   
    def esteem_enable_scene(*scene_symbol)
      for scene in scene_symbol
        $game_system.enabled_scenes[scene] = true
      end
    end
    
    def esteem_disable_scene(*scene_symbol)
      for scene in scene_symbol
        $game_system.enabled_scenes[scene] = false
      end
    end
   
  end # Game_Interpreter