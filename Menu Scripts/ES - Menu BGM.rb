#==============================================================================
# ** Esteem [Código Rápido] - Menu BGM
#------------------------------------------------------------------------------
# Script por: Skyloftian
#==============================================================================
# Esse é um código simples para executar uma BGM no menu.
#------------------------------------------------------------------------------
# Atualizações: 23/05/18 v1.0 Concluído
#==============================================================================
module Esteem
    module Menu_BGM
    #============================================================================
    # ► Configurações
    #============================================================================
      BGM_NAME = "Field3"  # Nome da BGM
      BGM_VOL   = 100      # Volume da BGM
      BGM_PITCH = 100      # Pitch da BGM
    #============================================================================
    # ► Fim das Configurações | Não mude mais nada caso não entenda
    #============================================================================
      def self.save_bgm_and_bgs
        @map_bgm = RPG::BGM.last
        @map_bgs = RPG::BGS.last
      end
      
      def self.replay_bgm_and_bgs
        @map_bgm.replay unless $BTEST
        @map_bgs.replay unless $BTEST
      end
      
      def self.return_bgm
        return @map_bgm
      end
      
      def self.return_bgs
        return @map_bgs
      end
      
    end # Menu_BGM
  end # Esteem
  class Scene_Menu < Scene_MenuBase
    
    def pre_terminate
      super
      Esteem::Menu_BGM.replay_bgm_and_bgs if SceneManager.scene_is?(Scene_Map)
    end
  
  end # Scene_Menu
  class Scene_Map < Scene_Base
    
    alias :mbgm_sm_pre_terminate :pre_terminate
    def pre_terminate
      mbgm_sm_pre_terminate
      pre_menu_scene if SceneManager.scene_is?(Scene_Menu)
    end
    
    def pre_menu_scene
      Esteem::Menu_BGM.save_bgm_and_bgs
      bgm_name  = Esteem::Menu_BGM::BGM_NAME
      bgm_vol   = Esteem::Menu_BGM::BGM_VOL
      bgm_pitch = Esteem::Menu_BGM::BGM_PITCH
      RPG::BGM.new(bgm_name, bgm_vol, bgm_pitch).play
      RPG::BGS.stop
    end
    
  end # Scene_Map
  class Game_System
    
    def on_before_save
      @save_count += 1
      @version_id = $data_system.version_id
      @frames_on_save = Graphics.frame_count
      @bgm_on_save = Esteem::Menu_BGM.return_bgm
      @bgs_on_save = Esteem::Menu_BGM.return_bgs
    end
    
  end # Game_System