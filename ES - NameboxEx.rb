#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ✦ Esteem System - NameboxEx
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Esse script exibe uma caixa de nome durante as mensagens.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Autor: Dromarch (Skyloftian)
# Site: dromarch.github.io | Acess: https://github.com/Dromarch/EsteemSystem-VXAce
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Versões: 1.0 (16/07/18) - Criado e publicado
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Instruções:
# Os comandos devem ser utilizados através do Chamar Script (Script Call).
#   ▪ enbex_switch         - Ativa ou desativa a Namebox.
#   ▪ enbex_name("name")   - Define o nome exibido na Namebox,
#   ▪ embex_pos(pos)       - Define a posição do eixo X da Namebox.
# "name" é o nome que será exibido na Namebox. (Deve estar dento de aspas.)
# pos é a posição do eixo X (horizontal) da Namebox. Sendo 0 = Esuqerda
# 1 = Centro e 2 = Direita. Valores diferentes destes serão ignorados.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Não existem configurações a serem feitas.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$imported = {} if $imported.nil?
$imported["Esteem System - NameboxEx"] = true
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Game_System
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Game_System
  
  attr_accessor :enbex_data
  
  alias e_nbex_gs_i initialize
  def initialize
    e_nbex_gs_i
    @enbex_data = {
    :switch => false,
    :name => "",
    :pos => 0
    }
  end
  
end # Game_System

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Game_Interpreter
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Game_Interpreter
  
  def enbex_switch
    $game_system.enbex_data[:switch] ? 
    $game_system.enbex_data[:switch] = false : 
    $game_system.enbex_data[:switch] = true
  end
  
  def enbex_name(name)
    $game_system.enbex_data[:name] = name.to_s
  end
  
  def enbex_pos(pos)
    $game_system.enbex_data[:pos] = pos
  end
  
end # Game_Interpreter

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Window_NameboxEx
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Window_NameboxEx < Window_Base
  
  def initialize(message_window)
    @message_window = message_window
    super(0, 0, 160, fitting_height(1))
    self.z = 200
    self.openness = 0
  end
  
  def open
    refresh
    super
  end

  def draw_contents
    x = (contents_width - text_size(@name).width) / 2
    y = (contents_height - text_size(@name).height) / 2
    draw_text_ex(x, y, @name)
  end
  
  def update_placement
    i = $game_system.enbex_data[:pos]
    self.width = [text_size(@name).width, 160].max + padding * 2
    self.x = [0, (Graphics.width - width) / 2, Graphics.width - width][i] if i < 3
    if @message_window.y != 0
      self.y = @message_window.y - height
    else
      self.y = @message_window.y + @message_window.height
    end
  end

  def refresh
    @name = $game_system.enbex_data[:name]
    update_placement
    create_contents
    contents.clear
    draw_contents
  end
  
end # Window_NameboxEX

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Window_Message
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Window_Message < Window_Base
  
  alias e_nbex_wm_callw create_all_windows
  def create_all_windows
    e_nbex_wm_callw
    @namebox_ex_window = Window_NameboxEx.new(self)
  end
  
  alias e_nbex_wm_oandw open_and_wait
  def open_and_wait
    @namebox_ex_window.open if $game_system.enbex_data[:switch]
    e_nbex_wm_oandw
  end
  
  alias e_nbex_wm_candw close_and_wait
  def close_and_wait
    @namebox_ex_window.close
    e_nbex_wm_candw
  end

  alias e_nbex_wm_uallw update_all_windows
  def update_all_windows
    e_nbex_wm_uallw
    @namebox_ex_window.update
  end
  
  alias e_nbex_wm_dallw dispose_all_windows
  def dispose_all_windows
    e_nbex_wm_dallw
    @namebox_ex_window.dispose
  end
  
end # Window_Message