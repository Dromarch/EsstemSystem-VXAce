#==============================================================================
# ** SS - Game Modifiers
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Coletânea de todas modificações realizadas nas classes Game_ padrões do
# RPG Maker VXAce.
#==============================================================================
# * Requerimentos:   ---
#==============================================================================

#==============================================================================
# ** Game_System Modifiers
#------------------------------------------------------------------------------
# * As modificações dessa classe inicializam novas variáveis públicas que são 
# utilizadas pelos demais códigos SS.
#==============================================================================
class Game_System
  
    #--------------------------------------------------------------------------
    # * Variáveis públicas
    #--------------------------------------------------------------------------
    attr_accessor :message_style            # Estilo das mensagens
    attr_accessor :message_name             # Nome das mensagens
    
    #--------------------------------------------------------------------------
    # * Alias da inicialização do objeto
    #--------------------------------------------------------------------------
    alias :ss_gs_init :initialize
    def initialize
      ss_gs_init
      @message_style = :normal
      @message_name = ""
    end
    
  end # Game_System
  #==============================================================================
  # ** Game_Interpreter Modifiers
  #------------------------------------------------------------------------------
  # * As modificações dessa classe gerenciam os novos comandos script call 
  # implementados pelos demais códigos SS.
  #==============================================================================
  class Game_Interpreter
    
    #--------------------------------------------------------------------------
    # * Definir estilo da mensagem
    #     symbol     : estilo da mensagem
    #--------------------------------------------------------------------------
    def message_style(style)
      $game_system.message_style = style
    end
    
    #--------------------------------------------------------------------------
    # * Definir nome da mensagem
    #     name      : nome da mensagem
    #--------------------------------------------------------------------------
    def message_name(name)
      $game_system.message_name = name
    end
    
  end # Game_Interpreter