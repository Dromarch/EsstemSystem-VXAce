#===============================================================================
# Esteem - Menu More Options Window
#===============================================================================
# Por: Skyloftian
#===============================================================================
# > Versão 1.0
#-------------------------------------------------------------------------------
# > Atualizações:
#   - 26/12/16 (v1.0) : Concluído
#-------------------------------------------------------------------------------
# > Termos de Uso:
#   - O uso é livre em qualquer tipo de projeto.
#   - Os créditos não são obrigatórios, mas sinta-se livre para creditar-me.
#   - O script não deve ser postado em outro lugar, caso deseje isso, favor me
#   contatar antes.
#   - O script pode ser modificado por sua conta e risco, mas não me responsabi-
#   lizo por quaisquer erros que venham a ocorrer posteriormente.
#-------------------------------------------------------------------------------
# > Notas:
#   - O script foi feito sob encomenda do membro 357.
#===============================================================================
# > Função:
#   - Este script cria uma nova cena no menu principal do jogo, mostrando mais
#   opções.
#-------------------------------------------------------------------------------
# > Instruções:
#   - Para que tudo funcione corretamente é preciso configurar a parte configurá-
#   vel do código.
#   - As configurações serão explicadas detalhadamente mais abaixo, ao lado de 
#   cada ponto a ser configurado.
#===============================================================================
# > Dúvidas e afins? Acesse: www.centrorpg.com
#===============================================================================
module Esteem
    module Options
      
      #===========================================================================
      # > Configurações:
      #   - Aqui você encontrará todas as configurações que podem ser realizadas
      #   no script.
      #---------------------------------------------------------------------------
      
      # > Configurações básicas:
      
      OPTIONS_NAME = "Opções"     # Termo a aparecer no menu principal que abri-
                                  # rá a nova cena com opções a se selecionar.
                                  
      OPTIONS = { # Não apague!!!
      
    # "Termo"     => [Key, ID],
    # "Termo" = Palavra a aparecer no menu.
    #     Key = Chave que será usada para que o script identifique a qual cena 
    #           pertence cada configuração. 
    #           Não deve ser 0. Recomendo que siga uma ordem crescente para que
    #           não se confunda. Ex: (1, 2, 3...)
    #      ID = ID da Switch para ativar/desativar a opção. 
    #           Coloque 0 para não útilizar uma switch e a opção estar sempre ati-
    #           vada.
    
    # Exemplo:
    
    # "Bestiário" => [1, 1],
      
      "Cena 01"   => [1, 0],      
      
      "Cena 02"   => [2, 5],
        
                } # Não apague!!!
      
      # > Configurações das cenas:
      
      # Está configuração é obrigatória e exigirá um pouco de conhecimento de sua
      # parte quanto as cenas que deseja chamar através das opções.
      # Você deverá saber o nome da cena para chamá-la. 
      # Seu nome geralmente vem informada nos scripts como a maneira que você deve
      # chamá-la através de Script Call(Chamar Script), entretando isso não é ga-
      # rantido.
      
      def scene_call(scene_key) # Não apague!!!
        if scene_key == 0       # Não apague!!!
          
      # elsif scene_key == Key
      #   SceneManager.call(Nome_da_Cena)
      
      # Na primeira linha você deve substituir Key pelo número colocado na Key das
      # configurações acima correspondente a cema em questão.
      
      # Na segunda linha você deve substituir Nome_da_Cena pelo nome da cena en 
      # questão.
      
      # Lembre-se que Key e Nome_da_Cena devem se corresponder.
  
      # Exemplo:
      
      # elsif scene_key == 1
      #   SceneManager.call(Scene_MonsterBook)
      
        elsif scene_key == 1
          SceneManager.call(Cena_01)
          
        elsif scene_key == 2
          SceneManager.call(Cena_02)
          
        end # if
      end # def
      
      # O script é razoavelmente simples, porém suas configurações podem parecer
      # um pouco complexas quando não se entende exatamente como elas funcionam.
      # Mesmo assim, é fácil configurá-lo e é possível adicionar quantas opçoões
      # desejar.
      # Para adicionar novas opções basta apenas repetir os processos ensinados 
      # acima.
      
    end # Options
  end # Esteem
  #===============================================================================
  # > Fim das Configurações
  #   - Aqui termina a área configurável do script e começa o código. Não recomen-
  #   do que o altere, isso é, a menos que tenha certeza do que está fazendo.
  #===============================================================================
  
  #=============================================================
  # > Window_Options < Window_MenuCommand
  #=============================================================
  class Window_Options < Window_MenuCommand
    include Esteem::Options
    
    #---------------------------------------------------------
    # ~ Iitialize
    #---------------------------------------------------------
    def initialize
      super
      select_last
    end
  
    #---------------------------------------------------------
    # ~ Window_Width
    #---------------------------------------------------------
    def window_width
      return 160
    end
    
    #---------------------------------------------------------
    # ~ Window_Height
    #---------------------------------------------------------
    def window_height
      if fitting_height(visible_line_number) > 360
        return 360
      else
        fitting_height(visible_line_number)
      end
    end
    
    #---------------------------------------------------------
    # ~ Visible_Line_Number
    #---------------------------------------------------------
    def visible_line_number
      item_max
    end
  
    #---------------------------------------------------------
    # ~ Make_Command_List
    #---------------------------------------------------------
    def make_command_list
      OPTIONS.each do |opt, key|
        add_command(opt, opt.to_sym, enable_this(key[1]))
      end
    end
    
    #---------------------------------------------------------
    # ~ Enable_This
    #---------------------------------------------------------
    def enable_this(switch_id)
      if switch_id <= 0
        return true
      else
        $game_switches[switch_id]
      end
    end
  
  end # Window_Options
  #=============================================================
  # > Window_MenuCommand < Window_Command
  #=============================================================
  class Window_MenuCommand < Window_Command  
    include Esteem::Options
    
    #---------------------------------------------------------
    # ~ Add_Main_Commands
    #---------------------------------------------------------
    alias :add_new_command :add_main_commands
    def add_main_commands
        add_new_command
        add_command(OPTIONS_NAME, :options, main_commands_enabled)
    end
      
  end # Window_MenuCommand  
  #=============================================================
  # > Scene_Menu < Scene_MenuBase
  #=============================================================
  class Scene_Menu < Scene_MenuBase
    include Esteem::Options
      
    #---------------------------------------------------------
    # ~ Create_Command_Window
    #---------------------------------------------------------
     alias :new_command :create_command_window
     def create_command_window
         new_command
         @command_window.set_handler(:options, method(:command_options))
     end
     
    #---------------------------------------------------------
    # ~ Command_Options
    #---------------------------------------------------------
     def command_options
       SceneManager.call(Scene_MenuOptions)
     end
     
   end # Scene_Menu
  #=============================================================
  # > Scene_MenuOptions < Scene_MenuBase
  #=============================================================
  class Scene_MenuOptions < Scene_MenuBase
    include Esteem::Options
    
    #---------------------------------------------------------
    # ~ Start
    #---------------------------------------------------------
    def start
      super
      create_options_window
      create_status_window
      create_gold_window
    end
    
    #---------------------------------------------------------
    # ~ Create_Gold_Window
    #---------------------------------------------------------
    def create_gold_window
      @gold_window = Window_Gold.new
      @gold_window.x = 0
      @gold_window.y = Graphics.height - @gold_window.height
    end
  
    #---------------------------------------------------------
    # ~ Create_Status_Window
    #---------------------------------------------------------
    def create_status_window
      @status_window = Window_MenuStatus.new(@options_window.width, 0)
    end
    
    #---------------------------------------------------------
    # ~ Create_Options_Window
    #---------------------------------------------------------
    def create_options_window
      @options_window = Window_Options.new
      OPTIONS.each_key do |opt|
        @options_window.set_handler(opt.to_sym, method(:scene_caller))
      end
      @options_window.set_handler(:cancel,    method(:return_scene))
    end
     
    #---------------------------------------------------------
    # ~ Scene_Caller
    #---------------------------------------------------------
    def scene_caller
      @actual_slct = @options_window.current_symbol
      OPTIONS.each do |key, opt|
        case key.to_sym
        when @actual_slct
          scene_call(opt[0])
        end
      end
    end
    
  end # Scene_MenuOptions