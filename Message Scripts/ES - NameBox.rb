#===============================================================================
# Esteem - NameBox
#-------------------------------------------------------------------------------
# Por: Skyloftian
#===============================================================================
# > Versão 1.1
#-------------------------------------------------------------------------------
# > Atualizações:
#   - 19/09/16 (v1.1) : Incompatibilidade com Window_ChoiceList corrigida
#   - 19/09/16 (v1.0) : Código Otimizado
#   - 18/09/16 (v0.1) : Concluído
#-------------------------------------------------------------------------------
# > Termos de Uso:
#   - O uso é livre em qualquer tipo de projeto.
#   - Os créditos não são obrigatórios, mas sinta-se livre para creditar-me.
#   - O script não deve ser postado em outro lugar, caso deseje isso, favor me
#   contatar antes.
#   - O script pode ser modificado por sua conta e risco, mas não me responsabi-
#   lizo por quaisquer erros que venham a ocorrer posteriormente.
#===============================================================================
# > Função:
#   - Este script exibe uma caixa de nome (seja do personagem que está falando
#   ou o que você quiser) juntamente da caixa de mensagens.
#-------------------------------------------------------------------------------
# > Instruções:
#   - O script exibe automaticamente a caixa de nome quando a switch configurada
#   estiver ON. Ou seja, ela não aparecerá caso a switch esteja OFF.
#   - O nome que aparecerá na janela é definido por meio de uma variável que
#   pode ser configurada logo abaixo. 
#   - Para definir o nome que deve aparecer, vá em Controle de Variáveis e a 
#   configure da seguinte maneira:
#
# #----------------------------------------------------------------------------#
# | #CONTROLE DE VARIÁVEIS#                                                    |
# |  Variável                                                                  |
# |    (O) Indivídual : [ID da Variável Configurada]                           |
# |    ( ) Lote : [      ]  ~  [      ]                                        |
# |  Operação                                                                  |
# |    (O) Definir ( ) Somar ( ) Subtrair ( ) Multiplicar ( ) Dividir ( ) Resto|
# |  Operando                                                                  |
# |    ( ) Constante   [      ]                                                |
# |    ( ) Variável    [              ]                                        |
# |    ( ) Aleatório   [      ]  ~  [      ]                                   |
# |    ( ) Dados do    [                        ]                              |
# |        Jogo                                                                |
# |    (O) Script      ["Nome"                  ]                              |
# #----------------------------------------------------------------------------#
#
#   De maneira em que:
#   ID da Variável Configurada = ID de uma variável que você deve configurar
#                                logo abaixo, na aba Configurações.
#   "Nome"                     = O nome que deve aparecer dentro da janela. 
#                                OBS: Não se esqueça das aspas.
#
#   - Para exibir o nome de algum personagem da party, use o seguinte comando:
#     $game_actors[ID].name 
#     Sendo ID o número do personagem no DataBase.
#
#   - Para mudar a posição(alinhamento) da caixa de nome, basta mudar o valor 
#    da variável definida para isso. 
#     Os valores podem ser: 0 - Esquerda  ||  1 - Centro  ||  2 - Direita
#     OBS: Caso a variável receba qualquer outro valor a janela se alinhará au-
#    tomaticamente na esquerda.
#   - A caixa de nome se ajusta automaticamente a posição da janela de mensagem
#    seja na parte inferior, no meio, ou na parte superior da tela.
#===============================================================================
# > Dúvidas e afins? Acesse: www.centrorpg.com
#===============================================================================
module Esteem
    module NameBox
      #===========================================================================
      # > Configurações:
      #   - Aqui você encontrará todas as configurações que podem ser realizadas
      #   no script.
      #---------------------------------------------------------------------------
      
      # > Configurações da Janela e Texto:
    
          NB_WINDOWSKIN        = "Window"     # Windowskin da NameBox.
          
          NB_FONT_NAME         = "VL Gothic"  # Fonte do texto/nome.
          NB_FONT_SIZE         = 23           # Tamanho da fonte.
          NB_BOLD              = false        # O nome deve estar em negrito?
                                              # true = sim  || false = não
          NB_ITALIC            = false        # O nome deve estar em itálico?
                                              # true = sim  || false = não
          NB_SHADOW            = true         # O nome deve ter sombra?
                                              # true = sim  || false = não
          NB_COLOR             = Color.new(255, 255, 255 , 255) 
          # Cor do nome = (R  , G    , B   , A)
          #               (Red, Green, Blue, Opacity)
          # Cor padrão  = (255, 255, 255 , 255)
          
      # > Configurações de Switch e Variáveis de Controle:
      
           ON_SWITCH           = 01           # Switch que ativa ou desativa a
                                              # namebox.
           NAME_VAR            = 01           # Variável que carregará o nome
                                              # que será exibido na namebox.
           POS_VAR             = 02           # Variável que define a posição(ali-
                                              # nhamento) da namebox.
                                              
    end #NameBox
  end #Esteem
  #===============================================================================
  # > Fim das Configurações
  #   - Aqui termina a área configurável do script e começa o código. Não recomen-
  #   do que o altere, isso é, a menos que tenha certeza do que está fazendo.
  #   - Caso seja destemido o suficiente para ignorar meus alertas e decida alte-
  #   rar algo no código, aviso logo para que tome cuidado com os updates, pois
  #   como ele é vindo do Scene_Map, sobrecarrega-lo pode causar lag absurdo du-
  #   rante o jogo, de forma que seja praticamente impossível sobreviver a ele.
  #===============================================================================
  
  #=============================================================
  # > Window_NameBox
  #=============================================================
  class Window_NameBox < Window_Base
    
    #---------------------------------------------------------
    # ~ Inicialização do objeto
    #---------------------------------------------------------
    def initialize
      super(0, 0, width, 50)
      self.z = 201
      self.openness = 0
      window_windowskin
      window_contents_config
    end
    
    #---------------------------------------------------------
    # ~ Aquisição da largura da janela
    #---------------------------------------------------------  
    def width
      return 150
    end
    
    #---------------------------------------------------------
    # ~ Aquisição da windowskin
    #---------------------------------------------------------
    def window_windowskin
      self.windowskin = Cache.system(Esteem::NameBox::NB_WINDOWSKIN)
    end
    
    #---------------------------------------------------------
    # ~ Aquisição das configurações do texto da janela
    #---------------------------------------------------------
    def window_contents_config
      self.contents.font.name   = Esteem::NameBox::NB_FONT_NAME
      self.contents.font.size   = Esteem::NameBox::NB_FONT_SIZE
      self.contents.font.bold   = Esteem::NameBox::NB_BOLD
      self.contents.font.italic = Esteem::NameBox::NB_ITALIC
      self.contents.font.shadow = Esteem::NameBox::NB_SHADOW
      self.contents.font.color  = Esteem::NameBox::NB_COLOR
    end
    
    #---------------------------------------------------------
    # ~ Atualização da janela e definição de x e y
    #---------------------------------------------------------
    def update_window(message_y, message_height)
      update_openness
      define_name
      draw_name
      num = Esteem::NameBox::POS_VAR
      self.x = 0 if $game_variables[num] == 0
      self.x = Graphics.width / 2 - 75 if $game_variables[num] == 1
      self.x = Graphics.width - 150 if $game_variables[num] == 2
      self.y = message_y - self.height if $game_message.position != 0
      self.y = message_height if $game_message.position == 0
    end
    
    #---------------------------------------------------------
    # ~ Abrir e fechar janela
    #---------------------------------------------------------
    def update_openness
    open if $game_message.busy? && $game_switches[Esteem::NameBox::ON_SWITCH]
    close if !$game_message.busy? || !$game_switches[Esteem::NameBox::ON_SWITCH]
    end
  
    #---------------------------------------------------------
    # ~ Aquisição do nome
    #---------------------------------------------------------
    def define_name
      name = Esteem::NameBox::NAME_VAR
      @name = $game_variables[name]
    end
    
    #---------------------------------------------------------
    # ~ Desenhar nome da janela
    #---------------------------------------------------------
    def draw_name
      contents.clear
      draw_text(0, 0, 150 - (self.padding * 2), 50 - (self.padding * 2), @name, 1)
    end
    
  end # NameBox
  
  #=============================================================
  # > Scene_Map
  #=============================================================
  class Scene_Map < Scene_Base
    
    #---------------------------------------------------------
    # ~ Adicionar namebox na Scene_Map
    #---------------------------------------------------------
    alias :create_nb :create_all_windows
    def create_all_windows
      create_nb
      create_namebox
    end
    
    #---------------------------------------------------------
    # ~ Criar namebox
    #---------------------------------------------------------
    def create_namebox
      @namebox = Window_NameBox.new
    end
    
    #---------------------------------------------------------
    # ~ Adicionar a namebox ao update da Scene_Map
    #---------------------------------------------------------
    alias :nep_date :update
    def update
      nep_date
      @namebox.update_window(@message_window.y, @message_window.height)
    end
    
  end #Scene_Map
  
  #===============================================================================
  # > Nota:
  #   - Ajuste na posição da janela de esclhas quando a NameBox está posicionada
  #   na direita da tela.
  #   - Caso o posicionamento da janea de escolhas não lhe agrade, você pode es-
  #   ar tentando a sorte e a modificando a seu gosto. 
  #   - Entretanto, como avisado lá em cima, não me responsabilizo por qualquer 
  #   erro durante a modificação do código, tome cuidado, fica a dica.
  #===============================================================================
  
  #=============================================================
  # > Window_ChoiceList
  #=============================================================
  class Window_ChoiceList < Window_Command
  
    #--------------------------------------------------------------------------
    # ~ Subscrever o método que atualiza a posição y da janela de escolhas
    #--------------------------------------------------------------------------
    alias :new_up :update_placement
    def update_placement
      new_up
      @namebox = Window_NameBox.new
      var = Esteem::NameBox::POS_VAR
      swi = Esteem::NameBox::ON_SWITCH
      if $game_variables[var] == 2 && $game_switches[swi]
        if $game_message.position == 2
          self.y = @message_window.y - height - 50
        elsif $game_message.position == 0
          self.y = @message_window.y + @message_window.height + 50
        else
          self.y = @message_window.y + @message_window.height
        end
      end
    end
    
  end # Window_ChoiceList