#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ✦ Esteem System - Add Shop in Menu
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Esse script adiciona a loja ao menu.
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Autor: Dromarch (Skyloftian)
# Site: dromarch.github.io | Acess: https://github.com/Dromarch/EsteemSystem-VXAce
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ➛ Versões: 1.0 (03/08/18) - Criado e publicado
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
      :waepons => [1, 2, 3, 4, 5],
      # Lista de armaduras
      :armors  => [1, 2, 3],
      
      } # Não apague!
      
  #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # ➛ Fim das configurações.
  #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    end # ASIM
  end # Esteem
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
      Esteem::ASIM::ShopList.each do |key, val|
        case key
        when :items
          val.each {|item| goods.push([0, item, 0])}
        when :waepons
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