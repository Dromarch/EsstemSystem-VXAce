#==============================================================================
# ** Esteem - SS | Quest Window
#==============================================================================
# Script por: Revali / Skyloftian
#------------------------------------------------------------------------------
# Descrição: Script feito a pedido de ~Vici para seu projeto Seven Souls.
#
#            O código cria uma janela invisível que pode ser ativada através
#            de uma switch.
#------------------------------------------------------------------------------
# Atualizações: 11/01/18 - v1.0 - Código criado e revisado
#               12/01/18 - v1.1 - Corrigido BUG em que o texto não atualizava
#                                 após o valor da variável ser alterado.
#				13/01/18 - v1.2 - Adicionado exibição do nome do mapa.
#==============================================================================
module Esteem
    module SS_Quest_Window
  
      QUEST_ACTIVATE_WINDOW_SWITCH   = 01 # Switch para ativar/desativar a janela
      
      MAPNAME_ACTIVATE_WINDOW_SWITCH = 02 # Switch para ativar/desativa o nome do mapa
      
      QUEST_CHARACTER_VARIABLE       = 01 # Variável que guarda o herói atual
      QUEST_NUMBER_VARIABLE          = 02 # Variável que guarda a quest atual
  
      QUESTS_TEXT = [ # Don't Touch
      
                    [ # Start Sky Quests | Variable Value = [0]
                    ["Assuntos Pendentes", "Sky descobre algo que não deveria e corre\no sério risco de morrer."],  # Quest 00
                    ["Labareda, labareda", "Sou \\c[5]canela de fogo\\c[0]"],
                    ["Sabe aquela feiticeira que tramou contra você?", "Ela vai se converter"]
                    ], # End Sky Quests
                    
                    [ # Start Other Character Quests | Variable Value = [1]
                    ["Quest [00] Title", "Quest [00] Description"],
                    ["Quest [01] Title", "Quest [01] Description"]
                    ] # End Other Character Quests
                    
                    ] # Don't Touch
                    
      WINDOW_X      = 0   # Posição X da janela
      WINDOW_Y      = 0   # Posição Y da janela
      WINDOW_WIDTH  = 416 # Largura da janela
      WINDOW_HEIGHT = 224 # Altura da janela
      
      MAPNAME_X      = 0   # Posição X do nome do mapa
      MAPNAME_Y      = 0   # Posição Y do nome do mapa
      MAPNAME_WIDTH  = Graphics.width # Largura do nome do mapa
      MAPNAME_HEIGHT = 32 # Altura do nome do mapa
      
      WINDOW_FONT_NAME       = "Lato" # Nome da fonte usada na janela de quests
      WINDOW_TITLE_FONT_SIZE = 30     # Tamanho da fonte do título da missão
      WINDOW_TEXT_FONT_SIZE  = 24     # Tamanho da fonte do texto da missão
                    
      MAPNAME_FONT_NAME = "Lato" # Nome da fonte usada no nome do mapa
      MAPNAME_FONT_SIZE = 30     # Tamanho da fonte do nome do mapa
      
      TITLE_COLOR   = [120, 120, 120] # Cor do título da missão em R, G, B
      MAPNAME_COLOR = [  0,   0, 255] # Cor do nome do mapa em R, G, B
      
      TITLE_SPACING = 10 # Espaçamento extra entre o título e o texto
      LINE_HEIGHT   = 20 # Altura da linha
      
    end # SS_Quest_Window
  end # Esteem
  #==============================================================================
  # Fim das Configurações | Não mude mais nada caso não entenda
  #==============================================================================
  class Scene_Map < Scene_Base
    include Esteem::SS_Quest_Window
  
    alias :new_windows :create_all_windows 
    def create_all_windows
      new_windows
      create_quest_window
      create_mapnameonscreen_window 
    end
  
    def create_quest_window
      @quest_window = Window_Quest.new(WINDOW_X, WINDOW_Y, WINDOW_WIDTH, WINDOW_HEIGHT)
      @quest_window.hide
      @refresh_quest_window = $game_variables[QUEST_NUMBER_VARIABLE]
    end
    
    def create_mapnameonscreen_window
      @mapnameonscreen_window = Window_MapName_on_Screen.new(MAPNAME_X, MAPNAME_Y, MAPNAME_WIDTH, MAPNAME_HEIGHT) 
      @mapnameonscreen_window.hide
      @refresh_map_name = $game_map.display_name
    end
    
    alias :activate_quest_window :update
    def update
      activate_quest_window
      if $game_switches[QUEST_ACTIVATE_WINDOW_SWITCH]
        @quest_window.show
      else
        @quest_window.hide
      end
      if $game_switches[MAPNAME_ACTIVATE_WINDOW_SWITCH]
        @mapnameonscreen_window.show
      else
        @mapnameonscreen_window.hide
      end
      if @refresh_quest_window != $game_variables[QUEST_NUMBER_VARIABLE]
        @refresh_quest_window = $game_variables[QUEST_NUMBER_VARIABLE]
        @quest_window.refresh
      end
      if @refresh_map_name != $game_map.display_name
        @refresh_map_name = $game_map.display_name
        @mapnameonscreen_window.refresh
      end
    end
    
  end # Scene_Map
  class Window_Quest < Window_Base
    include Esteem::SS_Quest_Window
    
    def initialize(x, y, w, h)
      super
      self.opacity = 0
      draw_quest_text
    end
    
    def title_color  
      Color.new(TITLE_COLOR[0], TITLE_COLOR[1], TITLE_COLOR[2], 255)
    end
    
    def standard_padding
      return 0
    end
  
    def line_height
      LINE_HEIGHT
    end
    
    def draw_quest_text
      title = QUESTS_TEXT[$game_variables[QUEST_CHARACTER_VARIABLE]][$game_variables[QUEST_NUMBER_VARIABLE]][0]
      text = QUESTS_TEXT[$game_variables[QUEST_CHARACTER_VARIABLE]][$game_variables[QUEST_NUMBER_VARIABLE]][1]
      change_color(title_color)
      contents.font.outline = false
      contents.font.shadow = false
      contents.font.name = WINDOW_FONT_NAME
      contents.font.size = WINDOW_TITLE_FONT_SIZE
      draw_text(0, 0, text_size(title).width, contents.font.size,  title)
      change_color(normal_color)
      contents.font.size = WINDOW_TEXT_FONT_SIZE
      draw_text_ex(0, text_size(title).height + TITLE_SPACING, text)
    end
    
    def draw_text_ex(x, y, text)
      text = convert_escape_characters(text)
      pos = {x: x, y: y, new_x: x, height: line_height}
      process_character(text.slice!(0, 1), text, pos) until text.empty?
    end
    
    def refresh
      contents.clear
      draw_quest_text
    end
    
  end # Window_Quest
  
  class Window_MapName_on_Screen < Window_Base
    include Esteem::SS_Quest_Window
    
    def initialize(x, y, w, h)
      super
      self.opacity = 0
      draw_map_name_text
    end
    
    def standard_padding
      return 0
    end
    
    def mapname_color  
      Color.new(MAPNAME_COLOR[0], MAPNAME_COLOR[1], MAPNAME_COLOR[2], 255)
    end
    
    def draw_map_name_text
      contents.font.name = MAPNAME_FONT_NAME
      contents.font.size = MAPNAME_FONT_SIZE
      contents.font.outline = false
      contents.font.shadow = false
      change_color(mapname_color)
      w = MAPNAME_WIDTH
      text = $game_map.display_name
      draw_text_ex(Graphics.width / 2 - text_size(text).width / 2, 0, text_size(text).width, text_size(text).height, text)
    end
    
    def draw_text_ex(x, y, width, height, text)
      text = convert_escape_characters(text)
      pos = {x: x, y: y, new_x: width, height: height}
      process_character(text.slice!(0, 1), text, pos) until text.empty?
    end
    
    def refresh
      contents.clear
      draw_map_name_text
    end
    
  end # Window_MapName_on_Screen