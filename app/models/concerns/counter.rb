module Counter
  extend ActiveSupport::Concern

  def increment_guess_counter
    self.guesses += 1
    self.save!
  end

  def increment_match_counter
    self.matches += 1
    self.save!
  end
end