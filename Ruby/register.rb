class Register
  attr_accessor :state
  VALUES = [20, 10, 5, 2, 1]

  def initialize
    @state = [0, 0, 0, 0, 0]
  end

  # Total by summing up the dollar value of state. 
  def total
    @state[0]*VALUES[0] + @state[1]*VALUES[1] + @state[2]*VALUES[2] + @state[3]*VALUES[3] + @state[4]*VALUES[4]
  end

  # Register state formatted as $XX Y Y Y Y Y.
  def show
    "$#{total} #{@state[0]} #{@state[1]} #{@state[2]} #{@state[3]} #{@state[4]}"
  end

  # Puts _values_ amount of bills to the register
  def put(values)
    return "Should have exactly 5 arguments" unless values.length == 5
    values = values.map(&:to_i)
    @state = @state.zip(values).map{|x| x[0] + x[1]}
    show
  end

  # If enough bills, returns _values_ bills from the registr
  def take(values)
    return "Should have exactly 5 arguments" unless values.length == 5
    values = values.map(&:to_i)
    new_state = @state.zip(values).map{|x| x[0] - x[1]}
    if new_state.min >= 0
      @state = new_state
      show
    else
      "Register doesn't have so much money"
    end
  end

  # If it is possible to give change for _value_, substract the change from the
  # state and display the changed coins. “Sorry” if it's not possible. Recursive
  # function calculate_change does the actual calculations.
  def change(value)
    change_returned = calculate_change([0,0,0,0,0], @state, value.to_i)
    if change_returned
      take(change_returned)
      change_returned.join(" ")
    else
      "sorry"
    end
  end

  private
  # The workhorse calculator method.
  def calculate_change(candidate, bills, remaining)
    (0..4).each do |level|
      # Try giving out change at every bills level, skipping denominations that
      # don't have any bills or are bigger than the current change amount.
      next if bills[level] == 0
      next if VALUES[level] > remaining
      # If the denomination is equal to the change remaining, add this bill to
      # change and return the change amount.
      if remaining == VALUES[level]
        candidate[level] += 1
        return candidate
      else
        # Otherwise, recursively try adding the bill to the change amount. If
        # this branch is successful, it will be returned; otherwise, we'll skip
        # to the next denomination
        trial_candidate = candidate.dup
        trial_bills = bills.dup
        trial_remaining = remaining
        trial_candidate[level] += 1
        trial_bills[level] -= 1
        trial_remaining -= VALUES[level]
        trial = calculate_change(trial_candidate, trial_bills, trial_remaining)
        return trial if trial
      end
    end
    false
  end
end
