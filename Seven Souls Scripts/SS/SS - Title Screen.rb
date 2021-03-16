#==============================================================================
# ** SS - Title Screen
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Esse código executa todos os processos da tela de título do jogo.
#==============================================================================
# * Requerimentos:   SS - Core              (SS_TitleScreen)
#                    SS - Cache Modifiers   (SS_TitleScreen)
#==============================================================================

#==============================================================================
# ** SS_TitleScreen Modifiers
#------------------------------------------------------------------------------
# * Essa classe executa a tela de título do jogo.
#==============================================================================
class SS_TitleScreen < Scene_Base
    include Seven_Souls::Basic_Module
    
    #--------------------------------------------------------------------------
    # * Inicialização do processo
    #--------------------------------------------------------------------------
    def start
      super
      @current_cmd = 0
      create_background
      create_pics
      create_commands
      play_music
      @show_first_effect = true
    end
    
    #--------------------------------------------------------------------------
    # * Criação do plano de fundo
    #--------------------------------------------------------------------------
    def create_background
      @spriteset = Spriteset_Map.new
    end
    
    #--------------------------------------------------------------------------
    # * Criação dos sprites das imagens de fundo (background e logo)
    #--------------------------------------------------------------------------
    def create_pics
      @back = Sprite.new
      @back.bitmap = Cache.title("BG")
      
      @logo = Sprite.new
      @logo.bitmap = Cache.title("LOGO")
      
      @back.opacity = 0 ; @logo.opacity = 0
      @back.z = 200 ; @logo.z = 201
      @back.x = (Graphics.width - @back.width) - 34
      @logo.x = @back.x - 2 ; @logo.y = 5
    end
    
    #--------------------------------------------------------------------------
    # * Criação dos sprites dos comandos 
    #--------------------------------------------------------------------------
    def create_commands
      @commands = []
      Title_Commands.each do |cmd|
        sprite = Sprite.new
        sprite.bitmap = Bitmap.new(@back.width, Title_FSize)
        sprite.bitmap.font.name = Title_FName
        sprite.bitmap.font.size = Title_FSize
        sprite.bitmap.font.shadow = false
        sprite.bitmap.font.outline = false
        rect = Rect.new(0, 0, sprite.width, sprite.height)
        sprite.bitmap.draw_text(rect, cmd, 1)
        sprite.x = @back.x
        y_base = @logo.y + @logo.height + 10
        sprite_spacing = 15
        sprite.y = y_base + ((sprite.height + sprite_spacing) * Title_Commands.index(cmd))
        sprite.z = 201
        sprite.opacity = 0
        @commands.push(sprite)
      end
    end
    
    #--------------------------------------------------------------------------
    # * Execução da música de fundo
    #--------------------------------------------------------------------------
    def play_music
      Seven_Souls::Audio.play_Title
    end
    
    #--------------------------------------------------------------------------
    # * Atualização da tela
    #--------------------------------------------------------------------------
    def update
      super
      update_map
      first_effect if @show_first_effect
      if @all_done
        update_cmd 
        update_act
      end
    end
    
    #--------------------------------------------------------------------------
    # * Atualização do plano de fundo (mapa)
    #--------------------------------------------------------------------------
    def update_map
      $game_map.update(true)
      @spriteset.update
    end
    
    #--------------------------------------------------------------------------
    # * Efeito de fade-in dos sprites
    #--------------------------------------------------------------------------
    def first_effect
      loop do
        Graphics.update
        update_map
        @back.opacity += 5 if @back.opacity < 255
        next unless @back.opacity == 255
        @logo.opacity += 5 if @logo.opacity < 255
        next unless @logo.opacity == 255
        @commands.each do |cmd|
          if @commands.index(cmd) == @current_cmd
            cmd.opacity += 3
          else
            cmd.opacity += 6 if cmd.opacity < 102
          end
        end
        break if @commands[@current_cmd].opacity == 255
      end
      @show_first_effect = false
      @all_done = true
    end
    
    #--------------------------------------------------------------------------
    # * Atualização de movimento dos comandos
    #--------------------------------------------------------------------------
    def update_cmd
      if Input.trigger?(:DOWN) && @current_cmd < 5
        @current_cmd += 1
        change_command(-1)
      elsif Input.trigger?(:UP) && @current_cmd > 0
        @current_cmd -= 1
        change_command(1)
      end
    end
    
    #--------------------------------------------------------------------------
    # * Atualização de confirmação dos comandos
    #--------------------------------------------------------------------------
    def update_act
      if Input.trigger?(:C)
        Seven_Souls::Audio.play_ok
        $game_variables[Title_CVariable] = @current_cmd + 1
        SceneManager.return
      end
    end
    
    #--------------------------------------------------------------------------
    # * Execução da troca de comandos
    #--------------------------------------------------------------------------
    def change_command(val)
      Seven_Souls::Audio.play_cursor
      current = @commands[@current_cmd] 
      old = @commands[@current_cmd + val] 
      loop do
        Graphics.update
        update_map
        current.opacity += 17
        old.opacity -= 17 if old.opacity > 102
        break if current.opacity == 255
      end
    end
    
    #--------------------------------------------------------------------------
    # * Finalização do processo
    #--------------------------------------------------------------------------
    def terminate
      super
      instance_variables.each do |varname|
        ivar = instance_variable_get(varname)
        ivar.dispose if ivar.is_a?(Sprite)
      end
    end
    
  end # SS_TitleScreen