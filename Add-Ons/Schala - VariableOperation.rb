#===============================================================================
# Schala::VariableOperation
#-------------------------------------------------------------------------------
# Por: Skyloftian
#===============================================================================
# > Função:
#   - Este script é um add-on ao Schala Battle System que adiciona a opção de
#   adicionar ou remover um valor de uma variável ao derrotar um inimigo.
#-------------------------------------------------------------------------------
# > Instruções:
#   - Para fazer a operação, é necessário adicionar o seguinte código na
#   caixa de notas do inimigo:
#
#   <Variable Operation = id, ope, value>
#
#   De maneira em que:
#   id     = ID da variável
#   ope    = Operação a ser realizada (1 para adição e 2 para subtração)
#   value  = Valor a se adicionar ou remover
#
#   - Exemplo de uso:
#   <Variable Operation = 5, 1, 1>   # Adiciona 1 a variável 5
#   <Variable Operation = 1, 2, 3>   # Remove 3 da variável 1
#
#   - É só isso.
#===============================================================================

#=============================================================
# > Schala_Battle
#=============================================================         
module Schala_Battle
  
    #---------------------------------------------------------
    # ~ Execute Variable Operation
    #---------------------------------------------------------
    def execute_variable_operation(enemy)        
      enemy.note  =~ /<Variable Operation = (\d+), (\d+), (\d+)>/      
      variable_id = $1.to_i
      operation = $2.to_i
      value = $3.to_i
      if variable_id != nil
        if operation == 1
          $game_variables[variable_id] += value
          $game_map.need_refresh = true     
        elsif operation == 2
          $game_variables[variable_id] -= value
          $game_map.need_refresh = true   
        end
      end
    end
    
  end # Schala_Battle
  #=============================================================
  # > Game_Character < Game_CharacterBase
  #=============================================================      
  class Game_Character < Game_CharacterBase
  
    #---------------------------------------------------------
    # ~ Execute Enemy Defeated Process
    #---------------------------------------------------------
    alias :new_ope :execute_enemy_defeated_process
    def execute_enemy_defeated_process
      enemy = $data_enemies[self.battler.enemy_id]
      execute_variable_operation(enemy)
      new_ope
    end    
       
    #---------------------------------------------------------
    # ~ Execute Enemy Defeated On Field
    #---------------------------------------------------------
    alias :new_ope_new :execute_enemy_defeated_on_field
    def execute_enemy_defeated_on_field
      enemy = $data_enemies[self.battler.enemy_id]
      execute_variable_operation(enemy)
      new_ope_new
    end
    
  end # Game_Character