class CreateDomain < ActiveRecord::Migration[8.1]
 def change
create_table(:recipes){|t|t.string :title,null:false,limit:120}
add_index :recipes,:title,unique:true
create_table(:ingredients){|t|t.string :name,null:false,limit:40;t.string :allergen,limit:40}
add_index :ingredients,:name,unique:true
create_table(:recipe_ingredients){|t|t.references :recipe,null:false,foreign_key:true;t.references :ingredient,null:false,foreign_key:true}
add_index :recipe_ingredients,[:recipe_id,:ingredient_id],unique:true
 end
end
