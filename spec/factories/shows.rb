# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :show do
    name "The Best Show Ever"
    tmdb_id 666

    factory :real_show do
      name "Battlestar Galactica"
      creator "Ronald D. Moore"
      episode_length 44
      first_air_date "2005-01-14"
      last_air_date "2009-03-20"
      status "Ended"
      seasons_count 4
      episodes_count 74
      tmdb_id 1972
      overview "Battlestar Galactica is an American military science fiction television series, and part of the Battlestar Galactica franchise. The show was developed by Ronald D. Moore as a re-imagining of the 1978 Battlestar Galactica television series created by Glen A. Larson. The story arc of Battlestar Galactica is set in a distant star system, where a civilization of humans live on a group of planets known as the Twelve Colonies. In the past, the Colonies had been at war with a cybernetic race of their own creation, known as the Cylons. With the unwitting help of a human named Gaius Baltar, the Cylons launch a sudden sneak attack on the Colonies, laying waste to the planets and devastating their populations. Out of a population numbering in the billions, only approximately 50,000 humans survive, most of whom were aboard civilian ships that avoided destruction. Of all the Colonial Fleet, the eponymous Battlestar Galactica appears to be the only military capital ship that survived the attack. Under the leadership of Colonial Fleet officer Commander William \"Bill\" Adama and President Laura Roslin, the Galactica and its crew take up the task of leading the small fugitive fleet of survivors into space in search of a fabled refuge known as Earth."
    end

    factory :fake_show do
      name "The Worst Show Ever"
      tmdb_id 90909090
    end
  end
end
