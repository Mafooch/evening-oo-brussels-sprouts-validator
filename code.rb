require "pry"
#########
#CLASSES#
#########
class Ingredients
  # make valid ingredients array a constant and move outside method
  VALID_INGREDIENTS = ["brussels sprouts", "spinach", "eggs", "milk", "tofu",
                      "seitan", "bell peppers", "quinoa", "kale", "chocolate",
                      "beer", "wine", "whiskey"]
  # class method to list safe ingredients
  def self.list_valid_ingredients
    VALID_INGREDIENTS
  end

  def initialize(quantity, unit, name)
    @quantity = quantity.to_f
    @unit = unit
    @name = name
  end

  def self.parse(ingredient_string)
    tokens = ingredient_string.split(" ", 3)
    quantity = tokens[0].to_f
    unit = tokens[1]
    name = tokens[2]

    Ingredients.new(quantity, unit, name)
  end

  def summary
    "#{@quantity} #{@unit} #{@name}"
  end

  def valid_ingredient?
    VALID_INGREDIENTS.include?(@name.downcase)
  end

end

class Recipe
#new recipes take in a string, an array of strings,
# and an array of ingredient objects
  def initialize(name, instructions, ingredients)
    @name = name
    @instructions = instructions
    @ingredients = ingredients
  end

  def list_ingredients
    list = "Ingredients\n"

    @ingredients.each do |ingredient|
      list += "- #{ingredient.summary}\n"
    end

    list
  end

  def list_instructions
    list = "Instructions\n"
    step = 1

    @instructions.each do |instruction|
      list += "#{step}. #{instruction}\n"
      step += 1
    end

    list
  end

  def can_eat?
    @ingredients.all? { |ingredient| ingredient.valid_ingredient? }
  end

  def summary
    summary = "Name: #{@name}\n\n"
    summary += "#{list_instructions}\n#{list_ingredients}\n"
  end

end
#########
#OBJECTS#
#########
ingredients = [Ingredients.new(2, "tsps", "olive oil"),
              Ingredients.new(4, "oz", "chopped pancetta"),
              Ingredients.new(2, "tsps", "minced garlic"),
              Ingredients.new(2.5, "cups", "whipping cream"),
              Ingredients.new(1, "cup", "grated parmesan"),
              Ingredients.new(8, "", "egg yolks"),
              Ingredients.new(0.25, "leaves", "fresh italian parsley"),
              Ingredients.new(1, "lb", "spaghetti"),
              Ingredients.new(4, "cups", "cooked shredded chicken"),
              Ingredients.new(0.5, "cups", "chopped walnuts"),
              Ingredients.new(1, "tbsp", "finely grated lemon peel"),
              Ingredients.new(1, "can", "beer")
]



instructions = [
"Heat the oil in a heavy large frying pan over medium heat. Add
the pancetta and garlic and saute until it is brown and crisp,
about 8 minutes. Cool slightly.",
"In a large bowl, whisk together the cream, cheese, yolks,
basil, and parsley to blend.",
"Meanwhile, bring a large pot of salted water to a boil over
high heat. Add the spaghetti and cook until it is just tender
but still firm to the bite, stirring occasionally, about 10
minutes. Drain.",
"Add the chicken to the pan with the pancetta and stir to
combine. Next, add the spaghetti and the cream mixture and toss
over medium-low heat until the chicken is heated through and the
sauce coats the spaghetti thickly, about 4 minutes (do not boil
or you might end up scrambling the eggs). Season the pasta, to
taste, with pepper and salt if needed (the pancetta will likely
add all the salt you need). Transfer the pasta to a large wide
serving bowl. Sprinkle the walnuts and lemon zest over, and
serve."
]

# initialize new ingredient with alternative constructor 'parse method'
ingredients << Ingredients.parse("47 lb(s) Brussels sprouts")

chicken_carbonara = Recipe.new("Chicken Carbonara", instructions, ingredients)
puts "recipe summary for Chicken Carbonara"
puts chicken_carbonara.summary
puts "Can I eat the recipe?"
puts chicken_carbonara.can_eat?
puts "----------------------------------------------------"

#create a safe recipe using parse method for one of the ingredients
ingredients = [Ingredients.new(1, "fingers", "whiskey"),
              Ingredients.new(2, "tbsp", "chocolate"),
              Ingredients.parse("3.5 cups milk")]
instructions = ["Heat milk and chocolate in a sauce-pan while stirring",
                "Add whiskey",
                "Drink responsibly"]

no_no_juice = Recipe.new("No No Juice", instructions, ingredients)
puts "recipe summary for No No Juice"
puts no_no_juice.summary
puts "Can I eat the recipe?"
puts no_no_juice.can_eat?

puts Ingredients.list_valid_ingredients
