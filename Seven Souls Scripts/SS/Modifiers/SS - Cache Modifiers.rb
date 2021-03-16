#==============================================================================
# ** SS - Cache Modifiers
#------------------------------------------------------------------------------
# Coleção SS por: *Author
#==============================================================================
# * Coletânea de todas modificações realizadas no módulo Cache padrão do RPG
# Maker VXAce.
#==============================================================================
# * Requerimentos:   ---
#==============================================================================

#==============================================================================
# ** Cache Modifiers
#------------------------------------------------------------------------------
# * As modificações desse módulo implementam novos métodos de carregamento de
# gráficos que são utilizados pelos demais códigos SS.
#==============================================================================
module Cache
  
    #--------------------------------------------------------------------------
    # * Carregamento dos gráficos da tela de título
    #     filename : nome do arquivo
    #--------------------------------------------------------------------------
    def self.title(filename)
      load_bitmap("Graphics/Title/", filename)
    end
    
    #--------------------------------------------------------------------------
    # * Carregamento dos gráficos do menu
    #     filename : nome do arquivo
    #--------------------------------------------------------------------------
    def self.menu(filename)
      load_bitmap("Graphics/Menu/", filename)
    end
    
  end # Cache