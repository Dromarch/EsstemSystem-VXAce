#==============================================================================
#  ** Esteem - Window Message Auto Size
#==============================================================================
# ► Script por: Gabriel N.
#------------------------------------------------------------------------------
# ► Atualizações: 24/07/19 - v1.0 - Código finalizado e revisado
#==============================================================================
# ► Descrição: Quando ativo, faz com que a janela de mensagens automaticamente
# ajuste seu tamanho com base em seu conteúdo.
#
# * O código identifica e ignora os caracteres de todos os comandos de mensagem
# fazendo com que o ajuste automático do tamanho da janela leve em conta apenas 
# o texto visível, mesmo que na composição da mensagem haja caracteres que não 
# são mostrados no texto final.
#   Ex:\c[n], \., \$, etc...
#
# * As faces são centralizadas automaticamente, independente da altura da
# janela.
#
# * Você também pode definir as coordenadas X e Y da janela utilizando o 
# seguinte código no comando Chamar Script (Script Call):
#   $game_system.msg_window_pos = [x, y]
# Substitua x e y pelas coordenadas desejada.
#   Ex: $game_system.msg_window_pos = [150, 150]
#       $game_system.msg_window_pos = [$game_player.screen_x, 50]
#==============================================================================
# ► Instruções: Para ativar o efeito do script basta ativar a switch que você
#   determinará nas configurações abaixo.
#==============================================================================
# ► Configurações
#==============================================================================
module Esteem
    module WM_AutoSize
      
      AS_SWITCH = 1 # Defina o ID da switch desejada
    
    end # WM_AutoSize
  end # Esteem
  #==============================================================================
  # ► Início do Código | Não mude mais nada caso não entenda
  #==============================================================================
  class Window_Message < Window_Base
    
    alias :esteem_msw_oaw :open_and_wait
    def open_and_wait
      @as_switch = $game_switches[Esteem::WM_AutoSize::AS_SWITCH]
      if @as_switch
        text = convert_escape_characters($game_message.all_text)
        set_lines(text)
        self.width = (text_size(major_line).width + (@icons.size * 24)) + (standard_padding * 2) + new_line_x
        self.height = (@lines.size * line_height) + (standard_padding * 2)
        $game_system.msg_window_pos[0] != nil ? self.x = $game_system.msg_window_pos[0] : self.x = (Graphics.width - self.width) * 0.5
        $game_system.msg_window_pos[1] != nil ? self.y = $game_system.msg_window_pos[1] : update_placement
      else
        self.width = window_width
        self.height = window_height
        self.x = 0
        $game_system.msg_window_pos = []
        update_placement
      end
      create_contents
      esteem_msw_oaw
    end
    
    def set_lines(text)
      @lines = []
      text.each_line {|line| @lines.push(line)}
    end
    
    def major_line
      lines_size = []
      @lines.each do |line| 
        @icons = []
        line.scan(/(\ei\[\d+\])/i) {|icon| @icons.push(icon)}
        line.gsub!(/\n/) {""}
        line.gsub!(/(\e\w\[\d+\])/i) {""}
        line.gsub!(/\e\G/i) {""}
        line.gsub!(/\e\$/i) {""}
        line.gsub!(/\e\./i) {""}
        line.gsub!(/\e\{/i) {""}
        line.gsub!(/\e\}/i) {""}
        line.gsub!(/\e\|/i) {""}
        line.gsub!(/\e\!/i) {""}
        line.gsub!(/\e\>/i) {""}
        line.gsub!(/\e\</i) {""}
        line.gsub!(/\e\^/i) {""}
        lines_size.push(line.size)
      end
      @lines[lines_size.index(lines_size.max)]
    end
    
    alias :esteem_asw_up_pl :update_placement
    def update_placement
      esteem_asw_up_pl
      if @as_switch
        pos = [(window_height * 0.5) - (height * 0.5), (Graphics.height * 0.5) - (height * 0.5), (Graphics.height - (window_height * 0.5)) - (height * 0.5)]
        self.y = pos[@position]
      end
    end
    
    alias :esteem_asw_df :draw_face
    def draw_face(face_name, face_index, x, y, enabled = true)
      y = (contents.height - 96) * 0.5 if @as_switch
      esteem_asw_df(face_name, face_index, x, y, enabled = true)
    end
    
  end # Window_Message
  class Game_System
    
    attr_accessor :msg_window_pos
    
    alias :esteem_asw_gs_init :initialize
    def initialize
      esteem_asw_gs_init
      @msg_window_pos = []
    end
    
  end # Game_System