#==============================================================================
# ** SS - Window Modifiers
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Coletânea de todas modificações realizadas nas classes Window_ padrões do
# RPG Maker VXAce.
#==============================================================================
# * Requerimentos:   BitmapEx               (Window_Message Modifiers)
#                    SS - Core              (Window_Message Modifiers)
#                    SS - Game Modifiers    (Window_Message Modifiers)
#==============================================================================

#==============================================================================
# ** Window_Message Modifiers
#------------------------------------------------------------------------------
# * As modificações dessa classe tornam a janela de mensagens compátivel com o 
# novo estilo de mensagem :sss (Seven Souls Style).
#==============================================================================
class Window_Message < Window_Base
  
    #--------------------------------------------------------------------------
    # * Altura da linha
    #--------------------------------------------------------------------------
    def line_height
      return 18
    end
    
    #--------------------------------------------------------------------------
    # * Número de linhas
    #--------------------------------------------------------------------------
    def line_number
      return 3
    end
    
    #--------------------------------------------------------------------------
    # * Calculo para altura da janela
    #     line_number : número de linhas
    #--------------------------------------------------------------------------
    def fitting_height(line_number)
      4 * 24 + standard_padding * 2
    end
    
    #--------------------------------------------------------------------------
    # * Atualização do fundo da janela
    #--------------------------------------------------------------------------
    def update_background
      @background = $game_message.background
      if $game_system.message_style == :sss
        self.opacity = 0
      else
        self.opacity = @background == 0 ? 255 : 0
      end
    end
  
    #--------------------------------------------------------------------------
    # * Definição de quebra de página
    #     text : texto
    #     pos  : posição
    #--------------------------------------------------------------------------
    def new_page(text, pos)
      contents.clear
      @back_sss.dispose if @back_sss
      @face.dispose if @face
      if $game_system.message_style == :sss
        draw_sss_back
        draw_sss_face($game_message.face_name, $game_message.face_index, 0, 0)
        draw_horz_line
        contents.font.size = 22
        contents.font.name = "Lato Light"
        draw_sss_name
      else
        draw_face($game_message.face_name, $game_message.face_index, 0, 0)
      end
      contents.font.name = "Lato"
      contents.font.size = 16
      pos[:x] = new_line_x
      pos[:y] = ((16 * 3) + 24) / 2 
      pos[:new_x] = new_line_x
      pos[:height] = calc_line_height(text)
      clear_flags
    end
    
    #--------------------------------------------------------------------------
    # * Desenho do fundo da mensagem
    #--------------------------------------------------------------------------
    def draw_sss_back
      @back_sss = Sprite.new
      @back_sss.bitmap = Bitmap.new(self.width, self.height)
      rect = Rect.new(0, 8, self.width, self.height - (8 * 2))
      @back_sss.bitmap.fill_rect(rect, Color.new(0, 0, 0, 191))
      @back_sss.y = self.y
      @back_sss.z = self.z - 1
    end
    
    #--------------------------------------------------------------------------
    # * Desenho do gráfico da face em circulo
    #     face_name  : nome do gráfico de face
    #     face_index : índice do gráfico de face
    #     x          : coordenada X
    #     y          : coordenada Y
    #--------------------------------------------------------------------------
    def draw_sss_face(face_name, face_index, x, y)
      rect = Rect.new(face_index % 4 * 96, face_index / 4 * 96, 96, 96)
      @face = Sprite.new
      @face.bitmap = Bitmap.new(96 * 4, 96 * 2)
      @face.src_rect = rect
      @face.x = self.x + standard_padding
      @face.y = self.y + standard_padding
      @face.bitmap.texture_ellipse(Cache.face(face_name), rect.x, rect.y, rect.x + 96, rect.y + 96)
      @face.z = self.z + 1
    end
    
    #--------------------------------------------------------------------------
    # * Desenho de uma linha horzontal
    #--------------------------------------------------------------------------
    def draw_horz_line
      contents.fill_rect(114, 33, 150, 1, line_color)
    end
    
    #--------------------------------------------------------------------------
    # * Aquisção da cor da linha horizontal
    #--------------------------------------------------------------------------
    def line_color
      color = normal_color
      color
    end
    
    #--------------------------------------------------------------------------
    # * Desenho do nome da mensagem
    #--------------------------------------------------------------------------
    def draw_sss_name
      name = $game_system.message_name
      size = text_size(name)
      draw_text(112, 10, size.width, size.height, name)
    end
    
    #--------------------------------------------------------------------------
    # * Alias da disposição
    #--------------------------------------------------------------------------
    alias :ss_wm_dispose :dispose
    def dispose
      ss_wm_dispose
      dispose_sss_contents
    end
    
    #--------------------------------------------------------------------------
    # * Disposição do conteúdo quando o estilo de mensagem é :sss
    #--------------------------------------------------------------------------
    def dispose_sss_contents
      @face.dispose if @face
      @back_sss.dispose if @back_sss
    end
    
    #--------------------------------------------------------------------------
    # * Alias do fechamento da janela
    #--------------------------------------------------------------------------
    alias :ss_wm_close :close
    def close
      dispose_sss_contents
      ss_wm_close
    end
    
  end # Window_Message