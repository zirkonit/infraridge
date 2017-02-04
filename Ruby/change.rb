class Register
  attr_accessor :state
  VALUES = [20, 10, 5, 2, 1]

  def initialize
    @state = [0, 0, 0, 0, 0]
  end

  def total
    @state[0]*VALUES[0] + @state[1]*VALUES[1] + @state[2]*VALUES[2] + @state[3]*VALUES[3] + @state[4]*VALUES[4]
  end

  def show
    puts "$#{total} #{@state[0]} #{@state[1]} #{@state[2]} #{@state[3]} #{@state[4]}"
  end

  def put(values)
    values = values.map(&:to_i)
    @state = @state.zip(values).map{|x| x[0] + x[1]}
    show
  end

  def take(values)
    values = values.map(&:to_i)
    @state = @state.zip(values).map{|x| x[0] - x[1]}
    show
  end

  def change(value)
    calculate_change([0,0,0,0,0], @state, value.to_i)
  end

  private
  def calculate_change(candidate, coins, value)
    (0..4).each do |level|
      next if coins[level] == 0
      next if VALUES[level] > value
      if value == VALUES[level]
        candidate[level] += 1
        return candidate
      else
        trial_candidate = candidate
        trial_coins = coins
        trial_candidate[level] += 1
        trial_coins[level] -= 1
        trial = calculate_change(trial_candidate, trial_coins, value - VALUES[level])
        return trial if trial
      end
    end
    return false
  end
end
