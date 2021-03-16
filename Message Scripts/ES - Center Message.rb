#==============================================================================
#  ** Esteem - Center Message
#==============================================================================
# ► Script por: Skyloftian
#------------------------------------------------------------------------------
# ► Atualizações: 22/06/18 - v1.0 - Código finalizado e revisado
#==============================================================================
# ► Descrição: Possibilita centralizar o texto da janela de mensagens.
#
# * O código identifica e ignora os caracteres de todos os comandos de mensagem
#	fazendo com que a centralização do texto seja perfeita, mesmo possuindo em 
#   sua composições caracteres que não são mostrados na mensagem final.
#   Ex:\c[n], \., \$, etc...
#==============================================================================
# ► Instruções: Para ativar o efeito do script basta ativar a switch que você
#   determinará nas configurações abaixo.
#==============================================================================
# ► Configurações
#==============================================================================
module Esteem
    module CenterMessage
      
      CM_SWITCH = 1 # Defina o ID da siwtch desajada
    
    end # CenterMessage
  end # Esteem
  #==============================================================================
  # ► Início do Código | Não mude nada caso não entenda
  #==============================================================================
  class Window_Message < Window_Base
    
    alias :esteem_cm_new_page :new_page
    def new_page(text, pos)
      esteem_cm_new_page(text, pos)
      if $game_switches[Esteem::CenterMessage::CM_SWITCH]
        @text_lines = []
        @icon = 0
        @line = 0
        pos[:x] = calc_text_to_center_x(text, @line)
        pos[:y] = calc_text_to_center_y(@text_lines.size)
      end
    end
    
    alias :esteem_cm_process_new_line :process_new_line
    def process_new_line(text, pos)
      if $game_switches[Esteem::CenterMessage::CM_SWITCH]
        @line += 1
        pos[:new_x] = calc_text_to_center_x(text, @line) if @text_lines.size > 1
      end
      esteem_cm_process_new_line(text, pos)
    end
    
    def calc_text_to_center_x(text, line)
      text.each_line {|line| insert_line(line)}
      x_pos = (((self.width - (standard_padding * 2)) - @text_lines[line]) / 2)
      return x_pos
    end
    
    def calc_text_to_center_y(line)
      y_pos = (((self.height - (standard_padding * 2)) - (line * line_height)) / 2)
      return y_pos
    end
    
    def insert_line(line)
      line.scan(/(\ei\[\d+\])/i) {|icon| @icon += 1}
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
      size = text_size(line).width + (@icon * 24)
      @text_lines.push(size)
    end
    
  end # Window_Message