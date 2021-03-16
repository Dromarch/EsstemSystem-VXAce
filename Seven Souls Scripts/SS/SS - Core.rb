#==============================================================================
# ** SS - Core
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Este módulo contém todas as informações públicas utilizadas pelos demais 
# códigos SS.
#==============================================================================
# * Requerimentos:   ---
#==============================================================================
module Seven_Souls
    #--------------------------------------------------------------------------
    # * Gerencia a leitura dos códigos externos
    #--------------------------------------------------------------------------
    module SS_Collection
      
      #--------------------------------------------------------------------------
      # * Lista de códigos externos a serem lidos
      #--------------------------------------------------------------------------
      $CODE = [ # NÃO APAGUE!
      "SS_CacheModifiers",
      "SS_GameModifiers",
      "SS_SpriteModifiers",
      "SS_WindowModifiers",
      "SS_SceneModifiers",
      "SS_TitleScreen"
              ] # NÃO APAGUE!
  
      #--------------------------------------------------------------------------
      # * Definição do diretório e extensão dos códigos externos
      #--------------------------------------------------------------------------
      $LOC = "Data/Codes/"
      $EXT = ".rb"
      
    end # SS_Collection
    
    #--------------------------------------------------------------------------
    # * Gerencia as informações públicas
    #--------------------------------------------------------------------------
    module Basic_Module
      
      #--------------------------------------------------------------------------
      # * Definição da tela de título
      #--------------------------------------------------------------------------
      Title_FName = "Lato Light"   # Nome da fonte dos comandos
      Title_FSize = 26             # Tamanho da fonte dos comandos
      Title_Commands = ["Aventurar", "Crônicas", "Melodias", "Opções", 
      "Créditos", "Descansar"]     # Lista de comandos
      Title_CVariable = 1          # Variável que receberá o valor dos comandos
      
      #--------------------------------------------------------------------------
      # * Definição da fonte padrão do jogo
      #--------------------------------------------------------------------------
      Font.default_name    = "Lato" # Nome da fonte
      Font.default_size    = 15     # Tamanho da fonte
      Font.default_outline = true   # Estilo outline
      Font.default_shadow  = true   # Estilo shadow
      Font.default_bold    = false  # Estilo bold
      Font.default_italic  = false  # Estilo italic
      
      #--------------------------------------------------------------------------
      # * Definição da prioridade da janela de mensagens
      #--------------------------------------------------------------------------
      Message_Z = 500
      
      #--------------------------------------------------------------------------
      # * Lista de comandos exibidos no menu
      #--------------------------------------------------------------------------
      COMMAND_LIST = { # NÃO APAGUE!
      :status  => [0, "Aventureiro", "Veja as condições do seu aventureiro."],
      :equip   => [1, "Armamento", "Veja os equipamentos do seu aventureiro."],
      :items   => [2, "Usáveis", "Veja sua coleção de itens usáveis."],
      :skills  => [3, "Talentos", "Veja e gerencie os talentos de seu aventureiro."],
      :progrss => [4, "Progresso", "Veja o progresso de seu aventureiro."],
      :options => [5, "Opções", "Veja as opções do jogo. |:V|"]
                     } # NÃO APAGUE!
                     
      #--------------------------------------------------------------------------
      # * Configurações do cursor do menu
      #--------------------------------------------------------------------------
      Cursor_Fade_Speed = 0.4       # Velocidade da animação fade do cursor
      Cursor_MaxOp      = 255       # Opacidade máxima da animação fade do cursor
      Cursor_MinOp      = 100       # Opacidade mínima da animação fade do cursor
      Cursor_Move_Speed = 4         # Velocidade do movimento do cursor
      
      
    end # Basic_Module
    
    #--------------------------------------------------------------------------
    # * Banco de sons usados pelos códigos próprios do jogo.
    #--------------------------------------------------------------------------
    module Audio
      
      # Tocar música do título
      def self.play_Title
        RPG::BGM.new("The_Stream_of_Grand_Fantasy", 100, 100).play
      end
      
      # Tocar som do cursor
      def self.play_cursor
        RPG::SE.new("SYS_CURSOR", 100, 100).play
      end
      
      # Tocar som de confirmação
      def self.play_ok
        RPG::SE.new("SYS_DETERMINATION", 100, 100).play
      end
      
    end # Audio
  end # Seven_Souls
  #==============================================================================
  # ** SS - Marshall
  #==============================================================================
  # * Executa o carregamento de todos os códigos SS
  #==============================================================================
  class << Marshal
   
    #--------------------------------------------------------------------------
    # * Permite a leitura de arquivos que não sejam do RM.
    #--------------------------------------------------------------------------
    alias :ss_load :load
    def load(port, proc = nil)
      ss_load(port, proc)
      rescue TypeError
      if port.kind_of?(File)
        port.rewind
        port.read
      else
        port
      end
    end
   
  end unless Marshal.respond_to?(:ss_load)
   
  $E_LOAD = true # Habilitar leitura dos códigos externos?
   
  if $E_LOAD
    $CODE.each {|code| eval(load_data($LOC + code + $EXT).force_encoding("UTF-8"))}
  end