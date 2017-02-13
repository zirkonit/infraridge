package com.lutrovnik.register

class Register {
  type Bills = Array[Int]

  var state = new Bills(5)
  val consts = Array(20, 10, 5, 2, 1)

  def show : String = {
    s"$$$total ${state(0)} ${state(1)} ${state(2)} ${state(3)} ${state(4)}"
  }

  def total : Int = {
    state.zip(consts).map( x => x._1 * x._2).sum
  }

  def put(values:Array[String]) : String = {
    if(values.length == 5) {
      var ints = values.map( x => x.toInt )
      state = state.zip(ints).map( x => x._1 + x._2)
      show
    } else {
      "Should have exactly 5 arguments"
    }
  }

  def take(values:Array[String]) : String = {
    if(values.length == 5) {
      var ints = values.map( x => x.toInt )
      var new_state = state.zip(ints).map( x => x._1 - x._2)
      if(new_state.min >= 0) {
        state = new_state
        show
      } else {
        "Register doesn't have so much money"
      }
    } else {
      "Should have exactly 5 arguments"
    }
  }

  def change(value:String) : String = {
    var change_returned = calculate_change(Array(0,0,0,0,0), state, value.toInt)
    change_returned match {
      case Some(change_returned) => 
        take(change_returned.map(_.toString)); change_returned.mkString(" ")
      case None => 
        "sorry"
    }
  }

  private[this] def calculate_change(candidate:Bills, bills:Bills, value:Int) : Option[Bills] = {
    for (level <- 0 to 4 if bills(level) != 0 && consts(level) <= value) { 
      if(value == consts(level)) {
        candidate(level) += 1
        return(Some(candidate))
      } else {
        var trial_candidate = candidate.clone
        var trial_bills = bills.clone
        trial_candidate(level) += 1
        trial_bills(level) -= 1
        var trial_value = value - consts(level)
        val trial = calculate_change(trial_candidate, trial_bills, trial_value)
        trial match {
          case Some(trial) => return(Some(trial))
          case None => ()
        }
      }
    }
    None
  }
}
