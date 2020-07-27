#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ✦ Esteem System - Add Shop in Menu
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Esse script adiciona a loja ao menu.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Autor: Dromarch (Skyloftian)
# Site: dromarch.github.io | Acess: https://github.com/Dromarch/EsteemSystem-VXAce
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Versões: 2.0 (04/08/18) - Adicionado comando para alteração da lista de itens da loja
# ➛ Versões: 1.0 (03/08/18) - Criado e publicado
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Instruções
#   Utilize set_menu_shop([id_item], [id_weapon], [id_armor]) através do comando Chamar Script 
# para alterar a lista de itens da loja do menu.
# * id_item = ID dos itens disponíveis
# * id_weapon = ID das armas disponíveis
# * id_armor = ID das armaduras disponíveis
#
# ➛ Exemplos
# set_menu_shop([1, 2, 5], [1, 2], [5])
# set_menu_shop([1, 3], [], [0])
#
# ➛ Observações
#   Deixar os colchetes vazios fará com que a lista antiga da respectiva categoria seja 
# mantida.
#   Inserir apenas o valor 0 dentro dos colchetes fará com que a lista respectiva fique
# vazia. 
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
module Esteem
  module ASIM
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Configurações
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    ShopName   = "Loja"    # Nome do comando da loja no menu
    ShopSwitch = 01        # Switch para ativar ou desativar o comando no menu
    
    # Defina aqui a lista de itens disponíveis na loja do menu
    # A definição é feita utilizando o ID do item no Banco de Dados
    ShopList = { # Não apague!
    
    # Lista de itens
    :items   => [1, 2, 3, 4, 5],
    # Lista de armas
    :weapons => [1, 2, 3, 4, 5],
    # Lista de armaduras
    :armors  => [1, 2, 3],
    
    } # Não apague!
    
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Fim das configurações.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  end # ASIM
end # Esteem
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Game_System
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Game_System
  
  attr_accessor :menu_shop_list
  
  alias e_asim_init initialize
  def initialize
    e_asim_init
    @menu_shop_list = Esteem::ASIM::ShopList
  end
  
end # Game_System
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Game_Interpreter
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Game_Interpreter
  
  def set_menu_shop(*args)
    $game_system.menu_shop_list[:items] = args[0] if !args[0].empty?
    $game_system.menu_shop_list[:weapons] = args[1] if !args[1].empty?
    $game_system.menu_shop_list[:armors] = args[2] if !args[2].empty? 
  end
  
end # Game_Interpreter
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Scene_Menu
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Scene_Menu < Scene_MenuBase
  
  alias e_asim_ccw create_command_window
  def create_command_window
    e_asim_ccw
    @command_window.set_handler(:shop,      method(:command_shop))
  end
  
  def command_shop
    goods = []
    $game_system.menu_shop_list.each do |key, val|
      case key
      when :items
        val.each {|item| goods.push([0, item, 0])}
      when :weapons
        val.each {|item| goods.push([1, item, 0])}
      when :armors
        val.each {|item| goods.push([2, item, 0])}
      end
    end
    SceneManager.call(Scene_Shop)
    SceneManager.scene.prepare(goods, true)
  end
  
end # Scene_Menu
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Window_MenuCommand
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Window_MenuCommand < Window_Command
  
  alias e_asim_mcl make_command_list
  def make_command_list
    e_asim_mcl
    add_shop_command
  end
  
  def add_shop_command
    add_command(Esteem::ASIM::ShopName, :shop, shop_enabled)
  end
  
  def shop_enabled
    Esteem::ASIM::ShopSwitch == 0 ? true : $game_switches[Esteem::ASIM::ShopSwitch]
  end
  
end # Window_MenuCommand